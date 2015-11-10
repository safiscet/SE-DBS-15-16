import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import com.baseprogramming.dev.gen.DataFactory;
import com.opencsv.CSVReader;

public class ElectorGenerator {

	// KONFIGURATION
	// Einträge der Tabelle zuerst löschen?
	static boolean DELETE_FIRST = false;
	// Ab welchem Wahlkreis soll begonnen werden? Standard: 1
	static int BEGIN = 1;

	static Connection con;
	static List<Wahlkreis> wahlkreise;

	public static void main(String[] args) {
		try {
			connect();
			initWahlkreise();
			if (DELETE_FIRST)
				deleteElectors();
			insertElectors();
		} catch (SQLException e) {
			System.out.println(e);
		} catch (IOException e) {
			System.out.println(e);
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public static void connect() {
		con = null;
		try {
			Class.forName("org.postgresql.Driver");
			con = DriverManager
					.getConnection(
							"jdbc:postgresql://localhost:5432/bundestagswahlergebnisse",
							"postgres", "admin");
			con.setAutoCommit(false);
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println(e.getClass().getName() + ": " + e.getMessage());
			System.exit(0);
		}
		System.out.println("Opened database successfully");
	}

	// CSV-Schema: WahlkreisID, Wahlberechtigte 2009, Wähler 2009,
	// Wahlberechtigte 2013, Wähler 2013
	public static void initWahlkreise() throws IOException {
		CSVReader reader = new CSVReader(new FileReader("numberofvotes.csv"),
				';');
		Wahlkreis w;
		wahlkreise = new ArrayList<Wahlkreis>();
		String[] nextLine;
		while ((nextLine = reader.readNext()) != null) {
			w = new Wahlkreis();
			w.setId(Integer.parseInt(nextLine[0]));
			w.setResidents2009(Integer.parseInt(nextLine[1]));
			w.setVote2009(Integer.parseInt(nextLine[2]));
			w.setResidents2013(Integer.parseInt(nextLine[3]));
			w.setVote2013(Integer.parseInt(nextLine[4]));
			wahlkreise.add(w);
		}
		reader.close();
		for(int i = 1; i < BEGIN; i++){
			wahlkreise.remove(0);
		}
	}

	public static void insertElectors() throws SQLException {
		String sql = "INSERT INTO elector (name, sex, birthday, wahlkreis2009, wahlkreis2013, vote2009, vote2013) VALUES (?, ?, ?, ?, ?, ?, ?) ";
		PreparedStatement stmt = con.prepareStatement(sql);
		DataFactory.loadAllCensusNames();
		Random ran = new Random();
		StringBuilder builder;
		int counter = 0;
		for (Wahlkreis w : wahlkreise) {
			int maxResidents = w.getResidents2009() > w.getResidents2013() ? w
					.getResidents2009() : w.getResidents2013();
			int genKreis09 = w.getResidents2009();
			int genKreis13 = w.getResidents2013();
			int genVote09 = w.getVote2009();
			int genVote13 = w.getVote2013();
			for (int i = 0; i < maxResidents; i++) {
				if (counter % 100000 == 0)
					System.out.println("Generated " + counter
							+ " lines. Currently in wahlkreis " + w.getId());
				boolean male = ran.nextBoolean();
				// generate name
				builder = new StringBuilder();
				builder.append(DataFactory.getLastName().getWord());
				builder.append(" ");
				if (male)
					builder.append(DataFactory.getMaleFirstName().getWord());
				else
					builder.append(DataFactory.getFemaleFirstName().getWord());
				stmt.setString(1, builder.toString());
				// generate sex
				if (male)
					stmt.setString(2, "m");
				else
					stmt.setString(2, "f");
				// generate birthday
				stmt.setDate(
						3,
						new java.sql.Date(DataFactory.genDate(2009 - 90,
								2009 - 18).getTime()));
				// generate wahlkreis2009
				if (genKreis09 > 0)
					stmt.setInt(4, w.getId());
				else
					stmt.setNull(4, java.sql.Types.INTEGER);
				// generate wahlkreis2013
				if (genKreis13 > 0)
					stmt.setInt(5, w.getId());
				else
					stmt.setNull(5, java.sql.Types.INTEGER);
				// generate vote2009
				stmt.setBoolean(6, genVote09 > 0);
				// generate vote2013
				stmt.setBoolean(7, genVote13 > 0);
				stmt.addBatch();
				genKreis09--;
				genKreis13--;
				genVote09--;
				genVote13--;
				counter++;
			}
			stmt.executeBatch();
			con.commit();
			System.out.println("Generated " + maxResidents
					+ " electors for Wahlkreis " + w.getId());
		}
		stmt.close();
	}

	public static void deleteElectors() throws SQLException {
		Statement stmt = con.createStatement();
		stmt.execute("DELETE FROM elector");
		stmt.close();
	}
}

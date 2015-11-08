import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import com.baseprogramming.dev.gen.DataFactory;

public class ElectorGenerator {

	static Connection con;
	static List<Wahlkreis> wahlkreise;

	public static void main(String[] args) {
		try {
			connect();
			wahlkreise = getWahlkreise(2009);
			deleteElectors();
			insertElectors(2009);
			con.close();
		} catch (SQLException e) {
			System.out.println(e);
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

	public static List<Wahlkreis> getWahlkreise(int year) {
		List<Wahlkreis> wahlkreise = new ArrayList<Wahlkreis>();
		Statement stmt = null;
		try {
			stmt = con.createStatement();
			ResultSet kreise = stmt
					.executeQuery("SELECT id, name, residents, year FROM wahlkreis WHERE year ="
							+ year + ";");
			Wahlkreis kreis;
			while (kreise.next()) {
				kreis = new Wahlkreis();
				kreis.setId(kreise.getInt("id"));
				kreis.setName(kreise.getString("name"));
				kreis.setResidents(kreise.getInt("residents"));
				kreis.setYear(kreise.getInt("year"));
				wahlkreise.add(kreis);
			}
			kreise.close();
			stmt.close();
		} catch (Exception e) {
			System.err.println(e.getClass().getName() + ": " + e.getMessage());
			System.exit(0);
		}
		return wahlkreise;
	}

	public static void insertElectors(int year) throws SQLException {
		String sql = "INSERT INTO elector (name, sex, birthday, year, wahlkreis) VALUES (?, ?, ?, ?, ?) ";
		PreparedStatement stmt = con.prepareStatement(sql);
		DataFactory.loadAllCensusNames();
		Random ran = new Random();
		StringBuilder builder;
		for (Wahlkreis w : wahlkreise) {
			for (int i = 0; i < w.getResidents(); i++) {
				boolean male = ran.nextBoolean();
				builder = new StringBuilder();
				builder.append(DataFactory.getLastName().getWord());
				builder.append(" ");
				if (male)
					builder.append(DataFactory.getMaleFirstName().getWord());
				else
					builder.append(DataFactory.getFemaleFirstName().getWord());
				stmt.setString(1, builder.toString());
				if (male)
					stmt.setString(2, "m");
				else
					stmt.setString(2, "f");
				stmt.setDate(
						3,
						new java.sql.Date(DataFactory.genDate(year - 90,
								year - 18).getTime()));
				stmt.setInt(4, year);
				stmt.setInt(5, w.getId());
				stmt.executeUpdate();
			}
			con.commit();
			System.out.println("inserted " + w.getResidents()
					+ " electors from wahlkreis + " + w.getName());
		}
		stmt.close();
	}

	public static void deleteElectors() throws SQLException {
		Statement stmt = con.createStatement();
		stmt.execute("DELETE FROM elector");
		stmt.close();
	}
}

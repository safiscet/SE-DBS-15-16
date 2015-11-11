import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import com.baseprogramming.dev.gen.DataFactory;
import com.opencsv.CSVParser;
import com.opencsv.CSVReader;

public class MissingCandidatesGenerator {

	// arrays for party id, erststimmen, zweistimmen, candidates with the same
	// index (ordered as in the csv source)
	// index 0 = invalid votes
	static List<Integer> partyIds;
	static List<Integer> erststimmen;
	static List<Integer> zweitstimmen;
	static List<List<Integer>> candidates;

	static HashMap<Integer, List<Integer>> done = new HashMap<Integer, List<Integer>>();

	// total number of votes in the current wahlkreis
	static int totalVotes;

	// current year to generate
	static int year;
	// current wahlkreis id
	static int wahlkreis;

	static int id = 7067;

	// Array from csv source
	static List<String[]> csv;

	static Connection con;

	static File file;

	static FileWriter fw;
	static BufferedWriter bw;

	static final int YEAR_TO_DO = 2013;

	public static void main(String[] args) {
		try {
			init(YEAR_TO_DO);

			for (int i = 0; i < partyIds.size(); i++) {
				done.put(partyIds.get(i), new ArrayList<Integer>());
			}

			file = new File("missingCandidates" + year + ".txt");
			if (!file.exists()) {
				file.createNewFile();
			}
			fw = new FileWriter(file.getAbsoluteFile());
			bw = new BufferedWriter(fw);

			for (int i = 0; i < 299; i++) {
				initWahlkreis(i + 1, csv.get(i));
				generateVotesForWahlkreis();
				System.out.println("finished wahlkreis " + (i + 1));
			}

		} catch (ClassNotFoundException | SQLException | IOException e) {
			e.printStackTrace();
		} finally {
			try {
				bw.close();
				con.close();
			} catch (SQLException | IOException e) {
				e.printStackTrace();
			}
		}
	}

	public static void init(int year) throws ClassNotFoundException,
			SQLException, IOException {
		// set year and establish connection to database
		MissingCandidatesGenerator.year = year;
		connect();
		if (year == 2009) {
			partyIds = Arrays.asList(Parties.party09);
		} else if (year == 2013) {
			partyIds = Arrays.asList(Parties.party13);
		} else {
			System.out.println("invalid year for vote generator");
			System.exit(1);
		}
		// read the csv source
		CSVReader reader = new CSVReader(new FileReader("votedata" + year
				+ ".csv"), ';', CSVParser.DEFAULT_QUOTE_CHARACTER, 2);
		csv = reader.readAll();
		reader.close();

		DataFactory.loadAllCensusNames();
	}

	public static void connect() throws ClassNotFoundException, SQLException {
		con = null;
		Class.forName("org.postgresql.Driver");
		con = DriverManager.getConnection(
				"jdbc:postgresql://localhost:5432/bundestagswahlergebnisse",
				"postgres", "admin");
		con.setAutoCommit(false);
		System.out.println("Opened database successfully");
	}

	public static void initWahlkreis(int wahlkreis, String[] line)
			throws SQLException {
		MissingCandidatesGenerator.wahlkreis = wahlkreis;
		totalVotes = Integer.parseInt(line[0]);
		erststimmen = new ArrayList<Integer>();
		zweitstimmen = new ArrayList<Integer>();
		candidates = new ArrayList<List<Integer>>();
		for (int i = 0; i < partyIds.size(); i++) {
			erststimmen.add(i, Integer.parseInt(line[2 * i + 1]));
			zweitstimmen.add(i, Integer.parseInt(line[2 * i + 2]));
			candidates.add(i, new ArrayList<Integer>());
		}
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT party, candidate "
				+ "FROM candidateinelection WHERE wahlkreis = " + wahlkreis
				+ " AND year = " + year + "ORDER BY party");
		int party, candidate, index;
		while (rs.next()) {
			party = rs.getInt("party");
			candidate = rs.getInt("candidate");
			index = partyIds.indexOf(party);
			candidates.get(index).add(candidate);
		}
		rs.close();
		stmt.close();
	}

	public static void generateVotesForWahlkreis() throws IOException {
		int currentEsParty = 0;
		List<Integer> partyCandidates;
		for (int i = 0; i < totalVotes; i++) {
			// generiere Erststimme
			// hole aktuellen Index
			currentEsParty = getNextIndex(currentEsParty, erststimmen);
			if (currentEsParty == 0) {

			} else {
				// wähle einen Kandidaten
				partyCandidates = candidates.get(currentEsParty);
				if (partyCandidates.size() == 0) {
					// nur beim ersten Durchlauf generieren
					int party = partyIds.get(currentEsParty);
					if (done.get(party).isEmpty()
							|| !done.get(party).contains(wahlkreis))
						generateMissingCandidate(party);
				}
			}
			// aktualisiere erststimmen an currentEsParty
			int count = erststimmen.get(currentEsParty) - 1;
			erststimmen.set(currentEsParty, count);
		}
	}

	public static int getNextIndex(int current, List<Integer> list) {
		int i = current;
		while (i < list.size() && list.get(i) == 0) {
			i++;
		}
		return i;
	}

	public static void generateMissingCandidate(int party) throws IOException {
		String name = DataFactory.getLastName().getWord() + ", "
				+ DataFactory.getMaleFirstName().getWord();
		String content = "INSERT INTO candidate VALUES ("
				+ id
				+ ", '"
				+ name
				+ "', 1960);\n"
				+ "INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland)"
				+ " VALUES (" + id + ", " + year + ", " + party + ", "
				+ wahlkreis + ", " + getFederalLand(wahlkreis) + ");\n\n";
		bw.write(content);
		id++;
		List<Integer> temp = done.get(party);
		temp.add(wahlkreis);
	}

	public static int getFederalLand(int wahlkreis) {
		if (wahlkreis >= 0 && wahlkreis <= 11)
			return 1;
		else if (wahlkreis >= 12 && wahlkreis <= 17)
			return 13;
		else if (wahlkreis >= 18 && wahlkreis <= 23)
			return 2;
		else if (wahlkreis >= 24 && wahlkreis <= 53)
			return 3;
		else if (wahlkreis >= 54 && wahlkreis <= 55)
			return 4;
		else if (wahlkreis >= 56 && wahlkreis <= 65)
			return 12;
		else if (wahlkreis >= 66 && wahlkreis <= 74)
			return 15;
		else if (wahlkreis >= 75 && wahlkreis <= 86)
			return 11;
		else if (wahlkreis >= 87 && wahlkreis <= 150)
			return 5;
		else if (wahlkreis >= 151 && wahlkreis <= 166)
			return 14;
		else if (wahlkreis >= 167 && wahlkreis <= 188)
			return 6;
		else if (wahlkreis >= 189 && wahlkreis <= 197)
			return 16;
		else if (wahlkreis >= 198 && wahlkreis <= 212)
			return 7;
		else if (wahlkreis >= 213 && wahlkreis <= 257)
			return 9;
		else if (wahlkreis >= 258 && wahlkreis <= 295)
			return 8;
		else
			return 10;
	}
}

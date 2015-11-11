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
import java.util.List;
import java.util.Random;

import com.opencsv.CSVParser;
import com.opencsv.CSVReader;
import com.opencsv.CSVWriter;

public class VoteGenerator {

	// KONFIGURATION
	// Jahr das generiert werden soll
	static int YEAR_TO_DO = 2009;
	// zu berücksichtigende Wahlkreise: Einer (ID zwischen 1 und 299) oder alle
	// (0)
	static int WAHLKREISE_TO_DO = 0;

	// arrays for party id, erststimmen, zweistimmen, candidates with the same
	// index (ordered as in the csv source)
	// index 0 = invalid votes
	static List<Integer> partyIds;
	static List<Integer> erststimmen;
	static List<Integer> zweitstimmen;
	static List<List<Integer>> candidates;

	// total number of votes in the current wahlkreis
	static int totalVotes;

	// current year to generate
	static int year;
	// current wahlkreis id
	static int wahlkreis;

	// Array from csv source
	static List<String[]> csv;

	static Connection con;
	static CSVWriter writer;

	public static void main(String[] args) {
		try {
			init(YEAR_TO_DO);
			writer = new CSVWriter(new FileWriter("generatedVotes" + year
					+ ".csv"), ';', CSVWriter.NO_QUOTE_CHARACTER);
			if (WAHLKREISE_TO_DO == 0) {
				for (int i = 0; i < 299; i++) {
					initWahlkreis(i + 1, csv.get(i));
					generateVotesForWahlkreis();
					System.out.println("finished wahlkreis " + (i + 1));
				}
			} else {
				initWahlkreis(WAHLKREISE_TO_DO, csv.get(WAHLKREISE_TO_DO-1));
				generateVotesForWahlkreis();
				System.out.println("finished wahlkreis " + (WAHLKREISE_TO_DO));
			}
		} catch (ClassNotFoundException | SQLException | IOException e) {
			e.printStackTrace();
		} finally {
			try {
				writer.close();
				con.close();
			} catch (SQLException | IOException e) {
				e.printStackTrace();
			}
		}
	}

	public static void init(int year) throws ClassNotFoundException,
			SQLException, IOException {
		// set year and establish connection to database
		VoteGenerator.year = year;
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
		VoteGenerator.wahlkreis = wahlkreis;
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
		int currentZsParty = 0;
		int count, candidate, party;
		String[] entry = new String[4];
		List<Integer> partyCandidates;
		Random ran = new Random();
		for (int i = 0; i < totalVotes; i++) {
			// generiere Erststimme
			// hole aktuellen Index
			currentEsParty = getNextIndex(currentEsParty, erststimmen);
			if (currentEsParty == 0) {
				// generiere ungültige Erststimme
				candidate = 0;
			} else {
				// wähle einen Kandidaten
				partyCandidates = candidates.get(currentEsParty);
				// TODO
				// System.out.println(currentEsParty +
				// ": "+partyIds.get(currentEsParty));
				candidate = partyCandidates.get(ran.nextInt(partyCandidates
						.size()));
			}
			// aktualisiere erststimmen an currentEsParty
			count = erststimmen.get(currentEsParty) - 1;
			erststimmen.set(currentEsParty, count);

			// generiere Zweitstimme
			currentZsParty = getNextIndex(currentZsParty, zweitstimmen);
			party = partyIds.get(currentZsParty);
			// aktualisierte zweitstimmen an currentZsParty
			count = zweitstimmen.get(currentZsParty) - 1;
			zweitstimmen.set(currentZsParty, count);
			entry[0] = Integer.toString(year);
			entry[1] = candidate == 0 ? "" : Integer.toString(candidate);
			entry[2] = party == 0 ? "" : Integer.toString(party);
			entry[3] = Integer.toString(wahlkreis);
			writer.writeNext(entry);
		}
	}

	public static int getNextIndex(int current, List<Integer> list) {
		int i = current;
		while (list.get(i) == 0 && i < list.size()) {
			i++;
		}
		return i;
	}
}

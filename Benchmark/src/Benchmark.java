import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.XMLOutputter;

public class Benchmark {
	public static final String pathToJMeter = "C:/Users/Stefan/Desktop/apache-jmeter-2.13/";
	
	// Command-line parameters
	// -t wait time in milliseconds
	// -d total duration of the test in seconds
	// -w workload Mix, followed by 6 integer values for the percentage of the requests
	// -n number of terminals
	// -p path of the JMeter installation
	// -f file name for the generated test plan file
	
	// e.g. -t 1200 -d 100 -n 15 -w 15 15 15 15 20 20

	// Parameter-Deklarationen
	// Workload-Mix - Array für Q1 - Q6 mit Prozentzahlen (z.B. 25 für 25 %)
	public int[] workloadMix;
	// Durchschnittliche Wartezeit t in ms: Auswahl dann aus [0.8 * t, 1.2 * t]
	public int waitTime;
	// Testdauer in Sekunden
	public int testDuration;
	// Anzahl Terminals n
	public int threadCount;
	// Pfad zum JMeter-Ordner
	public String jmeterPath;
	// Dateiname des zu generierenden Testplans
	public String testPlan;

	public static void main(String[] args) {
		Benchmark benchmark = new Benchmark();
		int i = 0;
		for(String arg : args){
			if(arg.equals("-t"))
				benchmark.waitTime = Integer.parseInt(args[i+1]);
			else if(arg.equals("-d"))
				benchmark.testDuration = Integer.parseInt(args[i+1]);
			else if(arg.equals("-n"))
				benchmark.threadCount = Integer.parseInt(args[i+1]);
			else if(arg.equals("-p"))
				benchmark.jmeterPath = args[i+1];
			else if(arg.equals("-f"))
				benchmark.testPlan = args[i+1];
			else if(arg.equals("-w")){
				benchmark.workloadMix = new int[6];
				for(int j = 0; j < 6; j++)
					benchmark.workloadMix[j] = Integer.parseInt(args[i+1+j]);
			}
			i++;
		}
		benchmark.runBenchmarkTest();
	}

	public Benchmark() {
		// Belege alle Parameter mit Standardwerten
		workloadMix = new int[6];
		workloadMix[0] = 25;
		workloadMix[1] = 10;
		workloadMix[2] = 25;
		workloadMix[3] = 10;
		workloadMix[4] = 10;
		workloadMix[5] = 20;
		waitTime = 1000;
		testDuration = 120;
		threadCount = 20;
		jmeterPath = pathToJMeter;
		testPlan = "PerformanceTest.jmx";
	}
	
	public void runBenchmarkTest(){
		try {
			createTestPlanFromTemplate();
			runJMeter();
		} catch (JDOMException | IOException e) {
			e.printStackTrace();
		}
	}

	public void createTestPlanFromTemplate() throws JDOMException, IOException {
		XMLOutputter out = new XMLOutputter();
		Document doc = new SAXBuilder().build("TestPlanTemplate.jmx");
		Element root = doc.getRootElement();

		// Setze Anzahl Clients und Dauer des Tests in der ThreadGroup
		Element threadGroup = root.getChild("hashTree").getChild("hashTree")
				.getChild("ThreadGroup");
		List<Element> stringProps = threadGroup.getChildren("stringProp");
		for (Element prop : stringProps) {
			if (prop.getAttributeValue("name")
					.equals("ThreadGroup.num_threads")) {
				replaceContent(prop, Integer.toString(threadCount));
			} else if (prop.getAttributeValue("name").equals(
					"ThreadGroup.duration")) {
				replaceContent(prop, Integer.toString(testDuration));
			}
		}
		Element threadGroupHashTree = root.getChild("hashTree")
				.getChild("hashTree").getChild("hashTree");
		// Setze berechnete Wartezeit im UniformRandomTimer
		Element randomTimer = threadGroupHashTree
				.getChild("UniformRandomTimer");
		// delay: 0.8 * t, range: 1.2 * t - delay
		int delay = (int) (0.8 * waitTime);
		int range = (int) (1.2 * waitTime - delay);
		for (Element prop : randomTimer.getChildren("stringProp")) {
			if (prop.getAttributeValue("name").equals("ConstantTimer.delay")) {
				replaceContent(prop, Integer.toString(delay));
			} else if (prop.getAttributeValue("name").equals(
					"RandomTimer.range")) {
				replaceContent(prop, Integer.toString(range));
			}
		}
		// Setze prozentuale Workload pro Abfragen-Controller
		List<Element> controllers = threadGroupHashTree
				.getChildren("ThroughputController");
		int i = 0;
		for (Element controller : controllers) {
			replaceContent(
					controller.getChild("FloatProperty").getChild("value"),
					Integer.toString(workloadMix[i]));
			i++;
		}
		out.output(doc, new FileWriter(testPlan));
	}

	public void replaceContent(Element elem, String content) {
		elem.removeContent();
		elem.addContent(content);
	}

	public void runJMeter() {
		String jmeter = jmeterPath + "bin/ApacheJMeter.jar";
		//String testPlan = jmeterPath + "Wahltest.jmx";
		// pb.directory(new File("preferred/working/directory"));
		ProcessBuilder pb = new ProcessBuilder("java", "-jar", jmeter, "-t",
				testPlan);
		try {
			Process p = pb.start();
			LogStreamReader lsr = new LogStreamReader(p.getInputStream());
			Thread thread = new Thread(lsr, "LogStreamReader");
			thread.start();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	class LogStreamReader implements Runnable {

		private BufferedReader reader;

		public LogStreamReader(InputStream is) {
			this.reader = new BufferedReader(new InputStreamReader(is));
		}

		public void run() {
			try {
				String line = reader.readLine();
				while (line != null) {
					System.out.println(line);
					line = reader.readLine();
				}
				reader.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}

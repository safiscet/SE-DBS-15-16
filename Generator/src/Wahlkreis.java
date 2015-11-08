public class Wahlkreis {

	int id;
	String name;
	int residents;
	int year;

	public Wahlkreis() {

	}

	public Wahlkreis(int id, String name, int residents, int year) {
		this.id = id;
		this.name = name;
		this.residents = residents;
		this.year = year;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getResidents() {
		return residents;
	}

	public void setResidents(int residents) {
		this.residents = residents;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	@Override
	public String toString() {
		return "Wahlkreis [id=" + id + ", name=" + name + ", residents="
				+ residents + ", year=" + year + "]";
	}

}

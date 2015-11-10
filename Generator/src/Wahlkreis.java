public class Wahlkreis {

	int id;
	int residents2009;
	int residents2013;
	int vote2009;
	int vote2013;

	public Wahlkreis() {

	}

	public Wahlkreis(int id, int residents2009, int residents2013,
			int vote2009, int vote2013) {
		super();
		this.id = id;
		this.residents2009 = residents2009;
		this.residents2013 = residents2013;
		this.vote2009 = vote2009;
		this.vote2013 = vote2013;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getResidents2009() {
		return residents2009;
	}

	public void setResidents2009(int residents2009) {
		this.residents2009 = residents2009;
	}

	public int getResidents2013() {
		return residents2013;
	}

	public void setResidents2013(int residents2013) {
		this.residents2013 = residents2013;
	}

	public int getVote2009() {
		return vote2009;
	}

	public void setVote2009(int vote2009) {
		this.vote2009 = vote2009;
	}

	public int getVote2013() {
		return vote2013;
	}

	public void setVote2013(int vote2013) {
		this.vote2013 = vote2013;
	}

	@Override
	public String toString() {
		return "Wahlkreis [id=" + id + ", residents2009=" + residents2009
				+ ", vote2009=" + vote2009 + ", residents2013=" + residents2013
				+ ", vote2013=" + vote2013 + "]";
	}
}

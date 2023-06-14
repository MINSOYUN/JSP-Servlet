package hotel;

public class Hotel {
	
	private String num;
	private String name;
	private String star;
	private String id;
	private String address;
	private String postdate;
	
	
	public Hotel(String num, String name, String star, String id, String address, String postdate) {
		super();
		this.num = num;
		this.name = name;
		this.star = star;
		this.id = id;
		this.address = address;
		this.postdate = postdate;
	}


	public Hotel() {
		// TODO Auto-generated constructor stub
	}


	public String getNum() {
		return num;
	}


	public void setNum(String num) {
		this.num = num;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getStar() {
		return star;
	}


	public void setStar(String star) {
		this.star = star;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getPostdate() {
		return postdate;
	}


	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}
	
}

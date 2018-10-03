package gaia3d.domain;

public enum APIURL {

	CONVERTER("/converter/images");
	
	private String url;
	
	APIURL(String url) {
		this.url = url;
	}
	
	public String getUrl() {
		return this.url;
	}
}

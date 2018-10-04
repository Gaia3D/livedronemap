package gaia3d.domain;

public enum APIURL {
	GEOSERVER_IMAGES("/geoserver/images"),
	GEOSERVER_LAYERS("/geoserver/layers");
	
	private String url;
	
	APIURL(String url) {
		this.url = url;
	}
	
	public String getUrl() {
		return this.url;
	}
}

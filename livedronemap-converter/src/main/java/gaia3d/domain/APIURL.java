package gaia3d.domain;

public enum APIURL {
	GEOSERVER_IMAGES("/geoserver/images"),
	GEOSERVER_LAYERS_ORTHO_IMAGES("/geoserver/layers/ortho-images"),
	GEOSERVER_LAYERS_POSTPROCESSING_IMAGES("/geoserver/layers/postprocessing-images");
	
	private String url;
	
	APIURL(String url) {
		this.url = url;
	}
	
	public String getUrl() {
		return this.url;
	}
}

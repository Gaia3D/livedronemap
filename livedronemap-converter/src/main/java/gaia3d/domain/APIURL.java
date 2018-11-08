package gaia3d.domain;

public enum APIURL {
	GEOSERVER_IMAGES("/geoservers/images"),
	GEOSERVER_LAYERS_ORTHO_IMAGES("/geoservers/layers/ortho-images"),
	GEOSERVER_LAYERS_POSTPROCESSING_IMAGES("/geoservers/layers/postprocessing-images"),
	ORTHO_IMAGES("/ortho-images"),
	POSTPROCESSING_IMAGES("/postprocessing-images"),
	SIMULATION("/simulations"),
	PROJECT("/drone-projects");
	
	private String url;
	
	APIURL(String url) {
		this.url = url;
	}
	
	public String getUrl() {
		return this.url;
	}
}

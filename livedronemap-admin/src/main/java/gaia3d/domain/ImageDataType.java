package gaia3d.domain;

public enum ImageDataType {
	ORTHO_IMAGE("0"), POSTPROCESSING_IMAGE("1");
	
	private String dataType;
	
	ImageDataType(String dataType) {
		this.dataType = dataType;
	}
	
	public String getDataType() {
		return dataType;
	}
	
}

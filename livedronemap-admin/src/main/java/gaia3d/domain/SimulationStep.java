package gaia3d.domain;

public enum SimulationStep {
	ALL("0"), CLIENT("1"), INNER("2");
	
	private String code;
	
	SimulationStep(String code) {
		this.code = code;
	}
	
	public String getCode() {
		return code;
	}
	
}

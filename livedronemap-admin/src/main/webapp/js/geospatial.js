var imageryProvider = new Cesium.ArcGisMapServerImageryProvider({
	url : 'https://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer',
	enablePickFeatures: false
});

function cameraFlyTo(longitude, latitude, altitude, duration) {
	viewer.camera.flyTo({
		destination: Cesium.Cartesian3.fromDegrees(	parseFloat(longitude),
													parseFloat(latitude),
													parseFloat(altitude)
		),
		duration: parseInt(duration)
	});
}
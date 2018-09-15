<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <!-- Use correct character set. -->
  <meta charset="utf-8">
  <!-- Tell IE to use the latest, best version. -->
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <!-- Make the application on mobile take up the full browser screen and disable user scaling. -->
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
  <title>Hello World!</title>
  <script type="text/javascript" src="/externlib/cesium_org/Cesium.js"></script>
  <link rel="stylesheet" href="/externlib/cesium_org/Widgets/widgets.css" />
  
  <style>
      html, body, #cesiumContainer {
          width: 100%; height: 100%; margin: 0; padding: 0; overflow: hidden;
      }
  </style>
  <script>
  	function flyToPosition(viewer, lon, lat, alt, heading, pitch, duration){
	   	 viewer.camera.flyTo({
	           destination : Cesium.Cartesian3.fromDegrees(lon, lat, alt),
	           orientation : {
	               heading : Cesium.Math.toRadians(heading),
	               pitch : Cesium.Math.toRadians(pitch),
	               roll : 0.0
	           },
	   		duration: duration
	       });
	   }	    
  </script>
</head>
<body>
  <div id="cesiumContainer"></div>
  <script> 	
    var viewer = new Cesium.Viewer('cesiumContainer');
    
    flyToPosition(viewer, 126.08588218688966, 36.636128043375784, 1200, 0, -90, 6);
    
  </script>
</body>
</html>

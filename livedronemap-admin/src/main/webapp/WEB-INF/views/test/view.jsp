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
<div id="magoContainer"></div>
<script> 	
	var viewer = new Cesium.Viewer('cesiumContainer'); 
    flyToPosition(viewer, 126.08588218688966, 36.636128043375784, 1200, 0, -90, 6);
    
	var managerFactory = null;
	var policyJson = "/WEB-INF/views/test/mago3d-policy-cesium.json"
	var insertIssueEnable = false;
		
	var imagePath = "/images";

	magoStart(null, "magoContainer", imagePath);
	var intervalCount = 0;
	var timerId = setInterval("startMogoUI()", 1000);
		
	function startMogoUI() {
		intervalCount++;
		if(managerFactory != null && managerFactory.getMagoManagerState() === CODE.magoManagerState.READY) {
			clearInterval(timerId);
			console.log(" managerFactory != null, managerFactory.getMagoManagerState() = " + managerFactory.getMagoManagerState() + ", intervalCount = " + intervalCount);
			return;
		}
		console.log("--------- intervalCount = " + intervalCount);
	}
	
	// mago3d 시작, 정책 데이터 파일을 로딩
	function magoStart() {
		var initProjectsLength = ${initProjectsLength};
		if(initProjectsLength === null || initProjectsLength === 0) {
			managerFactory = new ManagerFactory(null, "magoContainer", policyJson, null, null, null, imagePath);
		} else {
			var projectIdArray = new Array(initProjectsLength);
			var projectDataArray = new Array(initProjectsLength);
			var projectDataFolderArray = new Array(initProjectsLength);
			var index = 0;
			for(var projectId in initProjectJsonMap) {
				projectIdArray[index] = projectId;
				var projectJson = JSON.parse(initProjectJsonMap[projectId]);
				projectDataArray[index] = projectJson;
				projectDataFolderArray[index] = projectJson.data_key;
				index++;
			}
			
			managerFactory = new ManagerFactory(null, "magoContainer", policyJson, projectIdArray, projectDataArray, projectDataFolderArray, imagePath);			
		}
	}
	

</script>
</body>
</html>

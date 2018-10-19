<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>프로젝트 상세 | LiveDroneMap</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/${lang}/style.css">
	<link rel="stylesheet" href="/css/${lang}/live-drone-map.css">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/cesium_orgin/Widgets/widgets.css?cache_version=${cache_version}" /> 
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/cesium_orgin/Cesium.js"></script>
	<style>
		.mapWrap {
			min-width: 1420px;
			padding-left: 391px;
			height:100%;
		}
	</style>
</head>

<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="wrap" style="height:94.7%; width: 100%;">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<!-- S: 1depth / 프로젝트 목록 -->
	<div id="leftMenuArea" class="subWrap">
		<!-- S: 프로젝트 제목, 목록가기, 닫기 -->
		<div class="subHeader">
			<h2>${droneProject.drone_project_name}</h2>
			<div class="ctrlBtn">
				<a href="/drone-project/list-drone-project?${searchParameters}" style="padding-top:3px; font-size:16px; color: #fff;">목록</a>
				<button type="button" title="닫기" class="close">닫기</button>
			</div>
		</div>
		<!-- E: 프로젝트 제목, 목록가기, 닫기 -->
		
		<!-- S: 프로젝트 정보 -->
		<ul class="projectInfo">
			<li>
				<label class="step">진행단계</label>
<c:if test="${droneProject.status eq '0'}">
						<span style="display: inline-block; width: 100px; color: gray; font-weight: bold;">
						준비중
						</span>
</c:if>
<c:if test="${droneProject.status eq '1'}">
						<span style="display: inline-block; width: 100px; color: gray; font-weight: bold;">
						점검/테스트
						</span>
</c:if>
<c:if test="${droneProject.status eq '2'}">
						<span style="display: inline-block; width: 100px; color: #19cc3c; font-weight: bold;">
						개별 정사영상
						</span>
</c:if>
<c:if test="${droneProject.status eq '3'}">
						<span style="display: inline-block; width: 100px; color: blue; font-weight: bold;">
						후처리 영상
						</span>
</c:if>
<c:if test="${droneProject.status eq '4'}">
						<span style="display: inline-block; width: 100px; color: gray; font-weight: bold;">
						프로젝트 종료
						</span>
</c:if>
<c:if test="${droneProject.status eq '5'}">				
						<span style="display: inline-block; width: 100px; color: red; font-weight: bold;">
						에러
						</span>
</c:if>			
			</li>
			<li class="half" title="개별 정상 영상">
				<label class="js">개별 정사 영상</label>
				<span>${droneProject.ortho_image_count}</span>장
				<ul class="detect">
					<li class="ship">${droneProject.ortho_detected_object_count}</li>
				</ul>
			</li>
			<li class="half" title="후처리영상">
				<label class="hc">후처리영상</label>
				<span>${droneProject.postprocessing_image_count}</span>장</li>
			<li class="half" title="촬영지역"><label class="location">촬영지역</label> ${droneProject.shooting_area}</li>
			<li class="half" title="촬영일자"><label class="date" >촬영일자</label> ${droneProject.viewShootingDate}</li>
		</ul>
		<!-- E: 프로젝트 정보 -->
				
		<div class="subContents">
			<div class="count" style="height:30px; padding-top:5px;">
				<spring:message code='all.d'/> <em><fmt:formatNumber value="${transferDataListSize}" type="number"/></em> <spring:message code='search.what.count'/>
				<span style="display: inline-block; float: right;">개별(O) | 후처리(P)</span>
			</div>
			<div class="transferDataList" style="max-height: 500px;">
				<table class="list-table scope-col">
					<col class="col-number" />
					<col class="col-toggle" />
					<col class="col-name" />
					<thead>
						<tr>
							<th scope="col" class="col-number"><spring:message code='number'/></th>
							<th scope="col" class="col-toggle">상태</th>
							<th scope="col" class="col-name" style="width: 68%;">[구분] 파일명 (탐지)</th>
						</tr>
					</thead>
					<tbody>
<c:if test="${empty transferDataList }">
						<tr>
							<td colspan="3" class="col-none">전송 이력이 존재하지 않습니다.</td>
						</tr>
</c:if>
<c:if test="${!empty transferDataList }">
	<c:forEach var="transferData" items="${transferDataList}" varStatus="status">
						<tr>
							<td class="col-number" >
								${transferDataListSize - status.index }
							</td>
							<td class="col-toggle">
								<span class="icon-text">
		<c:if test="${transferData.status eq '0'}">
									전송
		</c:if>
		<c:if test="${transferData.status eq '1'}">
									완료
		</c:if>
		<c:if test="${transferData.status eq '2'}">
									실패
		</c:if>
		<c:if test="${transferData.status eq '3'}">
									에러
		</c:if>									
								</span>
							</td>
							<td class="col-number">
		<c:if test="${transferData.data_type eq '0'}">					
								[ O ]
		</c:if>
		<c:if test="${transferData.data_type eq '1'}">					
								[ P ]
		</c:if>
								<a href="#" class="view-group-detail" 
									onclick="refreshDroneImage('${transferData.drone_project_id}', 
																'${transferData.transfer_data_id}', 
																'${transferData.data_type}', 
																'${transferData.viewLayerShootingDate}'); return false;">${transferData.file_name }</a>
								(${transferData.ortho_detected_object_count })
							</td>
						</tr>
	</c:forEach>
</c:if>
					</tbody>
				</table>
			</div>
		</div>
		<!-- E: 영상목록 -->
	</div>
	<!-- E: 1depth / 프로젝트 목록 -->
	
	<div id="droneMapContainer" class="mapWrap">
	</div>
	<!-- E: MAPWRAP -->
</div>
<!-- E: wrap -->
	
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/live-drone-map.js"></script>
<script type="text/javascript">
	// TODO mago3D에 Cesium.ion key 발급 받아서 세팅한거 설명 듣고 Terrain 바꿔 주세요.
	// TODO 데이터가 없을때 layer 예외 처리도 해야 함
	
	// 드론 촬영 이미지를 그리는 geoserver layer
	var DRONE_IMAGE_PROVIDER = null;
	// 객체 탐지를 그리는 geoserver layer
	var DETECTED_OBJECTS_PROVIDER = null; 
	
  	var viewer = new Cesium.Viewer('droneMapContainer', {imageryProvider : imageryProvider, baseLayerPicker : true, animation:false, timeline:false, fullscreenButton:false});
  	$(document).ready(function() {
  		cameraFlyTo("${droneProject.location_longitude}", "${droneProject.location_latitude}", 500, 3);
		drawDroneProject();
		drawDetailDroneImage("${viewTransferData.viewLayerShootingDate}", "livedronemap:livedronemap_${viewTransferData.drone_project_id}_${viewTransferData.data_type}");
		drawDetectedObjects("transfer_data_id=${viewTransferData.transfer_data_id}", "livedronemap:view_ortho_detected_object");
	});
  	
	// 2.5초 후에 드론 비행 경로를 그림
   	var droneMovingPathTimer = setTimeout(function() {
		drawDroneMovingPath();
   	}, 2500);

	// 클릭 프로젝트
   	function drawDroneProject() {
   		drawDroneProjectLine(	"${droneProject.drone_project_name}", 
				"${droneProject.shooting_longitude1}", "${droneProject.shooting_latitude1}",
				"${droneProject.shooting_longitude2}", "${droneProject.shooting_latitude2}");
		drawDroneProjectLine(	"${droneProject.drone_project_name}", 
		"${droneProject.shooting_longitude1}", "${droneProject.shooting_latitude1}",
		"${droneProject.shooting_longitude3}", "${droneProject.shooting_latitude3}");
		drawDroneProjectLine(	"${droneProject.drone_project_name}", 
		"${droneProject.shooting_longitude2}", "${droneProject.shooting_latitude2}",
		"${droneProject.shooting_longitude4}", "${droneProject.shooting_latitude4}");
		drawDroneProjectLine(	"${droneProject.drone_project_name}", 
		"${droneProject.shooting_longitude3}", "${droneProject.shooting_latitude3}",
		"${droneProject.shooting_longitude4}", "${droneProject.shooting_latitude4}");
    }
   	function drawDroneProjectLine(projectName, startLongitude, startLatitude, endLongitude, endLatitude) {
		viewer.entities.add({
			name : projectName,
			polyline : {
			positions : Cesium.Cartesian3.fromDegreesArray([parseFloat(startLongitude), parseFloat(startLatitude),
															parseFloat(endLongitude), parseFloat(endLatitude)]),
				width : 5,
				material : Cesium.Color.RED,
				clampToGround : true
			}
		});
	}
   	
   	// 드론 이미지를 geoserver layer를 이용해서 그림
   	function drawDetailDroneImage(shootingDate, layerName) {
	   	if(DRONE_IMAGE_PROVIDER !== null && DRONE_IMAGE_PROVIDER !== undefined) {
	    	viewer.imageryLayers.remove(DRONE_IMAGE_PROVIDER, true);
	    }
	   	
	   	var provider = new Cesium.WebMapServiceImageryProvider({
			url : '${policy.geoserver_data_url}/wms',
			//url : '${geoserverUrl}${geoserverServiceWms}',
			layers : layerName,
			parameters : {
				service : 'WMS',
				version : '1.1.1',
				request : 'GetMap',
				transparent : 'true',
				tiled : 'true',
				//format : 'image/png',
				format : 'image/png',
				//time : 'P2Y/PRESENT',
				time : shootingDate,
		    	//rand:rand,
				maxZoom : 25,
				maxNativeZoom : 23,
				//CQL_FILTER: queryString
				//bjcd LIKE '47820253%' AND name='청도읍'
			},
			//,proxy: new Cesium.DefaultProxy('/proxy/')
			enablePickFeatures: false
		});
	    
		DRONE_IMAGE_PROVIDER = viewer.imageryLayers.addImageryProvider(provider);
   	}
   	
   	// 객체 탐지를 geoserver layer를 이용해서 그림
	function drawDetectedObjects(queryString, layerName) {
   		// cache 막으려고 5초에 한번씩
   		var now = new Date();
		var rand = ( now - now % 5000) / 5000;
   		
   		if(DETECTED_OBJECTS_PROVIDER !== null && DETECTED_OBJECTS_PROVIDER !== undefined) {
	    	viewer.imageryLayers.remove(DETECTED_OBJECTS_PROVIDER, true);
	    }
	   	
	    var provider = new Cesium.WebMapServiceImageryProvider({
			url : '${policy.geoserver_data_url}/wms',
			layers : layerName,
			parameters : {
				service : 'WMS'
				,version : '1.1.1'
				,request : 'GetMap'
				,transparent : 'true'
				//,tiled : 'true'
				,format : 'image/png'
				//,time : 'P2Y/PRESENT'
		    	,rand:rand
				//,maxZoom : 25
				//,maxNativeZoom : 23
				,CQL_FILTER: queryString
				//bjcd LIKE '47820253%' AND name='청도읍'
			}
			//,proxy: new Cesium.DefaultProxy('/proxy/')
			,enablePickFeatures: false
		});
	    
		DETECTED_OBJECTS_PROVIDER = viewer.imageryLayers.addImageryProvider(provider);
   	}

	// 드론 이동 경로 표시    
    function drawDroneMovingPath() {
   		var transferDataList = new Array();
<c:if test="${!empty transferDataList }">
	<c:forEach var="transferData" items="${transferDataList}" varStatus="status">
		transferDataList.push("${transferData.drone_longitude}");
		transferDataList.push("${transferData.drone_latitude}");
		transferDataList.push("${transferData.drone_altitude}");
	</c:forEach>
</c:if>
		viewer.entities.add({
		    name : '드론 비행 경로',
		    polyline : {
		        positions : Cesium.Cartesian3.fromDegreesArrayHeights(transferDataList),
		        width : 5,
		        material : new Cesium.PolylineDashMaterialProperty({
		            color : Cesium.Color.ORANGE,
		            dashLength: 8.0
		        })
		    }
		});
		
		// 드론 이미지
		viewer.entities.add({
	        position : Cesium.Cartesian3.fromDegrees(parseFloat(transferDataList[0]), parseFloat(transferDataList[1]), parseFloat(transferDataList[2])),
	        billboard : {
	            image : '/images/drone.png',
	            width : 25, // default: undefined
	            height : 25 // default: undefined
	            /* image : '../images/Cesium_Logo_overlay.png', // default: undefined
	            show : true, // default
	            pixelOffset : new Cesium.Cartesian2(0, -50), // default: (0, 0)
	            eyeOffset : new Cesium.Cartesian3(0.0, 0.0, 0.0), // default
	            horizontalOrigin : Cesium.HorizontalOrigin.CENTER, // default
	            verticalOrigin : Cesium.VerticalOrigin.BOTTOM, // default: CENTER
	            scale : 2.0, // default: 1.0
	            color : Cesium.Color.LIME, // default: WHITE
	            rotation : Cesium.Math.PI_OVER_FOUR, // default: 0.0
	            alignedAxis : Cesium.Cartesian3.ZERO, // default
	            width : 100, // default: undefined
	            height : 25 // default: undefined */
	        }
	    });
    }
	
   	viewer.zoomTo(viewer.entities);
   	
   	// 파일 클릭시 drome image, 객체 탐지 geoserver layer를 다시 그림
   	function refreshDroneImage(droneProjectId, transferDataId, dataType, shootingDate) {
		// TODO 이동할 위치 정보가 없음. image point를 받아야 함
   		//cameraFlyTo("${droneProject.location_longitude}", "${droneProject.location_latitude}", 500, 3);
   		drawDetailDroneImage(shootingDate, "livedronemap:livedronemap_" + droneProjectId + "_" + dataType);
   		drawDetectedObjects("transfer_data_id=" + transferDataId, "livedronemap:view_ortho_detected_object");
   	}
   			
   	 // 현재 클릭 포인트 위치 좌표.
   	viewer.canvas.addEventListener('click', function(e){
   	    var mousePosition = new Cesium.Cartesian2(e.clientX, e.clientY);
   	    var ellipsoid = viewer.scene.globe.ellipsoid;
   	    var cartesian = viewer.camera.pickEllipsoid(mousePosition, ellipsoid);
   	    if (cartesian) {
   	        var cartographic = ellipsoid.cartesianToCartographic(cartesian);
   	        var longitudeString = Cesium.Math.toDegrees(cartographic.longitude);
   	        var latitudeString = Cesium.Math.toDegrees(cartographic.latitude);
   	        console.log(longitudeString + ', ' + latitudeString);
   	    } else {
   	        console.log('Globe was not picked');
   	    }
   		
   	}, false);
</script>
</body>
</html>

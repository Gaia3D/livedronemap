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
	<script type="text/javascript" src="/externlib/jquery/fixedheadertable.js"></script>
	<script type="text/javascript" src="/externlib/cesium_orgin/Cesium.js"></script>
	<style>
		.mapWrap {
			min-width: 1420px;
			padding-left: 391px;
			height:100%;
		}
		
		/* table scroll start */
		
		th.col-name {
			width: 68%;
		}
				
		.fht-table {
			/* appearance */
		    border-collapse: collapse;
		    border-spacing: 0;
		}
		
		.fht-table-wrapper,
		.fht-table-wrapper .fht-thead,
		.fht-table-wrapper .fht-tfoot,
		.fht-table-wrapper .fht-fixed-column .fht-tbody,
		.fht-table-wrapper .fht-fixed-body .fht-tbody,
		.fht-table-wrapper .fht-tbody {
			/* appearance */
			overflow: hidden;
			
			/* position */
			position: relative;
		}
	
		.fht-table-wrapper .fht-fixed-body .fht-tbody,
		.fht-table-wrapper .fht-tbody {
			/* appearance */
		    overflow: auto;
		}
	
		.fht-table-wrapper .fht-table .fht-cell {
			/* appearance */
			overflow: hidden;
			
			/* size */
		    height: 1px;
		}
		
		.fht-table-wrapper .fht-fixed-column,
		.fht-table-wrapper .fht-fixed-body {
		    /* position */
		    top: 0;
		    left: 0;
		    position: absolute;
	    }
		    
		.fht-table-wrapper .fht-fixed-column {
		    /* position */
		    z-index: 1;
	    }
		
		/* table scroll end */
		
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
				<a href="/drone-project/list-drone-project?${searchParameters}" style="padding-top:3px; font-size:13px; color: #fff;">목록 보기</a>
			</div>
		</div>
		<!-- E: 프로젝트 제목, 목록가기, 닫기 -->
		
		<!-- S: 프로젝트 정보 -->
		<ul id="projectInfo" class="projectInfo">
						<li class="half" title="촬영일자"><label class="date" >촬영일자</label>${droneProject.viewShootingDate}</li>
						<li class="half">
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
						
						<li title="촬영지역"><label class="location">촬영지역</label>${droneProject.shooting_area }</li>
						<li class="" title="실시간정사영상">
							<label class="js">정사영상</label>
							<span>${droneProject.ortho_image_count }</span>장
							<ul class="detect">
								<li class="ship">${droneProject.detected_object_item1_count}</li>
								<li class="oil">${droneProject.detected_object_item2_count}</li>
							</ul>
						</li>
						<li class="half" class="half" title="후처리영상">
							<label class="hc">후처리영상</label>
							<span>${droneProject.postprocessing_image_count }</span>장
						</li>
					</ul>
		<!-- E: 프로젝트 정보 -->
				
		<div class="subContents">
			<div class="count">
				<spring:message code='all.d'/> <em><fmt:formatNumber value="${transferDataListSize}" type="number"/></em> <spring:message code='search.what.count'/>
				<div class="index">
		            <span class="js">개별정사영상</span>
		            <span class="hc">후처리영상</span>
		         </div>
			</div>
			<div class="transferDataList" style="max-height: 650px; overflow-y: auto; height:650px;">
				<table class="list-table scope-col">
					<col class="col-number" />
					<col class="col-toggle" />
					<col class="col-name" />
					<thead>
						<tr>
							<th scope="col" class="col-number"><spring:message code='number'/></th>
							<th scope="col" class="col-toggle">상태</th>
							<th scope="col" class="col-name" style="width:68%">[구분] 파일명 (탐지)</th>
						</tr>
					</thead>
					<tbody id="transferDataList">
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
							<td class="col-name">
		<c:if test="${transferData.data_type eq '0'}">					
								<span class="icoJs">개별정사영상</span>
		</c:if>
		<c:if test="${transferData.data_type eq '1'}">					
								<span class="icoHc">후처리영상</span>
		</c:if>
								<a href="#" class="view-group-detail" 
									onclick="refreshDroneImage('${transferData.drone_project_id}', 
																'${transferData.transfer_data_id}', 
																'${transferData.data_type}', 
																'${transferData.viewLayerShootingDate}',
																${transferData.drone_latitude},
																${transferData.drone_longitude});">${transferData.file_name }</a>
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
		<div style="position: absolute; z-index: 1; margin-top: 5px; right: 200px;">
			<input type="button" class="autoRenewal" id="autoRefreshButton" value="영상 자동 갱신" />
			<input type="hidden" id="autoRefreshFlag" value="0" />
		</div>
		<%@ include file="/WEB-INF/views/drone-project/featureInfo.jsp" %>
	</div>
	
	
	<!-- E: MAPWRAP -->
</div>
<!-- E: wrap -->
	
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/live-drone-map.js"></script>
<script type="text/javascript" src="/js/geospatial.js"></script>
<script type="text/javascript">
	// TODO mago3D에 Cesium.ion key 발급 받아서 세팅한거 설명 듣고 Terrain 바꿔 주세요.
	// TODO 데이터가 없을때 layer 예외 처리도 해야 함
	
	// 초기 위치 설정
	// TODO: 배책임님 소스랑 비교
	var west = 37.8;
	var south = 73;
	var east = 217.8;
	var north = 0.0;
	var rectangle = Cesium.Rectangle.fromDegrees(west, south, east, north);
	Cesium.Camera.DEFAULT_VIEW_FACTOR = 0;
	Cesium.Camera.DEFAULT_VIEW_RECTANGLE = rectangle;
	
	// 드론 촬영 이미지를 그리는 geoserver layer
	var DRONE_IMAGE_PROVIDER = null;
	// 객체 탐지를 그리는 geoserver layer
	var DETECTED_OBJECTS_PROVIDER = null; 
	// 드론 경로
	var DRONE_PATH = null;
	// 드론 아이콘 
	var BILLBOARD = null;
	// 드론 영상 갱신 Interval
	var DRONE_REFRESH_INTERVAL = null;
	var INTERVAL_TIME = 5000;  // TODO: policy에 추가 
	// 영상 개수 저장 
	var TRANSFER_DATA_COUNT = ${transferDataListSize};
	var LAST_TRANSFER_DATA = null;
	var DRONE_PROJECT_STATUS = "${droneProject.status}";
	
  	var viewer = new Cesium.Viewer('droneMapContainer', {imageryProvider : imageryProvider, baseLayerPicker : true, animation:false, timeline:false, fullscreenButton:false, infoBox: false});
  	$(document).ready(function() {
		$("#projectMenu").addClass("on");
  		cameraFlyTo("${droneProject.location_longitude}", "${droneProject.location_latitude}", 1500, 3);
  		drawDetailDroneImage(null, "livedronemap:livedronemap_${viewTransferData.drone_project_id}_${viewTransferData.data_type}");
		drawDetectedObjects("transfer_data_id=" + ${viewTransferData.transfer_data_id}, "livedronemap:view_ortho_detected_object");
		checkScroll();
	});
  	
	// 2.5초 후에 드론 비행 경로를 그림
   	var droneMovingPathTimer = setTimeout(function() {
   		var transferDataList = new Array();
   		<c:if test="${!empty transferDataList }">
   			<c:forEach var="transferData" items="${transferDataList}" varStatus="status">
   				transferDataList.push(parseFloat("${transferData.drone_longitude}"));
   				transferDataList.push(parseFloat("${transferData.drone_latitude}"));
   				transferDataList.push(parseFloat("${transferData.drone_altitude}"));
   			</c:forEach>
   		</c:if>
		drawDroneMovingPath(transferDataList);
   	}, 2500);

	// 클릭 프로젝트
   	function drawDroneProject() {
   		drawDroneProjectLine(	"${droneProject.drone_project_name}", 
			"${droneProject.shooting_upper_left_longitude}", "${droneProject.shooting_upper_left_latitude}",
			"${droneProject.shooting_upper_right_longitude}", "${droneProject.shooting_upper_right_latitude}");
		drawDroneProjectLine(	"${droneProject.drone_project_name}", 
			"${droneProject.shooting_upper_right_longitude}", "${droneProject.shooting_upper_right_latitude}",
			"${droneProject.shooting_lower_right_longitude}", "${droneProject.shooting_lower_right_latitude}");
		drawDroneProjectLine(	"${droneProject.drone_project_name}", 
			"${droneProject.shooting_lower_right_longitude}", "${droneProject.shooting_lower_right_latitude}",
			"${droneProject.shooting_lower_left_longitude}", "${droneProject.shooting_lower_left_latitude}");
		drawDroneProjectLine(	"${droneProject.drone_project_name}", 
			"${droneProject.shooting_lower_left_longitude}", "${droneProject.shooting_lower_left_latitude}",
			"${droneProject.shooting_upper_left_longitude}", "${droneProject.shooting_upper_left_latitude}");
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
   		var time_parameter = shootingDate;
   		if (!time_parameter) {
   			time_parameter = "P10Y/PRESENT";
   		}
   		
	   	if($("#autoRefreshFlag").val() == "1" && DRONE_IMAGE_PROVIDER !== null && DRONE_IMAGE_PROVIDER !== undefined) {
	    	viewer.imageryLayers.remove(DRONE_IMAGE_PROVIDER, true);
	    }
	   	
	   	var now = new Date();
		var rand = ( now - now % 5000) / 5000;
		
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
				time : time_parameter,
		    	rand:rand,
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
   		
   		if($("#autoRefreshFlag").val() == "1" && DETECTED_OBJECTS_PROVIDER !== null && DETECTED_OBJECTS_PROVIDER !== undefined) {
	    	viewer.imageryLayers.remove(DETECTED_OBJECTS_PROVIDER, true);
	    }
   		
   		var infoList = new Array();
   		infoList.push(new Cesium.GetFeatureInfoFormat("json", "application/json", CallbackGetFeatureInfo))
	   	
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
			,enablePickFeatures: true
			,getFeatureInfoFormats: infoList
		});
	    
		DETECTED_OBJECTS_PROVIDER = viewer.imageryLayers.addImageryProvider(provider);
   	}
   	
	function CallbackGetFeatureInfo(featureInfo) {
		if (featureInfo.features == "" || featureInfo.features == undefined) {
			$("#featureInfoLayer").hide();
			return;
		}
		var features = featureInfo.features;
		
		for (var i=0; i<features.length;i++) {
			var feature = features[i]
			console.log(feature)
			
			var featureHtml = "<li><label>객체 ID</label>" + feature.properties.ortho_detected_object_id + "</li>" +
								"<li><label>객체 종류</label>" + feature.properties.object_type + "</li>" +
								"<li><label>탐지 일시</label>" + feature.properties.detected_date + "</li>" +
								"<li><label>위도</label>" + feature.properties.latitude + "</li>" +
								"<li><label>경도</label>" + feature.properties.longitude + "</li>" +
								"<li><label>방향</label>" + feature.properties.orientation + "</li>" +
								"<li><label>속도</label>" + feature.properties.speed + "</li>" +
								"<li><label>길이</label>" + feature.properties.length + "</li>"
			
			$("#featureInfo").html(featureHtml);
			
		}
		$("#featureInfoLayer").show();
	
	}
   	
   	function closeFeatureInfo() {
   		$("#featureInfoLayer").hide();
   	}

	// 드론 이동 경로 표시    
    function drawDroneMovingPath(transferDataList) {
		
		if (DRONE_PATH) {
			viewer.entities.remove(DRONE_PATH);
		};
		
		DRONE_PATH = viewer.entities.add({
		    name : '드론 비행 경로',
		    polyline : {
		        positions : Cesium.Cartesian3.fromDegreesArrayHeights(transferDataList),
		        width : 5,
		        material : new Cesium.PolylineDashMaterialProperty({
		            color : Cesium.Color.fromCssColorString('#FFF000'),
		            dashLength: 8.0
		        })
		    }
		});
		
		if (BILLBOARD) {
			viewer.entities.remove(BILLBOARD);
		};
		
		// 드론 이미지
		var droneImage = '/images/${lang}/drone_working.png';
		if(DRONE_PROJECT_STATUS === "4" || DRONE_PROJECT_STATUS === "5") {
			droneImage = '/images/${lang}/drone_done.png';
		};
		BILLBOARD = viewer.entities.add({
	        position : Cesium.Cartesian3.fromDegrees(parseFloat(transferDataList[0]), parseFloat(transferDataList[1]), parseFloat(transferDataList[2])),
	        billboard : {
	            image : droneImage,
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
   	function refreshDroneImage(droneProjectId, transferDataId, dataType, shootingDate, droneLatitude, droneLongitude) {
		// TODO 이동할 위치 정보가 없음. image point를 받아야 함
		if ($("#autoRefreshFlag").val() == "0") {
			// $("#autoRefreshButton").val("영상 자동 갱신 켜기")
			$("#autoRefreshButton").addClass("on");
			$("#autoRefreshFlag").val("1")
			clearInterval(DRONE_REFRESH_INTERVAL);
		}
   		cameraFlyTo(droneLongitude, droneLatitude, viewer.camera.positionCartographic.height, 3);
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
   	
	// 추가 영상 있는지 확인 , 이 처리를 하면서 같지 않으면 아래 데이터도 가져오게 처리
   	setInterval(function() {
   		var droneProjectId = ${droneProject.drone_project_id};
   		
   		$.ajax({
			url: "/drone-project/" + droneProjectId + "/transfer-datas/count",
			type: "GET",
			data: null,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					if (msg.transferDataCount > TRANSFER_DATA_COUNT) {
						refreshDroneProject(droneProjectId);
						refreshTransferData(droneProjectId);
						
						if ($("#autoRefreshFlag").val() == "0") {
							drawDroneImageLayer();
						}
						
					}
				} else {
					console.log(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request, status, error){
				console.log(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
			}
		});
   		
   	}, 5000)
	
	function drawDroneImageLayer() {
   		var postDroneImageLayer = DRONE_IMAGE_PROVIDER;
		var postDetectedObjects = DETECTED_OBJECTS_PROVIDER;
		
		var transferDataType = ${viewTransferData.data_type};
		var transferDataId = ${viewTransferData.transfer_data_id};
		var droneProjectLongitude = ${droneProject.location_longitude};
		var droneProjectLatitude = ${droneProject.location_latitude};
		
		if (LAST_TRANSFER_DATA) {
			transferDataType = LAST_TRANSFER_DATA.data_type;
			transferDataId = LAST_TRANSFER_DATA.transfer_data_id;
			droneProjectLongitude = LAST_TRANSFER_DATA.drone_longitude
			droneProjectLatitude = LAST_TRANSFER_DATA.drone_latitude
		}
		
		cameraFlyTo(parseFloat(droneProjectLongitude), parseFloat(droneProjectLatitude), viewer.camera.positionCartographic.height, 3);
		drawDetailDroneImage(null, "livedronemap:livedronemap_${droneProject.drone_project_id}_" + transferDataType);
		drawDetectedObjects("transfer_data_id=" + transferDataId, "livedronemap:view_ortho_detected_object");
		
		setTimeout(function() {
			viewer.imageryLayers.remove(postDroneImageLayer, true);
			viewer.imageryLayers.remove(postDetectedObjects, true);
		}, INTERVAL_TIME/2);
	}
	
	// 프로젝트 정보 갱신
	function refreshDroneProject(droneProjectId) {
   		$.ajax({
			url: "/drone-project/" + droneProjectId,
			type: "GET",
			data: null,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					var droneProject = msg.droneProject;
					var droneProjectStatus = droneProject.status;
					var droneProjectStatusText = "";
					var droneProjectStatusColor = "";
					if (droneProjectStatus == "0") {
						droneProjectStatusText = "준비중";
						droneProjectStatusColor = "gray";
					} else if (droneProjectStatus == "1") {
						droneProjectStatusText = "점검/테스트";
						droneProjectStatusColor = "gray";
					} else if (droneProjectStatus == "2") {
						droneProjectStatusText = "개별 정사영상";
						droneProjectStatusColor = "#19cc3c";
					} else if (droneProjectStatus == "3") {
						droneProjectStatusText = "후처리 영상";
						droneProjectStatusColor = "blue";
					} else if (droneProjectStatus == "4") {
						droneProjectStatusText = "프로젝트 종료";
						droneProjectStatusColor = "gray";
					}
					
					var ulHtml = '<li class="half" title="촬영일자"><label class="date" >촬영일자</label>' + droneProject.viewShootingDate + '</li>';
					ulHtml += '<li class="half"><label class="step">진행단계</label>' 
							+ '<span style="display: inline-block; width: 100px; color:' + droneProjectStatusColor + '; font-weight: bold;">' 
							+ droneProjectStatusText + '</span></li>';
					ulHtml += '<li title="촬영지역"><label class="location">촬영지역</label>' + droneProject.shooting_area + '</li>';
					ulHtml += '<li class="" title="실시간정사영상"><label class="js">정사영상</label>' 
							+ '<span>' + droneProject.ortho_image_count + '</span>장' 
							+ '<ul class="detect"><li class="ship">' + droneProject.detected_object_item1_count + '</li>' 
							+ '<li class="oil">' + droneProject.detected_object_item2_count + '</li></ul></li>';
					ulHtml += '<li class="half" class="half" title="후처리영상">' 
							+ '<label class="hc">후처리영상</label><span>' + droneProject.postprocessing_image_count + '</span>장</li>';
					
					$("#projectInfo").html(ulHtml);
					
					DRONE_PROJECT_STATUS = droneProjectStatus;
					
				} else {
					console.log(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request, status, error){
				console.log(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
			}
		});
	}
   	
	// 영상 목록 갱신
   	function refreshTransferData(droneProjectId) {
   		$.ajax({
			url: "/drone-project/" + droneProjectId + "/transfer-datas",
			type: "GET",
			data: null,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					var transderDataPositionList = new Array();
					var transferDataList = msg.transferDataList;
					var transferDataListSize = msg.transferDataListSize;
					
					var tableHtml = "";
					
					for(var i=0; i < transferDataListSize; i++ ) {
						var transferData = transferDataList[i];
						
						transderDataPositionList.push(parseFloat(transferData.drone_longitude));
						transderDataPositionList.push(parseFloat(transferData.drone_latitude));
						transderDataPositionList.push(parseFloat(transferData.drone_altitude));
						
						var transferDataStatus = transferData.status;
						var transferDataStatusText = "";
						if (transferDataStatus == '0') {
							transferDataStatusText = '전송';
						} else if (transferDataStatus == '1') {
							transferDataStatusText = '완료';
						} else if (transferDataStatus == '2'){ 
							transferDataStatusText = '실패';
						} else if (transferDataStatus == '3') {
							transferDataStatusText = '에러';
						}
						var transferDataType = transferData.data_type;
						var transferDataTypeText = "";
						if (transferDataType == "0") {
							transferDataTypeText = '<span class="icoJs">개별정사영상</span>';
						} else if (transferDataType == "1") {
							transferDataTypeText = '<span class="icoHc">후처리영상</span>';
						}
						
						tableHtml += '<tr><td class="col-number" >' + (transferDataListSize-i) + '</td>';
						tableHtml += '<td class="col-toggle"><span class="icon-text">' + transferDataStatusText + '</span></td>';
						tableHtml += '</td><td class="col-name">' + transferDataTypeText 
									+ '<a href="#" class="view-group-detail" onclick="refreshDroneImage(\'' 
									+ droneProjectId + "','"
									+ transferData.transfer_data_id + "','"
									+ transferDataType + "','" 
									+ transferData.viewLayerShootingDate + "',"
									+ transferData.drone_latitude + ","
									+ transferData.drone_longitude + ');">'
									+ transferData.file_name + '</a>'
									+ '(' + transferData.ortho_detected_object_count + ')</td></tr>';
					}
					
					$("#transferDataList").html(tableHtml);
					checkScroll();
					
					TRANSFER_DATA_COUNT = transferDataListSize;
					LAST_TRANSFER_DATA = transferDataList[0];
					
					drawDroneMovingPath(transderDataPositionList);
					
				} else {
					console.log(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request, status, error){
				console.log(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
			}
		});
   	}
	
	$("#autoRefreshButton").click(function() {
		if ($("#autoRefreshFlag").val() == "0") {
			// $("#autoRefreshButton").val("영상 자동 갱신 켜기");
			$("#autoRefreshButton").addClass("on");
			$("#autoRefreshFlag").val("1");
			clearInterval(DRONE_REFRESH_INTERVAL);
			
		} else if ($("#autoRefreshFlag").val() == "1") {
			// $("#autoRefreshButton").val("영상 자동 갱신 끄기");
			$("#autoRefreshButton").removeClass("on");
			$("#autoRefreshFlag").val("0");
			drawDroneImageLayer();
		} 
	});
	
	function checkScroll() {
		var $table = $('table.list-table');
		var tableHeight = $table.innerHeight();
		var tableAreaHeight = $(".transferDataList").height();
		var isOverflow = tableHeight <= tableAreaHeight;
		if(!isOverflow){
		  $('table.list-table').fixedHeaderTable({autoShow: true, width: 310});
		  $( "thead th:last-child" ).css({ width:"215px" });
		}
	}
	
</script>
</body>
</html>

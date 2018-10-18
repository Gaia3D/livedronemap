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
					<li class="ship">${droneProject.detected_objects_count}</li>
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
							<th scope="col" class="col-name" style="width: 70%;">[구분] 파일명 (탐지)</th>
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
								[ T ]
		</c:if>
		<c:if test="${transferData.data_type eq '1'}">					
								[ P ]
		</c:if>
								<a href="#" class="view-group-detail" onclick="detail('${transferData.transfer_data_id }'); return false;">${transferData.file_name }</a>
								(${transferData.detected_objects_count })
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
	<script type="text/javascript">
/* 	function mapWrapResize() {
		var mapWrap = document.getElementById('mapWrap');
		var Wrap =  document.getElementById('wrap');
		mapWrap.style.width = window.innerWidth - 391 + 'px'; // 전체 윈도우 - nav - subWrap
		Wrap.style.height = window.innerHeight - 50 + 'px'; // 전체 인도우 - header
    }
	mapWrapResize();
	// 브라우저 크기가 변할 시 동적으로 사이즈를 조절해야 하는경우
	window.addEventListener('resize', mapWrapResize); */

	var DRONE_PROVIDER = null; 
	
  	var imageryProvider = new Cesium.ArcGisMapServerImageryProvider({
		url : 'https://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer',
		enablePickFeatures: false
	});

  	Cesium.Camera.DEFAULT_VIEW_RECTANGLE = Cesium.Rectangle.fromDegrees(115.0, -20.0, 140.0, 90.0);
	var viewer = new Cesium.Viewer('droneMapContainer', {imageryProvider : imageryProvider, baseLayerPicker : true, animation:false, timeline:false, fullscreenButton:false});
    //var viewer = new Cesium.Viewer('cesiumContainer');
    //cameraFlyTo("${droneProject.location_longitude}", "${droneProject.location_latitude}", 12000, 3);

    drawDroneProject();
    
   	$(document).ready(function() {
	});
    
   	function drawDroneProject() {
		viewer.entities.add({
			name : "${droneProject.drone_project_name}",
			polyline : {
			positions : Cesium.Cartesian3.fromDegreesArray([${droneProject.shooting_longitude1}, ${droneProject.shooting_latitude1},
															${droneProject.shooting_longitude2}, ${droneProject.shooting_latitude2}]),
				width : 5,
				material : Cesium.Color.RED,
				clampToGround : true
			}
		});
		viewer.entities.add({
			name : "${droneProject.drone_project_name}",
			polyline : {
			positions : Cesium.Cartesian3.fromDegreesArray([${droneProject.shooting_longitude1}, ${droneProject.shooting_latitude1},
															${droneProject.shooting_longitude3}, ${droneProject.shooting_latitude3}]),
				width : 5,
				material : Cesium.Color.RED,
				clampToGround : true
			}
		});
		viewer.entities.add({
			name : "${droneProject.drone_project_name}",
			polyline : {
			positions : Cesium.Cartesian3.fromDegreesArray([${droneProject.shooting_longitude2}, ${droneProject.shooting_latitude2},
															${droneProject.shooting_longitude4}, ${droneProject.shooting_latitude4}]),
				width : 5,
				material : Cesium.Color.RED,
				clampToGround : true
			}
		});
		viewer.entities.add({
			name : "${droneProject.drone_project_name}",
			polyline : {
			positions : Cesium.Cartesian3.fromDegreesArray([${droneProject.shooting_longitude3}, ${droneProject.shooting_latitude3},
															${droneProject.shooting_longitude4}, ${droneProject.shooting_latitude4}]),
				width : 5,
				material : Cesium.Color.RED,
				clampToGround : true
			}
		});
    }
   	
   	drawDetailDroneImage();
   	function drawDetailDroneImage() {
	   	if(DRONE_PROVIDER !== null && DRONE_PROVIDER !== undefined) {
	    	viewer.imageryLayers.remove(DRONE_PROVIDER, true);
	    }
	   	
	   	shooting_date = "${viewTransferData.viewLayerShootingDate}"; // 2018-10-10 까지 써도 상관은 없음 
	   	var layerName = 'livedronemap:livedronemap_${viewTransferData.drone_project_id}_${viewTransferData.data_type}';
		var provider = new Cesium.WebMapServiceImageryProvider({
			url : 'http://localhost:8080/geoserver/wms',
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
				time : shooting_date,
		    	//rand:rand,
				maxZoom : 25,
				maxNativeZoom : 23,
				//CQL_FILTER: queryString
				//bjcd LIKE '47820253%' AND name='청도읍'
			},
			//,proxy: new Cesium.DefaultProxy('/proxy/')
			enablePickFeatures: false
		});
	    
		DRONE_PROVIDER = viewer.imageryLayers.addImageryProvider(provider);
   	}
    
    viewer.zoomTo(viewer.entities);
    cameraFlyTo(128.38328, 34.76434, 500, 3);
   	
    function cameraFlyTo(longitude, latitude, altitude, duration) {
		viewer.camera.flyTo({
			destination: Cesium.Cartesian3.fromDegrees(parseFloat(longitude),
				parseFloat(latitude),
				parseFloat(altitude)),
			duration: parseInt(duration)
		});
	}
    
    $( "#projectMenu" ).on( "click", function() {
    	if($("#leftMenuArea").css("display") == "none") {
    		$("#leftMenuArea").show();
    	} else {
    		$("#leftMenuArea").hide();
    	}
    });
	$( "#menuCloseButton" ).on( "click", function() {
		if($("#leftMenuArea").css("display") == "none") {
			$("#leftMenuArea").show();
			$(".mapWrap").css({"padding-left" : "391px"});
		} else {
			$("#leftMenuArea").hide();
			$(".mapWrap").css({"padding-left" : "51px"});
		}
	});
</script>
</body>
</html>

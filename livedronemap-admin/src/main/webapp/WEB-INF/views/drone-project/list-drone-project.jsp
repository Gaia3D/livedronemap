<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>프로젝트 목록 | LiveDroneMap</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/${lang}/style.css">
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
			<h2>프로젝트</h2>
			<div id="menuCloseButton" class="ctrlBtn">
				<button type="button" title="닫기" class="close">닫기</button>
			</div>
		</div>
		<!-- E: 프로젝트 제목, 목록가기, 닫기 -->
				
		<div class="subContents">
			<form:form id="searchForm" modelAttribute="droneProject" method="post" action="/drone-project/list-drone-project" onsubmit="return searchCheck();">
				<div class="input-group row">
					<div class="input-set">
						<label for="search_word"><spring:message code='search.word'/></label>
						<select id="search_word" name="search_word" class="select" style="height: 30px;">
							<option value=""><spring:message code='select'/></option>
		          			<option value="drone_project_name">프로젝트명</option>
						</select>
						<select id="search_option" name="search_option" class="select" style="height: 30px;">
							<option value="0"><spring:message code='search.same'/></option>
							<option value="1"><spring:message code='search.include'/></option>
						</select>
						<form:input path="search_value" type="search" size="12" cssClass="m" style="height: 30px;" />
					</div>
					<div class="input-set" style="padding-top: 2px;">
						<label for="start_date"><spring:message code='search.date'/></label>&nbsp;&nbsp;&nbsp;
						<input type="text" id="start_date" name="start_date" class="s date" size="11" maxlength="8" style="height: 25px;" />
						<span class="delimeter tilde">~</span>
						<input type="text" id="end_date" name="end_date" class="s date" size="11" maxlength="8" style="height: 25px;" />
					</div>
					<div class="input-set"  style="padding-top: 2px;">
						<label for="order_word"><spring:message code='search.order'/></label>&nbsp;&nbsp;&nbsp;
						<select id="order_word" name="order_word" class="select" style="height: 30px;">
							<option value=""> <spring:message code='search.basic'/> </option>
							<option value="drone_project_name">프로젝트명</option>
							<option value="insert_date"><spring:message code='search.insert.date'/></option>
						</select>
						<select id="order_value" name="order_value" class="select" style="height: 30px;">
	                		<option value=""><spring:message code='search.basic'/></option>
		                	<option value="ASC"><spring:message code='search.ascending'/></option>
							<option value="DESC"><spring:message code='search.descending.order'/></option>
						</select>
						<select id="list_counter" name="list_counter" class="select" style="height: 30px;">
	                		<option value="10"><spring:message code='search.ten.count'/></option>
		                	<option value="50"><spring:message code='search.fifty.count'/></option>
							<option value="100"><spring:message code='search.hundred.count'/></option>
						</select>
					</div>
					<div class="input-set" style="padding-top:5px; text-align: center;">
						<input type="submit" value="<spring:message code='search'/>" class="button" style="width: 50px; height: 25px;" />
					</div>
				</div>
			</form:form>
			<div class="count" style="margin-top: 20px; margin-bottom: 5px;">
				<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em> <spring:message code='search.what.count'/>
				<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
			</div>
			<div class="projectList" style="max-height: 500px;">
<c:if test="${empty droneProjectList }">				
				<ul class="projectInfo">
					<li class="title" style="height: 60px; padding-top: 30px;">드론 프로젝트가 존재하지 않습니다.</li>
				</ul>
</c:if>
<c:if test="${!empty droneProjectList }">
	<c:forEach var="droneProject" items="${droneProjectList}" varStatus="status">			
					<ul class="projectInfo">
						<li class="title">
							<a href="/drone-project/detail-drone-project?drone_project_id=${droneProject.drone_project_id }&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}">${droneProject.drone_project_name}</a>
		<c:if test="${droneProject.ortho_image_count > 0 }">
							<input type="button" id="droneImage_${droneProject.drone_project_id }" name="viewDroneImageButton" 
								onclick="changeDroneImageLayer('${status.index}','${droneProject.drone_project_id }'); return false;" 
								style="width: 90px; height: 25px; float: right;" value="이미지 비표시" />
							<input type="hidden" id="layter_${droneProject.drone_project_id }" value="0" />
		</c:if>
						</li>
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
						<li class="half" title="실시간정사영상">
							<label class="js">정사영상</label>
							<span>${droneProject.ortho_image_count }</span>장
							<ul class="detect">
								<li class="ship">${droneProject.ortho_detected_object_count}</li>
								<li class="oil">${droneProject.ortho_detected_object_count}</li>
							</ul>
						</li>
						<li class="half" class="half" title="후처리영상">
							<label class="hc">후처리영상</label>
							<span>${droneProject.postprocessing_image_count }</span>장</li>
						<li>
					</ul>
	</c:forEach>
</c:if>
			</div>
			
			<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
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
<script type="text/javascript" src="/js/geospatial.js"></script>
<script type="text/javascript">
	// 초기 위치 설정
	// TODO: 배책임님 소스랑 비교
	var west = 126.0;
	var south = 32.0;
	var east = 130.0;
	var north = 39.0;
	var rectangle = Cesium.Rectangle.fromDegrees(west, south, east, north);
	Cesium.Camera.DEFAULT_VIEW_FACTOR = 0;
	Cesium.Camera.DEFAULT_VIEW_RECTANGLE = rectangle;

	// TODO mago3D에 Cesium.ion key 발급 받아서 세팅한거 설명 듣고 Terrain 바꿔 주세요.
	var viewer = new Cesium.Viewer('droneMapContainer', {imageryProvider : imageryProvider, baseLayerPicker : true, animation:false, timeline:false, fullscreenButton:false});
    // 드론 촬영 이미지를 그리는 geoserver layer
	var DRONE_IMAGE_PROVIDER_ARRAY = new Array();
    var DORNE_IMAGE_INTERVAL_ARRAY = new Array();
	// 객체 탐지를 그리는 geoserver layer
	var DETECTED_OBJECTS_PROVIDER_ARRAY = new Array();
	// 드론 경로를 그리는 layer
	var DRONE_PATH_ARRAY = new Array();
	// 드론 이미지를 표시
	var BILLBOARD_ARRAY = new Array();
	for(var i=0; i<10; i++) {
		DRONE_IMAGE_PROVIDER_ARRAY.push(null);
		DETECTED_OBJECTS_PROVIDER_ARRAY.push(null);
		DRONE_PATH_ARRAY.push(null);
		BILLBOARD_ARRAY.push(null);
	}
	var intervalTime = 5000;  // TODO: policy에 추가 
	
	// 프로젝트 id 처리 
	var droneProjectIdList = new Array();
	<c:forEach items="${droneProjectList}" var="droneProject">
		droneProjectIdList.push(${droneProject.drone_project_id});
	</c:forEach>
	
	$(document).ready(function() {
		// cameraFlyTo(127.827348, 36.590489, 2000000, 3);
		// drawDroneProject();
		
		initJqueryCalendar();
		
		// 리스트의 모든 프로젝트 드론 경로 표출 
		for(i=0; i<droneProjectIdList.length; i++ ) {
			var droneProjectId = droneProjectIdList[i];
			var index = droneProjectId;
			
			setInterval(function() {
	   			$.ajax({
	   				url: "/drone-project/" + droneProjectId + "/transfer-datas",
	   				type: "GET",
	   				data: null,
	   				dataType: "json",
	   				success: function(msg){
	   					if(msg.result == "success") {
							var postDronePath = DRONE_PATH_ARRAY[index];
	   						viewer.entities.remove(BILLBOARD_ARRAY[index]);
	   						
	   						drawDroneMovingPath(index, droneProjectId, msg);
	   						
	   						setTimeout(function() {
								viewer.entities.remove(postDronePath);
							}, intervalTime/2)
	   						
	   					} else {
	   						alert(JS_MESSAGE[msg.result]);
	   					}
	   				},
	   				error:function(request, status, error){
	   					//alert(JS_MESSAGE["ajax.error.message"]);
	   					alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
	   				}
	   			});
	   		}, intervalTime);
		}
		
	});
	
	// 가장 최근 프로젝트 중 종료와 에러 이외의 프로젝트만 표시
    function drawDroneProject() {
		var droneProjectList = new Array();
    	<c:if test="${!empty droneProjectList }">
    		<c:forEach var="droneProject" items="${droneProjectList}" varStatus="status">
    			<c:if test="${droneProject.status ne '4' and droneProject.status ne '5'}">
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
				</c:if>
    		</c:forEach>
		</c:if>
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
    
	//<input type="button" id="viewDroneImageButton" name="viewDroneImageButton" onclick="changeDroneImageLayer('${droneProject.drone_project_id }'); return false;" 
	//	style="width: 90px; height: 25px;" value="이미지 표시" />
	//<input type="hidden" id="layter_${droneProject.drone_project_id }" value="0" />
	function changeDroneImageLayer(index, droneProjectId) {
		if($("#layter_" + droneProjectId).val() === "0") {
			// 표시 버튼 클릭
			$("#layter_" + droneProjectId).val("1");
			$("#droneImage_" + droneProjectId).val("이미지 표시");
			drawDetailDroneImage(index, true, droneProjectId);
		} else {
			// 비표시 버튼 클릭
			$("#layter_" + droneProjectId).val("0");
			$("#droneImage_" + droneProjectId).val("이미지 비표시");
			clearInterval(DORNE_IMAGE_INTERVAL_ARRAY[index])
			drawDetailDroneImage(index, false, droneProjectId);
		}
	}
	
	// 드론 이미지를 geoserver layer를 이용해서 그림
   	function drawDetailDroneImage(index, drawFlag, droneProjectId) {
   		//shootingDate, layerName
   		if(!drawFlag) {
   			// layer 삭제
   			viewer.imageryLayers.remove(DRONE_IMAGE_PROVIDER_ARRAY[index], true);
   			viewer.imageryLayers.remove(DETECTED_OBJECTS_PROVIDER_ARRAY[index], true);
   			return;
   		} 
		
   		drawInterval(index, droneProjectId, false);
   		var droneImageInterval = setInterval(function() {
   			drawInterval(index, droneProjectId, true);
   		}, intervalTime);
   		
   		DORNE_IMAGE_INTERVAL_ARRAY[index] = droneImageInterval

	}
	
	// 이미지 그리는 건데 ... 메소드 명은 .. 음 .. 
	function drawInterval(index, droneProjectId, deleteFlag) {
		$.ajax({
			url: "/drone-project/" + droneProjectId + "/transfer-datas",
			type: "GET",
			data: null,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					var postDroneImageLayer = DRONE_IMAGE_PROVIDER_ARRAY[index];
					var postDetectedObjectsProvider = DETECTED_OBJECTS_PROVIDER_ARRAY[index];
						
					// 새로운 이미지 생성
					drawDroneLayer(index, droneProjectId, msg);
					drawDetectedObjects(index, droneProjectId,msg);
					
					if (deleteFlag) {
						setTimeout(function() {
							viewer.imageryLayers.remove(postDroneImageLayer, true);
							viewer.imageryLayers.remove(postDetectedObjectsProvider, true);
						}, intervalTime/2)
					}
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request, status, error){
				//alert(JS_MESSAGE["ajax.error.message"]);
				alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
			}
		});
	}
	
	// 드론 이미지 geoserver layer로 표시
	function drawDroneLayer(index, droneProjectId, msg) {
		var layerName = "livedronemap:livedronemap_" + droneProjectId + "_" + msg.viewTransferData.data_type;
		var shootingDate = msg.shooting_date;
   		
		// cache 막으려고 5초에 한번씩
   		var now = new Date();
		var rand = ( now - now % 5000) / 5000;
		
	   	var provider = new Cesium.WebMapServiceImageryProvider({
	   		// TODO: 캐시 적용 필요 
			//url : '${policy.geoserver_data_url}/gwc/service/wms',
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
				time : 'P10Y/PRESENT',
				//time : "2018-10-15T20:38:00.000Z/" + shootingDate,
		    	rand:rand,
				//maxZoom : 25,
				//maxNativeZoom : 23,
				//CQL_FILTER: queryString
				//bjcd LIKE '47820253%' AND name='청도읍'
			},
			//,proxy: new Cesium.DefaultProxy('/proxy/')
			enablePickFeatures: false
		});
	    
	   	DRONE_IMAGE_PROVIDER_ARRAY[index] = viewer.imageryLayers.addImageryProvider(provider); 	
	}
	
	// 객체 탐지를 geoserver layer를 이용해서 그림
	function drawDetectedObjects(index, droneProjectId, msg) {
		var queryString = "transfer_data_id=" + msg.viewTransferData.transfer_data_id;
		var layerName = "livedronemap:view_ortho_detected_object";
		
		// cache 막으려고 5초에 한번씩
   		var now = new Date();
		var rand = ( now - now % 5000) / 5000;
   		
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
	    
   		DETECTED_OBJECTS_PROVIDER_ARRAY[index] = viewer.imageryLayers.addImageryProvider(provider);
   	}
	
	// 드론 이동 경로 표시    
    function drawDroneMovingPath(index, droneProjectId, msg) {
		var serverTransferDataList = msg.transferDataList;
		var transferDataList = new Array();
		if (serverTransferDataList != null && serverTransferDataList.length > 0) {
			for(i=0; i<serverTransferDataList.length; i++ ) {
				var transferData = serverTransferDataList[i];
				transferDataList.push(transferData.drone_longitude);
				transferDataList.push(transferData.drone_latitude);
				transferDataList.push(transferData.drone_altitude);
			}
		}
		
		DRONE_PATH_ARRAY[index] = viewer.entities.add({
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
		BILLBOARD_ARRAY[index] = viewer.entities.add({
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
</script>
</body>
</html>

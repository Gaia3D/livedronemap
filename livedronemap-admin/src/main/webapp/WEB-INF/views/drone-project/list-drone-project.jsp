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
				<ul class="projectSearch input-group row">
					<li class="input-set">
						<label for="search_word">프로젝트</label>
						<%-- <select id="search_word" name="search_word" class="select" >
							<option value=""><spring:message code='select'/></option>
		          			<option value="drone_project_name">프로젝트명</option>
						</select>
						<select id="search_option" name="search_option" class="select" >
							<option value="0"><spring:message code='search.same'/></option>
							<option value="1"><spring:message code='search.include'/></option>
						</select> --%>
						<form:input path="search_value" type="search" size="25" cssClass="m" />
					</li>
					<li class="input-set">
						<label for="start_date"><spring:message code='search.date'/></label>
						<input type="text" id="start_date" name="start_date" class="s date" size="8" maxlength="8" />
						<span class="delimeter tilde">~</span>
						<input type="text" id="end_date" name="end_date" class="s date" size="8" maxlength="8"/>
					</li>
					<%-- <div class="input-set"  style="padding-top: 2px;">
						<label for="order_word"><spring:message code='search.order'/></label>&nbsp;&nbsp;&nbsp;
						<select id="order_word" name="order_word" class="select">
							<option value=""> <spring:message code='search.basic'/> </option>
							<option value="drone_project_name">프로젝트명</option>
							<option value="insert_date"><spring:message code='search.insert.date'/></option>
						</select>
						<select id="order_value" name="order_value" class="select">
	                		<option value=""><spring:message code='search.basic'/></option>
		                	<option value="ASC"><spring:message code='search.ascending'/></option>
							<option value="DESC"><spring:message code='search.descending.order'/></option>
						</select>
						<select id="list_counter" name="list_counter" class="select">
	                		<option value="5"><spring:message code='search.five.count'/></option>
		                	<option value="10"><spring:message code='search.ten.count'/></option>
							<option value="20"><spring:message code='search.twenty.count'/></option>
						</select>
					</div> --%>
					<li class="input-set btn">
						<button type="submit" value="<spring:message code='search'/>" class="point"><spring:message code='search'/></button>
					</li>
				</ul>
			</form:form>
			<div id="projectListHeader" class="count" style="margin-top: 20px; margin-bottom: 5px;">
				<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em> <spring:message code='search.what.count'/>
				<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
			</div>
			<div id="projectList" class="projectList" style="max-height: 500px;">
<c:if test="${empty droneProjectList }">				
				<ul class="projectInfo">
					<li class="title" style="height: 60px; padding-top: 30px;">드론 프로젝트가 존재하지 않습니다.</li>
				</ul>
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
	var INIT_WEST = 126.0;
	var INIT_SOUTH = 32.0;
	var INIT_EAST = 130.0;
	var INIT_NORTH = 39.0;
	var rectangle = Cesium.Rectangle.fromDegrees(INIT_WEST, INIT_SOUTH, INIT_EAST, INIT_NORTH);
	Cesium.Camera.DEFAULT_VIEW_FACTOR = 0;
	Cesium.Camera.DEFAULT_VIEW_RECTANGLE = rectangle;
	
	// 배경지도 일단 보류 
	/* var imageryProvider = new Cesium.WebMapServiceImageryProvider({
		url : '${policy.geoserver_data_url}/wms',
		layers : "livedronemap:background",
		parameters : {
			service : 'WMS'
			,version : '1.1.1'
			,request : 'GetMap'
			,transparent : 'true'
			,tiled : 'true'
			,format : 'image/png'
		}
		//,proxy: new Cesium.DefaultProxy('/proxy/')
		,enablePickFeatures: false
	}); */
	
	// TODO mago3D에 Cesium.ion key 발급 받아서 세팅한거 설명 듣고 Terrain 바꿔 주세요.
	var viewer = new Cesium.Viewer('droneMapContainer', {imageryProvider : imageryProvider, baseLayerPicker : true, animation:false, timeline:false, fullscreenButton:false});
	
	// 프로젝트 리스트
	var DRONE_PROJECT_ARRAY = new Array();	
	// 프로젝트 토탈 카운트
	var DRONE_PROJECT_TOTAL_COUNT = 0;
	// 드론 촬영 이미지를 그리는 geoserver layer
	var DRONE_IMAGE_PROVIDER_ARRAY = new Array();
    // 드론 프로젝트별 전송 파일 갯수 
    var TRANSFER_DATA_COUNT_ARRAY = new Array();
	// 객체 탐지를 그리는 geoserver layer
	var DETECTED_OBJECTS_PROVIDER_ARRAY = new Array();
	// 드론 경로를 그리는 layer
	var DRONE_PATH_ARRAY = new Array();
	// 드론 이미지를 표시
	var BILLBOARD_ARRAY = new Array();
	// 드론 이미지 갱신 플레그 리스트 
	var DRONE_IMAGE_REFRESH_FLAG_ARRAY = new Array();
	// 프로젝트 리스트 갱신 플레그
	var DRONE_PROJECT_LIST_REFRESH = true;
	for(var i=0; i<10; i++) {
		DRONE_IMAGE_REFRESH_FLAG_ARRAY.push(false);
		/* DRONE_IMAGE_PROVIDER_ARRAY.push(null);
		TRANSFER_DATA_COUNT_ARRAY.push(null);
		DETECTED_OBJECTS_PROVIDER_ARRAY.push(null);
		DRONE_PATH_ARRAY.push(null);
		BILLBOARD_ARRAY.push(null); */
	}
	
	// TODO: policy에 추가
	var INTERVAL_TIME = 5000; 
	$(document).ready(function() {
		$("#projectMenu").addClass("on");
		initJqueryCalendar();
		
		// 프로젝트 리스트 갱신 
		refreshProjectList();
		setInterval(refreshProjectList, INTERVAL_TIME);
	});
	
	// 프로젝트 개별 정사 영사 표시/비표시
	function changeDroneImageLayer(index, droneProjectId, droneProjectStatus) {
		if($("#layer_" + droneProjectId).val() === "0") {
			// 표시 버튼 클릭
			$("#layer_" + droneProjectId).val("1");
			// $("#droneImage_" + droneProjectId).val("이미지 비표시");
			$("#droneImage_" + droneProjectId).addClass("off");
			DRONE_IMAGE_REFRESH_FLAG_ARRAY[index] = true;
			drawDetailDroneImage(index, droneProjectId, droneProjectStatus);
		} else {
			// 비표시 버튼 클릭
			$("#layer_" + droneProjectId).val("0");
			// $("#droneImage_" + droneProjectId).val("이미지 표시");
			$("#droneImage_" + droneProjectId).removeClass("off");
			DRONE_IMAGE_REFRESH_FLAG_ARRAY[index] = false;
			viewer.imageryLayers.remove(DRONE_IMAGE_PROVIDER_ARRAY[index], true);
   			viewer.imageryLayers.remove(DETECTED_OBJECTS_PROVIDER_ARRAY[index], true);
		}
	}
	
	function refreshProjectList() {
		$.ajax({
			url: "/drone-project/drone-projects?pageNo=${pagination.pageNo}${pagination.searchParameters}",
			type: "GET",
			data: null,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					var pagination = msg.pagination;
					var droneProjectList = msg.droneProjectList;
					for (var i = 0; i < droneProjectList.length; i++) {
						DRONE_PROJECT_ARRAY[i] = droneProjectList[i];
					}
					// 프로젝트 리스트 갱신 
					if (msg.droneProjectTotalCount != DRONE_PROJECT_TOTAL_COUNT) {
						var newProjectCount = msg.droneProjectTotalCount - DRONE_PROJECT_TOTAL_COUNT;
						
						// 새로운 프로젝트 들어왔을 때.. 인덱스 변경 처리 
						for (var j = 0; j < newProjectCount; j++) {
							TRANSFER_DATA_COUNT_ARRAY.unshift(null);
							DRONE_IMAGE_REFRESH_FLAG_ARRAY.unshift(false);
							DRONE_IMAGE_PROVIDER_ARRAY.unshift(null);
							DETECTED_OBJECTS_PROVIDER_ARRAY.unshift(null);
							DRONE_PATH_ARRAY.unshift(null);
							BILLBOARD_ARRAY.unshift(null);
						}
						
						// 불필요 레이어 삭제 
						var pageRows = pagination.pageRows
						for (var k = pageRows; k < pageRows+newProjectCount; k++ ) {
							viewer.imageryLayers.remove(DRONE_IMAGE_PROVIDER_ARRAY[k], true);
							viewer.imageryLayers.remove(DETECTED_OBJECTS_PROVIDER_ARRAY[k], true);
							viewer.entities.remove(DRONE_PATH_ARRAY[k], true);
							viewer.entities.remove(BILLBOARD_ARRAY[k], true);
						}
						
						// 프로젝트 전체 수 갱신 
						DRONE_PROJECT_TOTAL_COUNT = msg.droneProjectTotalCount;
						// 경로, 이미지 그리기  
						drawDroneData();
						
						DRONE_PROJECT_LIST_REFRESH = true;
						
					} else {
						for (var i = 0; i < droneProjectList.length; i++) {
							var droneProject = droneProjectList[i];
							var droneProjectId = droneProject.drone_project_id;
							var droneProjectStatus = droneProject.status;
							if (droneProjectStatus != DRONE_PROJECT_ARRAY[i].status) {
								DRONE_PROJECT_LIST_REFRESH = true;
							}
							
							if (droneProjectStatus != "4" || droneProjectStatus != "5") {
								var imageTotalCount = droneProject.ortho_image_count + droneProject.postprocessing_image_count;
								
								if (imageTotalCount != TRANSFER_DATA_COUNT_ARRAY[i]) {
									// 드론 경로 갱신 
									drawDronePath(i, droneProjectId, droneProject.status);
									// 이미지/객체 탐지 새로 그리기
									if (DRONE_IMAGE_REFRESH_FLAG_ARRAY[i]) {
										drawDetailDroneImage(i, droneProjectId, droneProjectStatus);
									}
									
									TRANSFER_DATA_COUNT_ARRAY[i] = imageTotalCount;
									DRONE_PROJECT_LIST_REFRESH = true;
								}
							}
						}
					}
					
					if (DRONE_PROJECT_LIST_REFRESH) {
						// 프로젝트 리스트 그리기 
						drawDroneProjectList(pagination);
						DRONE_PROJECT_LIST_REFRESH = false;
					}
					
				} else {
					console.log(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request, status, error) {
				console.log(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
			}
		});
	}
	
	function drawDroneProjectList(pagination) {
		// TODO: 세자리 , 추가 
		var droneProjectListHeaderHtml = '<spring:message code="all.d"/> <em>' + pagination.totalCount + ' </em><spring:message code="search.what.count"/>&nbsp;'
										+ pagination.pageNo + ' / ' + pagination.lastPage + ' <spring:message code="search.page"/>';
		$("#projectListHeader").html(droneProjectListHeaderHtml); 
		
		if (pagination.totalCount > 0) {
			var droneProjectListPagingHtml = '';
			if (pagination.pageNo != pagination.firstPage) {
				droneProjectListPagingHtml += '<li><a href="${pagination.uri}?pageNo=' + pagination.firstPage + pagination.searchParameters + '" class="first"><span class="ico first"></span></a></li>'
			} else {
				droneProjectListPagingHtml += '<li><span class="ico first"></span></li>'
			}
			if (pagination.existPrePage == 'true') {
				droneProjectListPagingHtml += '<li><a href="${pagination.uri}?pageNo=' + pagination.prePageNo + pagination.searchParameters + '" class="prev"><span class="ico forward"></span></a></li>'
			} else {
				droneProjectListPagingHtml += '<li><span class="ico forward"></span></li>'
			}
			for (var i = pagination.startPage; i <= pagination.endPage; i++ ) {
				if (i == pagination.pageNo) {
					droneProjectListPagingHtml += '<li class="on"><a href="#">' + i + '</a></li>'
				} else {
					droneProjectListPagingHtml += '<li><a href="${pagination.uri}?pageNo=' + i + pagination.searchParameters + '">' + i + '</a></li>'
				}
			}
			if (pagination.existNextPage == 'true') {
				droneProjectListPagingHtml += '<li><a href="${pagination.uri}?pageNo=' + pagination.nextPageNo + pagination.searchParameters + '" class="next"><span class="ico back"></span></a></li>'
			} else {
				droneProjectListPagingHtml += '<li><span class="ico back"></span></li>'
			}
			if (pagination.pageNo != pagination.lastPage) {
				droneProjectListPagingHtml += '<li><a href="${pagination.uri}?pageNo=' + pagination.lastPage + pagination.searchParameters + '" class="first"><span class="ico end"></span></a></li>'
			} else {
				droneProjectListPagingHtml += '<li><span class="ico end"></span></li>'
			}
			$("#pagination").html(droneProjectListPagingHtml);
		} 
		
		var droneProjectListHtml = "";
		for (var i = 0; i < DRONE_PROJECT_ARRAY.length; i++) {
			var droneProject = DRONE_PROJECT_ARRAY[i];
			var droneProjectStatus = droneProject.status;
			
			droneProjectListHtml += '<ul class="projectInfo">';
			droneProjectListHtml += '<li class="title">';
			if (droneProject.ortho_image_count > 0 ||  droneProject.postprocessing_image_count > 0) {
				if (DRONE_IMAGE_REFRESH_FLAG_ARRAY[i]) {
					droneProjectListHtml += '<a href="/drone-project/detail-drone-project?drone_project_id=' + droneProject.drone_project_id 
										+ '&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}">'
										+ droneProject.drone_project_name + '</a>'
										+ '<input type="button" class="sceneimage off" id="droneImage_' + droneProject.drone_project_id + '" name="viewDroneImageButton"'
										+ 'onclick="changeDroneImageLayer(\'' + i + '\',\'' + droneProject.drone_project_id + '\',\'' + droneProject.status + '\'); return false;" />'
										+ '<input type="hidden" id="layer_' + droneProject.drone_project_id + '" value="1" />';
				} else {
					droneProjectListHtml += '<a href="/drone-project/detail-drone-project?drone_project_id=' + droneProject.drone_project_id 
										+ '&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}">'
										+ droneProject.drone_project_name + '</a>'
										+ '<input type="button" class="sceneimage" id="droneImage_' + droneProject.drone_project_id + '" name="viewDroneImageButton"'
										+ 'onclick="changeDroneImageLayer(\'' + i + '\',\'' + droneProject.drone_project_id + '\',\'' + droneProject.status + '\'); return false;" />'
										+ '<input type="hidden" id="layer_' + droneProject.drone_project_id + '" value="0" />';
				}
				
			} else {
				droneProjectListHtml += '<span>' + droneProject.drone_project_name + '</span>';
			}
			droneProjectListHtml += '</li>';
			droneProjectListHtml += '<li class="half" title="촬영일자"><label class="date" >촬영일자</label>' + droneProject.viewShootingDate + '</li>';
			droneProjectListHtml += '<li class="half"><label class="step">진행단계</label>';
			if (droneProject.status === "0") {
				droneProjectListHtml += '<label class="message">준비중</label>';
			} else if (droneProject.status === "1") {
				droneProjectListHtml += '<label class="message">점검/테스트</label>';
			} else if (droneProject.status === "2") {
				droneProjectListHtml += '<label class="message ing">개별 정사영상</label>';
			} else if (droneProject.status === "3") {
				droneProjectListHtml += '<label class="message ing">후처리 영상</label>';
			} else if (droneProject.status === "4") {
				droneProjectListHtml += '<label class="message">프로젝트 종료</label>';
			} else {
				droneProjectListHtml += '<label class="message error">에러</label>';
			}
			droneProjectListHtml += '</li>';
			droneProjectListHtml += '<li title="촬영지역"><label class="location">촬영지역</label>' + droneProject.shooting_area + '</li>';
			droneProjectListHtml += '<li class="" title="실시간정사영상"> <label class="js">정사영상</label><span>: ' + droneProject.ortho_image_count + '</span>장' 
								+ '<ul class="detect">'
								+ '<li class="ship">' + droneProject.ortho_detected_object_count + '</li>'
								+ '<li class="oil">' + droneProject.ortho_detected_object_count + '</li>'
								+ '</ul></li>';
			droneProjectListHtml += '<li class="half" class="half" title="후처리영상"><label class="hc">후처리영상</label>' 
								+ '<span>: ' + droneProject.postprocessing_image_count + '</span>장</li>';
			droneProjectListHtml += '</ul>';
			
		}
		$("#projectList").html(droneProjectListHtml);
	}
	
	function drawDroneData() {
		for (var i = 0; i < DRONE_PROJECT_ARRAY.length; i++) {
			var droneProject = DRONE_PROJECT_ARRAY[i];
			var droneProjectId = droneProject.drone_project_id;
			
			TRANSFER_DATA_COUNT_ARRAY[i] = droneProject.ortho_image_count + droneProject.postprocessing_image_count;
			
			drawDronePath(i, droneProjectId, droneProject.status);
			if (DRONE_IMAGE_REFRESH_FLAG_ARRAY[i]) {
				drawDetailDroneImage(i, droneProjectId, droneProject.status);
			} else {
				viewer.imageryLayers.remove(DRONE_IMAGE_PROVIDER_ARRAY[i], true);
	   			viewer.imageryLayers.remove(DETECTED_OBJECTS_PROVIDER_ARRAY[i], true);
			}
		}
	}
	
	function drawDronePath(index, droneProjectId, droneProjectStatus) {
		$.ajax({
			url: "/drone-project/" + droneProjectId + "/transfer-datas",
			type: "GET",
			data: null,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					console.log("droneProjectId = " + droneProjectId + ", droneProjectStatus = " + droneProjectStatus);
					if (msg.transferDataListSize > 0) {
						drawDroneMovingPath(index, droneProjectId, droneProjectStatus, msg);
					}
				} else {
					console.log(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request, status, error) {
				console.log(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
			}
		});
	}
	
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
    
	// 이미지 그리기 
	function drawDetailDroneImage(index, droneProjectId, deleteFlag) {
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
					
					setTimeout(function() {
						viewer.imageryLayers.remove(postDroneImageLayer, true);
						viewer.imageryLayers.remove(postDetectedObjectsProvider, true);
					}, INTERVAL_TIME/2);
					
				} else {
					console.log(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request, status, error){
				console.log(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
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
		    	//,styles : "ortho_detected_object"
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
    function drawDroneMovingPath(index, droneProjectId, droneProjectStatus, msg) {
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
		
		var postDronePath = DRONE_PATH_ARRAY[index];
		
		DRONE_PATH_ARRAY[index] = viewer.entities.add({
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
		
		setTimeout(function() {
			viewer.entities.remove(postDronePath, true);
		}, INTERVAL_TIME/2)
		
		// 드론 이미지
		viewer.entities.remove(BILLBOARD_ARRAY[index], true);
		var droneImage = '/images/${lang}/drone_working.png';
		if(droneProjectStatus === "4" || droneProjectStatus === "5") {
			droneImage = '/images/${lang}/drone_done.png';
		};
		BILLBOARD_ARRAY[index] = viewer.entities.add({
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
</script>
</body>
</html>

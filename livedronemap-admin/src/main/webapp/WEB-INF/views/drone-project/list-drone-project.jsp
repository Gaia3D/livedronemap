<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>프로젝트 목록 | LiveDroneMap</title>
  	<link rel="stylesheet" href="/css/${lang}/style.css">
  	 <link rel="stylesheet" href="/externlib/cesium_orgin/Widgets/widgets.css?cache_version=${cache_version}" /> 
    <link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script src="/externlib/cesium_orgin/Cesium.js"></script>
	  <style>
	      html, body, #cesiumContainer {
	          height:100%; margin: 0; padding: 0; overflow: hidden;
	      }
	  </style>
</head>
<body>
  <body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="wrap">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<!-- S: 1depth / 프로젝트 목록 -->
	<div class="subWrap" style="">
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
						<form:input path="search_value" type="search" cssClass="m" />
					</div>
					<div class="input-set">
						<label for="start_date"><spring:message code='search.date'/></label>
						<input type="text" class="s date" id="start_date" name="start_date" />
						<span class="delimeter tilde">~</span>
						<input type="text" class="s date" id="end_date" name="end_date" />
					</div>
					<div class="input-set">
						<label for="order_word"><spring:message code='search.order'/></label>
						<select id="order_word" name="order_word" class="select" style="height: 30px;">
							<option value=""> <spring:message code='search.basic'/> </option>
							<option value="drone_project_name">프로젝트명</option>
							<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
						</select>
						<select id="order_value" name="order_value" class="select" style="height: 30px;">
	                		<option value=""> <spring:message code='search.basic'/> </option>
		                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
							<option value="DESC"> <spring:message code='search.descending.order'/> </option>
						</select>
						<select id="list_counter" name="list_counter" class="select" style="height: 30px;">
	                		<option value="10"> <spring:message code='search.ten.count'/> </option>
		                	<option value="50"> <spring:message code='search.fifty.count'/> </option>
							<option value="100"> <spring:message code='search.hundred.count'/> </option>
						</select>
					</div>
					<div class="input-set">
						<input type="submit" value="<spring:message code='search'/>" />
					</div>
				</div>
			</form:form>
			<div class="count">
				<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/> 
				<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
			</div>
			<div class="projectList"><!-- 브라우저 높이에 따라 자동조정, 세로스크롤 됨 -->
<c:if test="${empty droneProjectList }">				
				<ul class="projectInfo">
					<li class="title" style="height: 60px; padding-top: 30px;">드론 프로젝트가 존재하지 않습니다.</li>
				</ul>
</c:if>
<c:if test="${!empty droneProjectList }">
	<c:forEach var="droneProject" items="${droneProjectList}" varStatus="status">				
				<ul class="projectInfo">
					<li class="title">${droneProject.drone_project_name}</li>
					<li title="촬영일자">
						<label class="date" >촬영일자</label> ${droneProject.shooting_date}
						<label class="js">정사영상</label><span>45</span>장
						<label class="hc">후처리영상</label><span>7</span>장
					</li>
				</ul>
	</c:forEach>
</c:if>

				<ul class="projectInfo">
					<li class="title">병풍도 주변해역 불법선박 정찰</li>
					<li title="촬영일자">
						<label class="date" >촬영일자</label> 2018.09.01
						<label class="js">정사영상</label><span>45</span>장
						<label class="hc">후처리영상</label><span>7</span>장
					</li>
					<li>
						<label class="step">진행단계</label> 2단계-드론촬영 중
						<button type="button" title="상태모니터링" class="typeB">상태모니터링</button>
					</li>
				</ul>	
			</div>
			
			<%@ include file="/WEB-INF/views/common/sub-pagination.jsp" %>
		</div>
		<!-- E: 영상목록 -->
	</div>
	<!-- E: 1depth / 프로젝트 목록 -->
	
	<div id="cesiumContainer" >
	</div>
	<!-- E: MAPWRAP -->
</div>
<!-- E: wrap -->

  <script>
  	var imageryProvider = new Cesium.ArcGisMapServerImageryProvider({
		url : 'https://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer',
		enablePickFeatures: false
	});

  	Cesium.Camera.DEFAULT_VIEW_RECTANGLE = Cesium.Rectangle.fromDegrees(115.0, -20.0, 140.0, 90.0);
	var viewer = new Cesium.Viewer('cesiumContainer', {imageryProvider : imageryProvider, baseLayerPicker : true, animation:false, timeline:false, fullscreenButton:false});
    //var viewer = new Cesium.Viewer('cesiumContainer');
    
    cameraFlyTo(127.827348, 36.590489, 2000000, 3);
    function cameraFlyTo(longitude, latitude, altitude, duration) {
		viewer.camera.flyTo({
			destination: Cesium.Cartesian3.fromDegrees(parseFloat(longitude),
				parseFloat(latitude),
				parseFloat(altitude)),
			duration: parseInt(duration)
		});
	}
    
    
  </script>
</body>
</html>

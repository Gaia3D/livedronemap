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
					</li>
					<li>
						<label class="location" title="촬영지역"></label>
						<span style="display: inline-block; width: 100px;">${droneProject.shooting_area }</span>
						<label class="js" title="개별정사영상"></label>
						<span style="display: inline-block; width: 45px;">${droneProject.ortho_image_count }장</span>
						<label class="hc" title="후처리영상"></label>
						<span>${droneProject.postprocessing_image_count }장</span>
					</li>
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
						<label class="date" title=""></label>
						<span>${droneProject.viewShootingDate}</span>	
					</li>
				</ul>
	</c:forEach>
</c:if>
			</div>
			
			<%@ include file="/WEB-INF/views/common/sub-pagination.jsp" %>
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
	
	var viewer = new Cesium.Viewer('droneMapContainer', {imageryProvider : imageryProvider, baseLayerPicker : true, animation:false, timeline:false, fullscreenButton:false});
    
	$(document).ready(function() {
		cameraFlyTo(127.827348, 36.590489, 2000000, 3);
		drawDroneProject();
		
		initJqueryCalendar();
	});
	
	// 가장 최근 프로젝트 중 종료와 에러 이외의 프로젝트만 표시
    function drawDroneProject() {
		var droneProjectList = new Array();
    	<c:if test="${!empty droneProjectList }">
    		<c:forEach var="droneProject" items="${droneProjectList}" varStatus="status">
    			<c:if test="${droneProject.status ne '4' and droneProject.status ne '5'}">
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
    
    viewer.zoomTo(viewer.entities);
</script>
</body>
</html>

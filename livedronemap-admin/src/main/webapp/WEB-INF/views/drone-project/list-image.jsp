<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>프로젝트 목록 | LiveDroneMap</title>
	<!-- <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" /> -->
	<link rel="stylesheet" href="/css/${lang}/style.css">
    <link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cache_version=${cache_version}" /> 
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/mago3d.js"></script>
    <script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="wrap" style="height: 850px;"><!-- 브라우저에 맞게 높이조절, Header없을때 높이조절 -->
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<!-- S: 2depth / 프로젝트 상세 -->
	<div class="subWrap" style="">
		<!-- S: 프로젝트 제목, 목록가기, 닫기 -->
		<div class="subHeader">
			<h2>병풍도주변해역 불법선박 신고 정찰</h2>
			<div class="ctrlBtn">
				<button type="button" title="목록" class="goList on" onclick="gotoList();">목록</button>
				<button type="button" title="닫기" class="close">닫기</button>
			</div>
		</div>
		<!-- E: 프로젝트 제목, 목록가기, 닫기 -->
		
		<!-- S: 프로젝트 정보 -->
		<ul class="projectInfo">
			<li class="half" title="촬영일자"><label class="date" >촬영일자</label> 2018.09.01</li>
			<li class="half" title="촬영지역"><label class="location">촬영지역</label> 병풍도주변해역</li>
			<li class="half" title="실시간정사영상">
				<label class="js">정사영상</label>
				<span>45</span>장
				<ul class="detect">
					<li class="ship">6</li>
					<li class="oil">7</li>
				</ul>
			</li>
			<li class="half" title="후처리영상">
				<label class="hc">후처리영상</label>
				<span>7</span>장</li>
			<li>
				<label class="step">진행단계</label> <span class="state good"></span>원활 / 2단계-드론촬영 중
				<button type="button" title="상태모니터링" class="typeB">상태모니터링</button>
			</li>
		</ul>
		<!-- E: 프로젝트 정보 -->

		<!-- S: 영상목록 -->
		<div class="subContents">
			<ul class="sceneListHeader">
				<li><button type="button" title="보임" class="ico sceneOn">보임</button></li><!-- Toggle버튼 sceneOn, sceneOff -->
				<li class="type">
					<select name="" id="">
						<option value="">전체</option>
						<option value="">실시간</option>
						<option value="">후처리</option>
					</select>
				</li>
				<li class="filename"><span>파일명</span></li>
				<li class="type">
					<select name="" id="">
						<option value="">전체</option>
						<option value="">선박</option>
						<option value="">기름</option>
					</select>
				</li>
			</ul>
			<ul class="sceneList" style="height: 250px;"><!-- 브라우저 높이에 따라 자동조정, 세로스크롤 됨 -->
				<li class="on">
					<button type="button" title="보임" class="ico sceneOn">보임</button>
					<span class="type js">실시간</span>
					<span class="title">project_A_201809092130_ace</span>
					<span class="ico ship">불법선박</span>
				</li>
				<li>
					<button type="button" title="숨김" class="ico sceneOff">숨김</button>
					<span class="type hc">후처리</span>
					<span class="title off">project_A_201809092130_ace</span>
				</li>
				<li>
					<button type="button" title="보임" class="ico sceneOn">보임</button>
					<span class="type js">실시간</span>
					<span class="title">project_A_201809092130_ace</span>
				</li>
				<li>
					<button type="button" title="보임" class="ico sceneOn">보임</button>
					<span class="type js">실시간</span>
					<span class="title">project_A_201809092130_ace</span>
					<span class="ico ship">불법선박</span>
				</li>
				<li>
					<button type="button" title="숨김" class="ico sceneOff">숨김</button>
					<span class="type js">실시간</span>
					<span class="title off">project_A_201809092130_ace</span>
				</li>
				<li>
					<button type="button" title="보임" class="ico sceneOn">보임</button>
					<span class="type js">실시간</span>
					<span class="title">project_A_201809092130_ace</span>
					<span class="ico oil">기름유출</span>
				</li>
				<li>
					<button type="button" title="보임" class="ico sceneOn">보임</button>
					<span class="type js">실시간</span>
					<span class="title">project_A_201809092130_ace</span>
				</li>
			</ul>
		</div>
		<!-- E: 영상목록 -->
	</div>
	<!-- E: 2depth / 프로젝트 상세 -->
	
	<div id="mapWrap" style="width: 700px;">
		<div class="ctrlBtn">
			<button type="button" class="divide on" title="화면분할">화면분할</button><!-- 프로젝트 상세화면일때 보여짐-->
			<button type="button" class="fullscreen" title="전체화면">전체화면</button>
		</div>
		
		<div class="zoom">
			<button type="button" class="zoomin">확대</button>
			<button type="button"  class="zoomout">축소</button>
		</div>
			
		<div class="mapInfo">
			<span>127.156797, 38.012334</span>
			<span>100km</span>
		</div>
	</div>
	
	<!-- E: MAPWRAP -->
	
	<div id="viewWrap" style="width: 700px; display: ;">
		<div class="ctrlBtn">
			<button type="button" class="connect on" title="동기화">동기화</button>
		</div>
		<div class="zoom">
			<button type="button" class="zoomin">확대</button>
			<button type="button"  class="zoomout">축소</button>
		</div>
	</div>
	<!-- E: VIEWWRAP -->
</div>
<!-- E: warp -->

<script type="text/javascript">
	function gotoList() {
		location.href= "/drone-project/list-drone-project";
	}
</script>


<script> 	
//	var viewer = new Cesium.Viewer('cesiumContainer'); 
//    flyToPosition(viewer, 126.08588218688966, 36.636128043375784, 1200, 0, -90, 6);
    
	var managerFactory = null;
	var insertIssueEnable = false;

	var imagePath = "/images/${lang}";
	var dataInformationUrl = "/data/";
	magoStart(null, "mapWrap", imagePath);
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

    // mago3d start, policy loading
	function magoStart(viewer, renderDivId, imagePath) {
		$.ajax({
			url:dataInformationUrl+"mago3d-policy-cesium.json",
			type: "GET",
			dataType: "json",
			success: function(serverPolicy){
				loadData(viewer, renderDivId, serverPolicy);
			},
			error: function(e){
				alert(e.responseText);
			}
		});
	}

	// init project load
	function loadData(viewer, renderDivId, serverPolicy) {
		if(serverPolicy.geo_data_default_projects === null || serverPolicy.geo_data_default_projects.length < 1) {
			managerFactory = new ManagerFactory(viewer, renderDivId, serverPolicy, null, null, null, imagePath);	
		} else {
			var defaultProjectArray = serverPolicy.geo_data_default_projects;
			var projectIdArray = new Array(defaultProjectArray.length);
			var projectDataArray = new Array(defaultProjectArray.length);
			var projectDataFolderArray = new Array(defaultProjectArray.length);
			
			var dataCount = 0;
			defaultProjectArray.forEach(function(projectId, index) {
				projectIdArray[index] = projectId;
				console.log("url = " + dataInformationUrl + projectId);
				$.ajax({
					url: dataInformationUrl + projectId,
					type: "GET",
					dataType: "json",
					success: function(serverData) {
						console.log("index = " + index + ", data = " + serverData);
						projectDataArray[index] = serverData;
						projectDataFolderArray[index] = serverData.data_key;
						if(defaultProjectArray.length === (dataCount + 1)) {
							createManagerFactory(viewer, renderDivId, serverPolicy, projectIdArray, projectDataArray, projectDataFolderArray, imagePath);
						}
						dataCount++;
					},
					error: function(e){
						alert(e.responseText);
					}
				});
			});
		}
	}
	
	function createManagerFactory(viewer, renderDivId, serverPolicy, projectIdArray, projectDataArray, projectDataFolderArray, imagePath) {
		managerFactory = new ManagerFactory(viewer, renderDivId, serverPolicy, projectIdArray, projectDataArray, projectDataFolderArray, imagePath);
	}	
	// click poisition call back function
	function showClickPosition(position) {
//		$("#positionLatitude").val(position.lat);
//		$("#positionLongitude").val(position.lon);
//		$("#positionAltitude").val(position.alt);
	}
	
    </script>
</body>
</html>
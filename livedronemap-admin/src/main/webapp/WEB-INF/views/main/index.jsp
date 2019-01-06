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
	
	<!-- S: 1depth / 프로젝트 목록 -->
	<div class="subWrap" style="">
		<!-- S: 프로젝트 제목, 목록가기, 닫기 -->
		<div class="subHeader">
			<h2>프로젝트</h2>
			<div class="ctrlBtn">
				<button type="button" title="닫기" class="close">닫기</button>
			</div>
		</div>
		<!-- E: 프로젝트 제목, 목록가기, 닫기 -->
				
		<div class="subContents">
			<div class="sorting">
				<select name="" id="">
					<option value="">전체</option>
					<option value="">최신순</option>
					<option value="">과거순</option>
				</select>
				<select name="" id="">
					<option value="">연도별</option>
					<option value="">2018</option>
					<option value="">2017</option>
					<option value="">2016</option>
				</select>
				<select name="" id="">
					<option value="">이슈별</option>
					<option value="">전체</option>
					<option value="">불법선박</option>
					<option value="">오일유출</option>
				</select>
			</div>

			<div class="projectList" style="height:470px;"><!-- 브라우저 높이에 따라 자동조정, 세로스크롤 됨 -->
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
				
				<ul class="projectInfo">
					<li class="title">굴업도 기름유출</li>
					<li title="촬영일자">
						<label class="date" >촬영일자</label> 2018.09.01
						<label class="js">정사영상</label><span>45</span>장
						<label class="hc">후처리영상</label><span>7</span>장
					</li>
				</ul>
				
				<ul class="projectInfo">
					<li class="title">병풍도 주변해역 불법선박 정찰</li>
					<li title="촬영일자">
						<label class="date" >촬영일자</label> 2018.09.01
						<label class="js">정사영상</label><span>45</span>장
						<label class="hc">후처리영상</label><span>7</span>장
					</li>
				</ul>
				
				<ul class="projectInfo">
					<li class="title">굴업도 기름유출</li>
					<li title="촬영일자">
						<label class="date" >촬영일자</label> 2018.09.01
						<label class="js">정사영상</label><span>45</span>장
						<label class="hc">후처리영상</label><span>7</span>장
					</li>
				</ul>
				
				<ul class="projectInfo">
					<li class="title">병풍도 주변해역 불법선박 정찰</li>
					<li title="촬영일자">
						<label class="date" >촬영일자</label> 2018.09.01
						<label class="js">정사영상</label><span>45</span>장
						<label class="hc">후처리영상</label><span>7</span>장
					</li>
				</ul>
				
				<ul class="projectInfo">
					<li class="title">굴업도 기름유출</li>
					<li title="촬영일자">
						<label class="date" >촬영일자</label> 2018.09.01
						<label class="js">정사영상</label><span>45</span>장
						<label class="hc">후처리영상</label><span>7</span>장
					</li>
				</ul>
				
				<ul class="projectInfo">
					<li class="title">굴업도 기름유출</li>
					<li title="촬영일자">
						<label class="date" >촬영일자</label> 2018.09.01
						<label class="js">정사영상</label><span>45</span>장
						<label class="hc">후처리영상</label><span>7</span>장
					</li>
				</ul>
				
				<ul class="projectInfo">
					<li class="title">병풍도 주변해역 불법선박 정찰</li>
					<li title="촬영일자">
						<label class="date" >촬영일자</label> 2018.09.01
						<label class="js">정사영상</label><span>45</span>장
						<label class="hc">후처리영상</label><span>7</span>장
					</li>
				</ul>
				
				<ul class="projectInfo">
					<li class="title">병풍도 주변해역 불법선박 정찰</li>
					<li title="촬영일자">
						<label class="date" >촬영일자</label> 2018.09.01
						<label class="js">정사영상</label><span>45</span>장
						<label class="hc">후처리영상</label><span>7</span>장
					</li>
				</ul>
				
				<ul class="projectInfo">
					<li class="title">병풍도 주변해역 불법선박 정찰</li>
					<li title="촬영일자">
						<label class="date" >촬영일자</label> 2018.09.01
						<label class="js">정사영상</label><span>45</span>장
						<label class="hc">후처리영상</label><span>7</span>장
					</li>
				</ul>
			</div>
			
			<%@ include file="/WEB-INF/views/common/sub-pagination.jsp" %>
		</div>
		<!-- E: 영상목록 -->
	</div>
	<!-- E: 1depth / 프로젝트 목록 -->
	
	<div id="mapWrap" >
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
	
<!--  	<div id="viewWrap" style="width: 700px; display: none;">
		<div class="ctrlBtn">
			<button type="button" class="connect on" title="동기화">동기화</button>
		</div>
		<div class="zoom">
			<button type="button" class="zoomin">확대</button>
			<button type="button"  class="zoomout">축소</button>
		</div>
	</div> -->
	<!-- E: VIEWWRAP -->
</div>
<!-- E: warp -->

<script>
	// resize
	function mapWrapResize() {
		var mapWrap = document.getElementById('mapWrap');
		mapWrap.style.width = window.innerWidth - 410 + 'px';
    }
	mapWrapResize();
	// 브라우저 크기가 변할 시 동적으로 사이즈를 조절해야 하는경우
	window.addEventListener('resize', mapWrapResize);
	
	// mago3D
	
    var options = {homeButton: false, infoBox: false, sceneModePicker: false, baseLayerPicker: true, geocoder: false, navigationHelpButton: false};
	var viewer = new Cesium.Viewer('mapWrap', options);
	
	var rectangle = new Cesium.RectangleOutlineGeometry({
		  ellipsoid : Cesium.Ellipsoid.WGS84,
		  rectangle : Cesium.Rectangle.fromDegrees(-100.0, 20.0, -90.0, 30.0),
		  height : 10000.0
		});
	var geometry = Cesium.RectangleOutlineGeometry.createGeometry(rectangle);
	
	var redRectangle = viewer.entities.add({
	    name : 'Red translucent rectangle',
	    rectangle : {
	        coordinates : Cesium.Rectangle.fromDegrees(-110.0, 20.0, -80.0, 25.0),
	        material : Cesium.Color.RED.withAlpha(0.5)
	    }
	});
	
	var managerFactory = null;
	var insertIssueEnable = false;

	var imagePath = "/images/${lang}";
	var dataInformationUrl = "/data/";
	magoStart(viewer, "mapWrap", imagePath); 
	var intervalCount = 0;
	var timerId = setInterval("startMogoUI()", 1000);
	



	function startMogoUI() {
		intervalCount++;
		if(managerFactory != null && managerFactory.getMagoManagerState() === CODE.magoManagerState.READY) {
			clearInterval(timerId);
			console.log(" managerFactory != null, managerFactory.getMagoManagerState() = " + managerFactory.getMagoManagerState() + ", intervalCount = " + intervalCount);
			return;
		}
		//console.log("--------- intervalCount = " + intervalCount);
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
				//console.log("url = " + dataInformationUrl + projectId);
				$.ajax({
					url: dataInformationUrl + projectId,
					type: "GET",
					dataType: "json",
					success: function(serverData) {
						//console.log("index = " + index + ", data = " + serverData);
						projectDataArray[index] = serverData;
						projectDataFolderArray[index] = serverData.data_key;
						if(defaultProjectArray.length === (dataCount + 1)) {
							createManagerFactory(viewer, renderDivId, serverPolicy, projectIdArray, projectDataArray, projectDataFolderArray, imagePath);
							//changeMagoStateAPI(managerFactory,false);

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
	}
	
</script>

</body>
</html>
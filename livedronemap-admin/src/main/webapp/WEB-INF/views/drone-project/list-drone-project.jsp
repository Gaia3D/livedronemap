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
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
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

</body>
</html>
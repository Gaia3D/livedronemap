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
	<link rel="stylesheet" href="/css/tmp-style.css">
    <link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cache_version=${cache_version}" /> 
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/mago3d.js"></script>
    <script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="wrapCon" style="height: 850px;"><!-- 브라우저에 맞게 높이조절, Header없을때 높이조절 -->
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<div id="contentsWrap" style="width:80%;">
		<div class="contents full" style="width:100%;">
		<h2>환경설정</h2>
			<div class="tabs">
				<ul>
					<li><a href="#user_tab">사용자</a></li>
					<li><a href="#password_tab">비밀번호</a></li>
					<li><a href="#geoserver_tab">GeoServer</a></li>
					<li><a href="#restapi_tab">RestAPI</a></li>
					<li><a href="#project_tab">프로젝트</a></li>
					<li><a href="#notice_tab">알림</a></li>
					<li><a href="#security_tab">보안</a></li>
					<li><a href="#userupload_tab">파일 전송</a></li>
					<li><a href="#site_tab">사이트 정보</a></li>
					<li><a href="#solution_tab">제품 정보</a></li>
				</ul>
				
				<%@ include file="/WEB-INF/views/config/modify-policy-user.jsp" %>
			</div>
			
		</div>
		<!-- CONTENTS -->
	</div>
	<!-- E: CONTENTSWRAP -->
	
</div>
<!-- E: warp -->

<script>
	$(document).ready(function() {
		$( ".tabs" ).tabs();
	});
</script>

</body>
</html>
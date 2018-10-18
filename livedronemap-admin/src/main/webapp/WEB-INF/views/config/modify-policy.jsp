<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title><spring:message code='config.policy'/> | LiveDroneMap</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" /> 
	<link rel="stylesheet" href="/css/${lang}/style.css">
    <link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cache_version=${cache_version}" /> 
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/mago3d.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
    <script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="contentsWrap">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<%@ include file="/WEB-INF/views/config/config-menu.jsp" %>
	
	<div class="contents limited">
		<h3><spring:message code='config.policy'/></h3>
		
		<div class="tabs">
				<ul>
					<li><a href="#user_tab"><spring:message code='config.user.title'/></a></li>
					<li><a href="#password_tab"><spring:message code='config.password.title'/></a></li>
					<li><a href="#geoserver_tab"><spring:message code='config.geoserver.title'/></a></li>
					<li><a href="#restapi_tab"><spring:message code='config.restapi.title'/></a></li>
					<li><a href="#project_tab"><spring:message code='config.project.title'/></a></li>
					<li><a href="#notice_tab"><spring:message code='config.notice.title'/></a></li>
					<li><a href="#security_tab"><spring:message code='config.security.title'/></a></li>
					<li><a href="#upload_tab"><spring:message code='config.uplaod.title'/></a></li>
					<li><a href="#site_tab"><spring:message code='config.site.title'/></a></li>
					<li><a href="#solution_tab"><spring:message code='config.solution.title'/></a></li>
				</ul>
				
				<%@ include file="/WEB-INF/views/config/modify-policy-user.jsp" %>
				<%@ include file="/WEB-INF/views/config/modify-policy-password.jsp" %>
				<%@ include file="/WEB-INF/views/config/modify-policy-geoserver.jsp" %>
				<%@ include file="/WEB-INF/views/config/modify-policy-restapi.jsp" %>
				<%@ include file="/WEB-INF/views/config/modify-policy-project.jsp" %>
				<%@ include file="/WEB-INF/views/config/modify-policy-notice.jsp" %>
				<%@ include file="/WEB-INF/views/config/modify-policy-security.jsp" %>
				<%@ include file="/WEB-INF/views/config/modify-policy-upload.jsp" %>
				<%@ include file="/WEB-INF/views/config/modify-policy-site.jsp" %>
				<%@ include file="/WEB-INF/views/config/modify-policy-solution.jsp" %>
			</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#configMenu").addClass("on");
		$("#policyMenu").addClass("on");
		$( ".tabs" ).tabs();
	});
</script>

</body>
</html>
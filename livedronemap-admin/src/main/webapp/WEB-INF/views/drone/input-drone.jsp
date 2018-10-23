<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>드론 등록 | LiveDroneMap</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" /> 
	<link rel="stylesheet" href="/css/${lang}/style.css">
    <link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/live-drone-map.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="contentsWrap" style="">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<%@ include file="/WEB-INF/views/device/device-menu.jsp" %>

	<div class="contents limited"><!-- 컨텐츠영역을 100%로 사용하려면 limited를 삭제하세요 -->
		<h3>드론 등록</h3>
		<form:form id="drone" modelAttribute="drone" method="post" onsubmit="return false;">
		<div class="boardNew">
			<table class="input-table scope-row">
				<tr>
					<th style="width: 100px" scope="row">
						<span class="required"><form:label path="drone_name"><spring:message code='drone.name'/></form:label></span>
					</th>
					<td>
						<form:input path="drone_name" cssClass="m" />
						<form:errors path="drone_name" cssClass="error" />
					</td>
				</tr>			
			</table>
			<div class="alignCenter">
				<button type="button" class="basic" onclick="insertDrone();"><spring:message code='save'/></button>
				<button type="button" class="basic">목록</button>
			</div>
		</div>
		</form:form>
		<!-- END BOARD NEW -->
	</div>
	<!-- E: CONTENTS -->
</div>
<!-- E: wrap -->
		
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#deviceMenu").addClass("on");
	$("#droneMenu").addClass("on");

});

	
	// drone 정보 저장
	var insertDroneFlag = true;
	function insertDrone() {
		if (checkDrone() == false) {
			return false;
		}
		if(insertDroneFlag) {
			insertDroneFlag = false;
			var drone = $("#drone").serialize();
			$.ajax({
				url: "/drones",
				type: "POST",
				data: drone,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["insert"]);
						$('form').each(function(){
						    this.reset();
						});
					}
					insertDroneFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertDroneFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	function checkDrone() {
		if ($("#drone_name").val() == "") {
			alert(JS_MESSAGE["drone.name.empty"]);
			$("#drone_name").focus();
			return false;
		}
	}
</script>
</body>
</html>

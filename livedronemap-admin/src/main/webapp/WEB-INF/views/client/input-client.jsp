<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>클라이언트 등록 | LiveDroneMap</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" /> 
	<link rel="stylesheet" href="/css/${lang}/style.css">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="contentsWrap" style="">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
		<div class="snb">
		<h2 class="schedule"><span>클라이언트</span></h2>
		<ul>
			<li class="on" title="클라이언트 등록">클라이언트 등록</li>
			<li class="" title="클라이언트 목록">클라이언트 목록</li>
		</ul>
		</div>

	<div class="contents limited"><!-- 컨텐츠영역을 100%로 사용하려면 limited를 삭제하세요 -->
		<h3>클라이언트 등록</h3>
		<form:form id="client" modelAttribute="client" method="post" onsubmit="return false;">
		<div class="boardNew">
			<table class="input-table scope-row">
				<tr>
					<th style="width: 140px" scope="row">
						<span class="required"><form:label path="client_name"><spring:message code='client.name'/></form:label></span>
					</th>
					<td>
						<form:input path="client_name" cssClass="m" />
						<form:errors path="client_name" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<span class="required"><form:label path="client_group_id"><spring:message code='client.group'/></form:label></span>
					</th>
					<td >
						<select id="client_group_id" name="client_group_id" class="select" style="width:150px" >
<c:forEach var="clientGroup" items="${clientGroupList }">
							<option value="${clientGroup.client_group_id }">${clientGroup.group_name }</option>
</c:forEach>									
						</select>
					</td>
				</tr>				
				<tr>
					<th scope="row">
					<span class="required"><form:label path="client_ip"><spring:message code='client.ip'/></form:label></span>
					<td>
						<form:input path="client_ip" cssClass="m" />
						<form:errors path="client_ip" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<form:label path="use_yn"><spring:message code='client.use'/></form:label>
					</th>
					<td >
						<spring:message var='use' code='use'/>
						<spring:message var='noUse' code='no.use'/>
						<form:radiobutton path="use_yn" value="Y" label="${use}" />
						<form:radiobutton path="use_yn" value="N" label="${noUse}" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<span class="required"><form:label path="api_key"><spring:message code='client.apikey'/></form:label></span>
					<td>
						<form:hidden path="apikey_duplication" />
						<form:hidden path="check_generate_apikey" />
				 		<form:input path="api_key" size= "40px" cssClass="m" readonly="true" />
						<input type="button" id="generate" value="<spring:message code='client.generate'/>" />
						
					</td>
				</tr>
				
				<tr>
					<th scope="row">
						<span><form:label path="description"><spring:message code='client.description'/></form:label></span>
					</th>
					<td>
						<form:textarea  path="description" cols="100" rows="4" />
						<form:errors path="description" cssClass="error" />
					</td>
				</tr>	

								
			</table>
			<div class="alignCenter">
				<button type="button" class="basic" onclick="insertClient();"><spring:message code='save'/></button>
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
		$("input[name='use_yn'][value='N']").prop('checked', true);
		$("#check_generate_apikey").val("0");
		$("#apikey_duplication").val(" ");
	});
	
	// apikey 발급
	$( "#generate" ).on( "click", function() {
		var apikey = "";
		$.ajax({
			url: "/client/ajax-generate-api-key",
			type: "POST",
			data: apikey,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					
					if($("#check_generate_apikey").val() == "0") {
						apikey = msg.apikey;
						$("#apikey_duplication").val(apikey); 
						$("#check_generate_apikey").val("1");
						$("#api_key").val($("#apikey_duplication").val());
						alert(JS_MESSAGE["client.apikey.generate"]);
						return false;
					}
					else {
						alert(JS_MESSAGE["client.apikey.generate"]);
					}
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request, status, error) {
				//alert(JS_MESSAGE["ajax.error.message"]);
				alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
    		}
		});

	});
	
	// client 정보 저장
	var insertClientFlag = true;
	function insertClient() {
		if (checkClient() == false) {
			return false;
		}
		if(insertClientFlag) {
			insertClientFlag = false;
			$.ajax({
				url: "/clients",
				type: "POST",
				data: $("#client").serialize(),
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["insert"]);
						$('form').each(function(){
						    this.reset();
						});
						$("input[name='use_yn'][value='N']").prop('checked', true);
						$("#check_generate_apikey").val("0");
						$("#apikey_duplication").val(" ");
					}
					insertClientFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertClientFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	function checkClient() {
		if ($("#client_name").val() == "") {
			alert(JS_MESSAGE["client.name.empty"]);
			$("#client_name").focus();
			return false;
		}
		if ($("#client_group_id").val() == "") {
			alert(JS_MESSAGE["client.group.required"]);
			$("#client_group_id").focus();
			return false;
		}
		
		client_group_id
		
		if ($("#client_ip").val() == "") {
			alert(JS_MESSAGE["client.ip.empty"]);
			$("#client_ip").focus();
			return false;
		} else if (!isIP($("#client_ip").val())) {
			alert(JS_MESSAGE["client.ip.invalid"]);
			$("#client_ip").focus();
			return false;
		}
				
		if ($("#api_key").val() == "" || ($("#check_generate_apikey").val() == "0")) {
			alert(JS_MESSAGE["client.apikey.empty"]);
			$("#api_key").focus();
			return false;
		}
	
	}
	
	
</script>
</body>
</html>

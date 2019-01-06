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
    <link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/live-drone-map.js"></script>
	<style>
		div.boardNew>table tr td>input {
			padding: 0px;
		}
		.ui-widget {
		    font-family: 'Malgun Gothic','돋움',dotum, sans-serif;
		    font-size: 15px;
		}
	</style>
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
					<li><a href="#simulation_tab"><spring:message code='config.simulation.title'/></a></li>
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
				<%@ include file="/WEB-INF/views/config/modify-policy-simulation.jsp" %>
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
	
	var updateUserFlag = true;
	function updatePolicyUser() {
		if(updateUserFlag) {
			if($("#user_id_min_length").val() == "") {
				alert(JS_MESSAGE["policy.user.id.min.length"]);
				$("#user_id_min_length").focus();
				return;
			}
			if(!isNumber($("#user_id_min_length").val())) {
				$("#user_id_min_length").focus();
				return;
			}
			if(parseInt($("#user_id_min_length").val()) < 4) {
				alert(JS_MESSAGE["policy.user.id.min.length.rule"]);
				$("#user_id_min_length").focus();
				return;
			}
			if($("#user_fail_login_count").val() == "") {
				alert(JS_MESSAGE["policy.user.login.fail"]);
				$("#user_fail_login_count").focus();
				return;
			}
			if(!isNumber($("#user_fail_login_count").val())) {
				$("#user_fail_login_count").focus();
				return;
			}
			/* if($("#user_fail_lock_release").val() == "") {
				alert("로그인 실패 잠금 해제 기간을 입력하여 주십시오.");
				$("#user_fail_lock_release").focus();
				return;
			}
			if(!isNumber($("#user_fail_lock_release").val())) {
				$("#user_fail_lock_release").focus();
				return;
			} */
			if($("#user_last_login_lock").val() == "") {
				alert(JS_MESSAGE["policy.user.lockout.period"]);
				$("#user_last_login_lock").focus();
				return;
			}
			if(!isNumber($("#user_last_login_lock").val())) {
				$("#user_last_login_lock").focus();
				return;
			}
			
			updateUserFlag = false;
			var info = $("#policyUser").serialize();
			$.ajax({
				url: "/config/ajax-update-policy-user.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.user.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateUserFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUserFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	var updatePasswordFlag = true;
	function updatePolicyPassword() {
		if(updatePasswordFlag) {
			if($("#password_change_term").val() == "") {
				alert(JS_MESSAGE["policy.password.period"]);
				$("#password_change_term").focus();
				return;
			}
			if(!isNumber($("#password_change_term").val())) {
				$("#password_change_term").focus();
				return;
			}
			if($("#password_min_length").val() == "") {
				alert(JS_MESSAGE["policy.password.min.length"]);
				$("#password_min_length").focus();
				return;
			}
			if(!isNumber($("#password_min_length").val())) {
				$("#password_min_length").focus();
				return;
			}
			if($("#password_max_length").val() == "") {
				alert(JS_MESSAGE["policy.password.max.length"]);
				$("#password_max_length").focus();
				return;
			}
			if(!isNumber($("#password_max_length").val())) {
				$("#password_max_length").focus();
				return;
			}
			if($("#password_eng_upper_count").val() == "") {
				alert(JS_MESSAGE["policy.password.uppercase"]);
				$("#password_eng_upper_count").focus();
				return;
			}
			if(!isNumber($("#password_eng_upper_count").val())) {
				$("#password_eng_upper_count").focus();
				return;
			}
			if($("#password_eng_lower_count").val() == "") {
				alert(JS_MESSAGE["policy.password.lowercase"]);
				$("#password_eng_lower_count").focus();
				return;
			}
			if(!isNumber($("#password_eng_lower_count").val())) {
				$("#password_eng_lower_count").focus();
				return;
			}
			if($("#password_number_count").val() == "") {
				alert(JS_MESSAGE["policy.password.number"]);
				$("#password_number_count").focus();
				return;
			}
			if(!isNumber($("#password_number_count").val())) {
				$("#password_number_count").focus();
				return;
			}
			if($("#password_special_char_count").val() == "") {
				alert(JS_MESSAGE["policy.password.special.letters"]);
				$("#password_special_char_count").focus();
				return;
			}
			if(!isNumber($("#password_special_char_count").val())) {
				$("#password_special_char_count").focus();
				return;
			}
			if($("#password_continuous_char_count").val() == "") {
				alert(JS_MESSAGE["policy.password.serial.limit"]);
				$("#password_continuous_char_count").focus();
				return;
			}
			if(!isNumber($("#password_continuous_char_count").val())) {
				$("#password_continuous_char_count").focus();
				return;
			}
/* 			if($("#password_create_char").val() == "") {
				alert("초기 패스워드 생성 문자열을 입력하여 주십시오.");
				$("#password_create_char").focus();
				return;
			} */
			
			updatePasswordFlag = false;
			var info = $("#policyPassword").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-password.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.password.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updatePasswordFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePasswordFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	var updatePolicyGeoServerFlag = true;
	function updatePolicyGeoServer() {
		if(updatePolicyGeoServerFlag) {
			// validation 나중에
			updatePolicyGeoServerFlag = false;
			var info = $("#policyGeoserver").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-geoserver.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.geoserver.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updatePolicyGeoServerFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicyGeoServerFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	var updatePolicyRestApiFlag = true;
	function updatePolicyRestApi() {
		if(updatePolicyRestApiFlag) {
			// validation 나중에
			updatePolicyRestApiFlag = false;
			var info = $("#policyRestapi").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-rest-api.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.restapi.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updatePolicyRestApiFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicyRestApiFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	var updatePolicyProjectFlag = true;
	function updatePolicyProject() {
		if(updatePolicyRestApiFlag) {
			// validation 나중에
			updatePolicyProjectFlag = false;
			var info = $("#policyProject").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-project.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.project.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updatePolicyProjectFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicyProjectFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	var updatePolicySimulationFlag = true;
	function updatePolicySimulation() {
		if(updatePolicySimulationFlag) {
			// validation 나중에
			updatePolicySimulationFlag = false;
			var info = $("#policySimulation").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-simulation.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.simulation.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updatePolicySimulationFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicySimulationFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	var updatePolicyNoticeFlag = true;
	function updatePolicyNotice() {
		if(updatePolicyRestApiFlag) {
			// validation 나중에
			updatePolicyNoticeFlag = false;
			var info = $("#policyNotice").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-notice.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.notice.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updatePolicyNoticeFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicyNoticeFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 보안 정책 저장
	var updateSecurityFlag = true;
	function updatePolicySecurity() {
		if(updateSecurityFlag) {
			if(!isNumber($("#security_session_timeout").val())) {
				$("#security_session_timeout").focus();
				return;
			}
			var security_sso_token_verify_time = $("#security_sso_token_verify_time").val();
			if(security_sso_token_verify_time != null && security_sso_token_verify_time != "") {
				if(!isNumber(security_sso_token_verify_time)) {
					$("#security_sso_token_verify_time").focus();
					return;
				}
			}
			updateSecurityFlag = false;
			var info = $("#policySecurity").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-security.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.security.update"]);
					} else {
						alert(msg.result);
						alert(JS_MESSAGE[msg.result]);
					}
					updateSecurityFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateSecurityFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 사용자 파일 업로드 정책 저장
	var updateUploadFlag = true;
	function updatePolicyUpload() {
		if(updateUploadFlag) {
			if($("#user_upload_type").val() == "") {
				alert("업로딩 가능한 타입을 입력하여 주십시오.");
				$("#user_upload_type").focus();
				return;
			}
			if(!isNumber($("#user_upload_max_filesize").val())) {
				$("#user_upload_max_filesize").focus();
				return;
			}
			
			updateUserUploadFlag = false;
			var info = $("#policyUpload").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-upload.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert("사용자 업로딩 정책이 수정 되었습니다");
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateUploadFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 사이트 정보 저장
	var updateSiteFlag = true;
	function updatePolicySite() {
		if(updateSiteFlag) {
			if($("#site_name").val() == "") {
				alert(JS_MESSAGE["policy.site.service.name"]);
				$("#site_name").focus();
				return;
			}
			if($("#site_admin_mobile_phone").val() == "") {
				alert(JS_MESSAGE["policy.site.admin.mobile"]);
				$("#site_admin_mobile_phone").focus();
				return;
			}
			if($("#site_admin_email").val() == "") {
				alert(JS_MESSAGE["policy.site.admin.email"]);
				$("#site_admin_email").focus();
				return;
			}
			
			updateSiteFlag = false;
			var info = $("#policySite").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-site.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.site.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateSiteFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateSiteFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 제품 정보 저장
	var updateSolutionFlag = true;
	function updatePolicySolution() {
		if(updateSolutionFlag) {
			if($("#solution_name").val() == "") {
				alert(JS_MESSAGE["policy.product.name"]);
				$("#solution_name").focus();
				return;
			}
			if($("#solution_version").val() == "") {
				alert(JS_MESSAGE["policy.product.version"]);
				$("#solution_version").focus();
				return;
			}
			if($("#solution_manager").val() == "") {
				alert(JS_MESSAGE["policy.product.admin"]);
				$("#solution_manager").focus();
				return;
			}
			
			updateSolutionFlag = false;
			var info = $("#policySolution").serialize() + "&policy_id=" + $("#policy_id").val();
			$.ajax({
				url: "/config/ajax-update-policy-solution.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["policy.solution.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateSolutionFlag = true;
				},
				error:function(request,status,error){
			    	alert(JS_MESSAGE["ajax.error.message"]);
			    	updateSolutionFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="snb">
	<h2 class="log"><span><spring:message code='config'/></span></h2>
	<ul>
		<li id="policyMenu" class="on" title="<spring:message code='config.policy'/>" onclick="goPage('/config/modify-policy');">
		<span><spring:message code='config.policy'/></span></li>
	</ul>
</div>
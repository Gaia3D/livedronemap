<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="snb">
	<h2 class="log"><span><spring:message code='log'/></span></h2>
	<ul>
		<li id="aPILogMenu" title="<spring:message code='log.api'/>" onclick="goPage('/log/list-api-log');">
			<span><spring:message code='log.api'/></span>
		</li>
		<li id="tokenLogMenu" title="<spring:message code='log.token'/>" onclick="goPage('/log/list-token-log');">
			<span><spring:message code='log.token'/></span>
		</li>
	</ul>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="nav">
	<ul>
		<li class="menu" title="메뉴"><span>메뉴</span></li>
		<li id="projectMenu" class="project" title="프로젝트" onclick="goPage('/drone-project/list-drone-project');"><span>프로젝트</span></li>
		<li id="simulationMenu" class="monitoring" title="<spring:message code='simulation'/>" onclick="goPage('/simulation/list-simulation');"><spring:message code='simulation'/></li>
		<li class="log" title="로그"><span>로그</span></li>
		<li id="configMenu" class="setup" title="<spring:message code='config'/>" onclick="goPage('/config/modify-policy');"><span><spring:message code='config'/></span></li>
	</ul>
</div>
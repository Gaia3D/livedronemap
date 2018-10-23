<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="nav">
	<ul>
		<li class="menu" title="메뉴"><span>메뉴</span></li>
		<li id="projectMenu" class="project" title="프로젝트" onclick="goPage('/drone-project/list-drone-project');"><span>프로젝트</span></li>
		<li id="simulationMenu" class="monitoring" title="시뮬레이션" onclick="goPage('/simulation/list-simulation');">시뮬레이션</li>
		<li id="logMenu" class="log" title="로그" onclick="goPage('/log/list-api-log');"><span>로그</span></li>
		<li id="deviceMenu" class="setup" title="장비" onclick="goPage('/client/input-client');"><span>장비</span></li>
		<li id="configMenu" class="setup" title="환경설정" onclick="goPage('/config/modify-policy');"><span>환경설정</span></li>
	</ul>
</div>
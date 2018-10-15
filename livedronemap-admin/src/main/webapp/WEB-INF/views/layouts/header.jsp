<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="gaia3d.domain.CacheManager"%>
<%@ page import="gaia3d.domain.HealthCheck"%>
<%@page import="gaia3d.domain.UserSession"%>
<%
	Map<String, String> healthCheckMap = CacheManager.getHealthCheckMap();
	String lastCheckTime = healthCheckMap.get(HealthCheck.LAST_CHECK_TIME);
	String droneStatus = null;
	String aIStatus = null;
	String converterStatus = null;
	if(healthCheckMap != null && !healthCheckMap.isEmpty()) {
		droneStatus = healthCheckMap.get(HealthCheck.DRONE_STATUS);
		aIStatus = healthCheckMap.get(HealthCheck.AI_STATUS);
		converterStatus = healthCheckMap.get(HealthCheck.CONVERTER_STATUS);
	}
%>

<div id="header">
	<h1><span>Live Drone Map</span></h1>
	<ul class="condition">
		<li class="time">
			최종시간 : <span><%=lastCheckTime %></span>
		</li>
		<li>
			Drone
<% if(HealthCheck.ALIVE.equals(droneStatus)) { %>
			<span class="alive">정상</span>
<% } else if(HealthCheck.DOWN.equals(droneStatus)) { %>
			<span class="down">다운</span>
<% } else { %>
			<span class="unknown">알수없음</span>
<% } %>
	
		</li>
		<li>
			AI
<% if(HealthCheck.ALIVE.equals(aIStatus)) { %>
			<span class="alive">정상</span>
<% } else if(HealthCheck.DOWN.equals(aIStatus)) { %>
			<span class="down">다운</span>
<% } else { %>
			<span class="unknown">알수없음</span>
<% } %>
		</li>
		<li>
			Converter
<% if(HealthCheck.ALIVE.equals(converterStatus)) {%>
			<span class="alive">정상</span>
<% } else if(HealthCheck.DOWN.equals(converterStatus)) {%>
			<span class="down">다운</span>
<% } else { %>
			<span class="unknown">알수없음</span>
<% } %>
		</li>
	</ul>
	<ul class="gnb">
		<li>
			도움말
		</li>
		<li>
<%
	UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
	if(userSession != null && userSession.getUser_id() != null && !"".equals(userSession.getUser_id())) {
%>		
			<a href="/login/logout" style="color: #fff;">로그 아웃</a>
<% } else { %>
			<a href="/login/login" style="color: #fff;">로그인</a>
<% } %>
		</li>
	</ul>
</div>

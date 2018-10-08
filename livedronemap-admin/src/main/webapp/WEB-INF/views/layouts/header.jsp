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

<div id="header" style="">
	<ul class="processing" style="width: 100%;">
		<li style="float: left; padding-left: 10px;">
			<img src="../../../images/drone.png" width="50" height="" />
		</li>
		<li style="float:left; padding-left:20px; padding-top: 15px;">
			<span class="title">Live Drone Map</span>
		</li>
		<li style="padding-left:420px; padding-top: 15px; padding-right: 10px;">
			<span class="title">최종 시간 : <%=lastCheckTime %></span>
		</li>
		<li style="padding-left:20px; padding-top: 15px; padding-right: 10px;">
			<span class="title">Drone</span>
		</li>
		<li style="padding-top: 15px;">
<% if(HealthCheck.ALIVE.equals(droneStatus)) {%>
			<img src="../../../images/ko/icon/health_alive.png"/>
<% } else if(HealthCheck.DOWN.equals(droneStatus)) {%>
			<img src="../../../images/ko/icon/health_down.png"/>
<% } else { %>
			<img src="../../../images/ko/icon/health_unknown.png"/>
<% } %>
		</li>
		<li style="padding-left:20px; padding-top: 15px; padding-right: 10px;">
			<span class="title">AI</span>
		</li>
		<li style="padding-top: 15px;">
<% if(HealthCheck.ALIVE.equals(aIStatus)) {%>
			<img src="../../../images/ko/icon/health_alive.png"/>
<% } else if(HealthCheck.DOWN.equals(aIStatus)) {%>
			<img src="../../../images/ko/icon/health_down.png"/>
<% } else { %>
			<img src="../../../images/ko/icon/health_unknown.png"/>
<% } %>
		</li>
		<li style="padding-left:20px; padding-top: 15px; padding-right: 10px;">
			<span class="title">Converter</span>
		</li>
		<li style="padding-top: 15px;">
<% if(HealthCheck.ALIVE.equals(converterStatus)) {%>
			<img src="../../../images/ko/icon/health_alive.png"/>
<% } else if(HealthCheck.DOWN.equals(converterStatus)) {%>
			<img src="../../../images/ko/icon/health_down.png"/>
<% } else { %>
			<img src="../../../images/ko/icon/health_unknown.png"/>
<% } %>
		</li>
		
		<li style="padding-left:200px; padding-top: 15px;">
			<span class="title">도움말&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
		</li>
		<li style="padding-top: 15px;">
<%
	UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
	if(userSession != null && userSession.getUser_id() != null && !"".equals(userSession.getUser_id())) {
%>		
			<a href="/login/logout.do"><span class="title">로그 아웃</span></a>
<% } else { %>
			<a href="/login/login.do"><span class="title">로그인</span></a>
<% } %>
		</li>
	</ul>
</div>

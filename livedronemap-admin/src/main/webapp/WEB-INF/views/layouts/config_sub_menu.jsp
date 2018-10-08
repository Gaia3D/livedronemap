<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>

<div class="subWrap" style="height: 100%;">
	<div class="subHeader">
		<h2 class="nav-title">
			<span>환경 설정</span>
			<%-- <span class="ko">${parentMenu.name }</span>
			<span class="en">${parentMenu.name_en }</span> --%>
		</h2>
	</div>
	
	<div class='subContents'>
		<ul>
			<li><a href="modify-policy"><spring:message code='config.policy'/></a></li>
		</ul>
	</div>
	
</div>
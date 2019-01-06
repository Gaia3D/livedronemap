<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="snb">
	<h2 class="log"><span>로그</span></h2>
	<ul>
		<li id="aPILogMenu" title="API 로그" onclick="goPage('/log/list-api-log');">
			<span>API 로그</span>
		</li>
		<li id="tokenLogMenu" title="토큰 로그" onclick="goPage('/log/list-token-log');">
			<span>토큰 로그</span>
		</li>
	</ul>
</div>
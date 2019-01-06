<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>토큰 로그 | LiveDroneMap</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" /> 
	<link rel="stylesheet" href="/css/${lang}/style.css">
    <link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/live-drone-map.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="contentsWrap">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<%@ include file="/WEB-INF/views/log/log-menu.jsp" %>
	
	<div class="contents limited"><!-- 컨텐츠영역을 100%로 사용하려면 limited를 삭제하세요 -->
		<h3>토큰 로그</h3>
		
		<form:form id="searchForm" modelAttribute="tokenLog" method="post" action="/log/list-token-log" onsubmit="return searchCheck();">
			<ul class="searchForm">
<%-- 				<li>
					<form:label path="search_word"><spring:message code='search.word'/></form:label>
					<form:select path="search_word" name="search_word" class="select">
						<form:option value=""><spring:message code='search.basic'/></form:option>
	                	<form:option value="client_name"><spring:message code='client.name'/></form:option>
	                	<form:option value="user_id"><spring:message code='user.id'/></form:option>
					</form:select>
					<form:select path="search_option" name="search_option" class="select">
						<form:option value="0"><spring:message code='search.same'/></form:option>
						<form:option value="1"><spring:message code='search.include'/></form:option>
					</form:select>
					<form:input type="text" class="s date" path="search_value" name="search_value"/>
				</li> --%>
				<li>
					<form:label path="token_status"><spring:message code='token.status'/></form:label>
					<form:select path="token_status" class="select">
						<form:option value=""><spring:message code='search.basic'/></form:option>
	                	<form:option value="0"><spring:message code='token.status.using'/></form:option>
	                	<form:option value="1"><spring:message code='token.status.expired'/></form:option>
					</form:select>
				</li>
				<li>
					<label for="start_date"><spring:message code='search.date'/></label>
					<input type="text" class="s date" id="start_date" name="start_date" size="10" />
					<span class="delimeter tilde">~</span>
					<input type="text" class="s date" id="end_date" name="end_date" size="10" />
				</li>
				<li>
					<form:label path="order_word"><spring:message code='search.order'/></form:label>
					<form:select path="order_word" name="order_word" class="select">
						<form:option value=""><spring:message code='search.basic'/></form:option>
	                	<form:option value="user_id"><spring:message code='user.id'/></form:option>
	                	<form:option value="insert_date"><spring:message code='search.insert.date'/></form:option>
					</form:select>
					<form:select path="order_value" name="order_value" class="select">
	                	<form:option value="ASC"> <spring:message code='search.ascending'/> </form:option>
						<form:option value="DESC"> <spring:message code='search.descending.order'/> </form:option>
					</form:select>
					<form:select path="list_counter" name="list_counter" class="select">
	               		<form:option value="10"> <spring:message code='search.ten.count'/> </form:option>
	                	<form:option value="50"> <spring:message code='search.fifty.count'/> </form:option>
						<form:option value="100"> <spring:message code='search.hundred.count'/> </form:option>
					</form:select> 
				</li>
			</ul>
			<div class="alignRight">
				<button type="submit" value="<spring:message code='search'/>" class="point"><spring:message code='search'/></button>
			</div>
		</form:form>
		
		<form:form id="listForm" modelAttribute="tokenLog" method="post">
		<div class="boardHeader">
			<p>
				<spring:message code='all.d'/> <strong><fmt:formatNumber value="${pagination.totalCount}" type="number"/></strong> <spring:message code='search.what.count'/>
				<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
			</p>
		</div>
		<div class="boardList">
			<table>
				<thead>
					<tr>
						<th style="width:5%; font-weight: bold"><spring:message code='number'/></th>
						<th style="width:15%; font-weight: bold"><spring:message code='client.name'/></th>
						<th style="width:15%; font-weight: bold"><spring:message code='user.id'/></th>
						<th style="width:10%; font-weight: bold"><spring:message code='token.status'/></th>
						<th style="width:15%; font-weight: bold"><spring:message code='token.expires'/></th>
						<th style="width:15%; font-weight: bold"><spring:message code='search.update.date'/></th>
						<th style="width:15%; font-weight: bold"><spring:message code='search.insert.date'/></th>
					</tr>
				</thead>
				<tbody>
<c:if test="${empty tokenLogList }">
						<tr>
							<td colspan="7" class="col-none" style="text-align: center; font-size: 14px;">토큰 로그가 존재하지 않습니다.</td>
						</tr>
</c:if>
<c:if test="${!empty tokenLogList }">
	<c:forEach var="tokenLog" items="${tokenLogList}" varStatus="status">
						<tr>
							<td class="alignCenter">${pagination.rowNumber - status.index}</td>
							<td class="alignLeft">${tokenLog.client_name}</td>
							<td class="alignLeft">${tokenLog.user_id}</td>
							<td class="alignCenter">${tokenLog.token_status}</td>
							<td class="alignCenter">${tokenLog.viewExpires}</td>
							<td class="alignCenter">${tokenLog.viewUpdate_date}</td>
							<td class="alignCenter">${tokenLog.viewInsert_date}</td>
						</tr>
	</c:forEach>
</c:if>
				</tbody>
			</table>
			
			<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
		</div>
		</form:form>
	</div>
	
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#logMenu").addClass("on");
		$("#tokenLogMenu").addClass("on");
		
		initJqueryCalendar();
		initCalendar(new Array("start_date", "end_date"), new Array("${tokenLog.start_date}", "${tokenLog.end_date}"));
	});
	
	function searchCheck() {
		if($("#search_option").val() == "1") {
			if(confirm(JS_MESSAGE["search.option.warning"])) {
				// go
			} else {
				return false;
			}
		} 
		
		var start_date = $("#start_date").val();
		var end_date = $("#end_date").val();
		if(start_date != null && start_date != "" && end_date != null && end_date != "") {
			if(parseInt(start_date) > parseInt(end_date)) {
				alert(JS_MESSAGE["search.date.warning"]);
				$("#start_date").focus();
				return false;
			}
		}
		return true;
	}
</script>

</body>
</html>
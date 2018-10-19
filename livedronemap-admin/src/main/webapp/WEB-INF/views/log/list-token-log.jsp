<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title><spring:message code='log.token'/> | LiveDroneMap</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" /> 
	<link rel="stylesheet" href="/css/${lang}/style.css">
    <link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cache_version=${cache_version}" /> 
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/mago3d.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/live-drone-map.js"></script>
    <script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="contentsWrap">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<%@ include file="/WEB-INF/views/log/log-menu.jsp" %>
	
	<div class="contents limited"><!-- 컨텐츠영역을 100%로 사용하려면 limited를 삭제하세요 -->
		<h3><spring:message code='log.token'/></h3>
		
		<form:form id="tokenLogSearchForm" modelAttribute="tokenLog" method="post" action="/log/list-token-log" onsubmit="return searchCheck();">
			<ul class="searchForm">
				<li>
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
				</li>
				<li>
					<form:label path="search_status"><spring:message code='token.status'/></form:label>
					<form:select path="search_status" name="search_status" class="select">
						<form:option value=""><spring:message code='search.basic'/></form:option>
	                	<form:option value="0"><spring:message code='token.status.using'/></form:option>
	                	<form:option value="1"><spring:message code='token.status.expired'/></form:option>
					</form:select>
				</li>
				<li>
					<form:label path="search_date"><spring:message code='search.date'/></form:label>
					<form:select path="search_date" name="search_date" class="select">
						<form:option value="expires"><spring:message code='token.expires'/></form:option>
		  				<form:option value="update_date"><spring:message code='search.update.date'/></form:option>
		  				<form:option value="insert_date"><spring:message code='search.insert.date'/></form:option>
					</form:select>
					<input type="text" class="s date" id="search_start_date" name="search_start_date" readonly="readonly" />
					<span class="delimeter tilde">~</span>
					<input type="text" class="s date" id="search_end_date" name="search_end_date" readonly="readonly" />
				</li>
				<li>
					<form:label path="order_word"><spring:message code='search.order'/></form:label>
					<form:select path="order_word" name="order_word" class="select">
						<form:option value=""><spring:message code='search.basic'/></form:option>
	                	<form:option value="client_name"><spring:message code='client.name'/></form:option>
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
				<button type="submit" form="tokenLogSearchForm" value="<spring:message code='search'/>" class="point"><spring:message code='search'/></button>
			</div>
		</form:form>
		<div class="boardList">
			<table>
				<thead>
					<tr>
						<th><spring:message code='number'/></th>
						<th><spring:message code='client.name'/></th>
						<th><spring:message code='user.id'/></th>
						<th><spring:message code='token.status'/></th>
						<th><spring:message code='token.expires'/></th>
						<th><spring:message code='search.update.date'/></th>
						<th><spring:message code='search.insert.date'/></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="tokenLog" items="${tokenLogList}" varStatus="status">
						<tr>
							<td class="alignCenter">${status.index }</td>
							<td class="alignCenter">${tokenLog.client_name}</td>
							<td class="alignCenter">${tokenLog.user_id}</td>
							<td class="alignCenter">${tokenLog.token_status}</td>
							<td class="alignCenter">${tokenLog.viewExpires}</td>
							<td class="alignCenter">${tokenLog.viewUpdate_date}</td>
							<td class="alignCenter">${tokenLog.viewInsert_date}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#logMenu").addClass("on");
		$("#tokenLogMenu").addClass("on");
	});
</script>

</body>
</html>
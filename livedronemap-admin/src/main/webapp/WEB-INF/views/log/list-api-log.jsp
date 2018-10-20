<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>API 로그 | LiveDroneMap</title>
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
		<h3>API 로그</h3>
		<!-- 검색폼 -->
		<form:form id="aPILogSearchForm" modelAttribute="aPILog" method="post" action="/log/list-api-log" onsubmit="return searchCheck();">
			<ul class="searchForm">
				<li>
					<form:label path="search_word"><spring:message code='search.word'/></form:label>
					<form:select path="search_word" name="search_word" class="select">
						<form:option value=""><spring:message code='search.basic'/></form:option>
	                	<form:option value="client_name"><spring:message code='client.name'/></form:option>
	                	<form:option value="user_id"><spring:message code='user.id'/></form:option>
	                	<form:option value="request_ip"><spring:message code='request.ip'/></form:option>
	                	<form:option value="url"><spring:message code='request.url'/></form:option>
					</form:select>
					<form:select path="search_option" name="search_option" class="select">
						<form:option value="0"><spring:message code='search.same'/></form:option>
						<form:option value="1"><spring:message code='search.include'/></form:option>
					</form:select>
					<form:input type="text" class="s date" path="search_value" name="search_value"/>
				</li>
				<li>
					<form:label path="search_status">응답 코드</form:label>
					<form:select path="search_status" name="search_status" class="select">
						<form:option value=""><spring:message code='search.basic'/></form:option>
	                	<form:option value="200">2xx</form:option>
	                	<form:option value="300">3xx</form:option>
	                	<form:option value="400">4xx</form:option>
	                	<form:option value="500">5xx</form:option>
					</form:select>
				</li>
				<li>
					<form:label path="search_start_date"><spring:message code='search.date'/></form:label>
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
				<button type="submit" form="aPILogSearchForm" value="<spring:message code='search'/>" class="point"><spring:message code='search'/></button>
			</div>
		</form:form>
		<!-- 목록정렬 -->
		<div class="boardHeader">
			<p>
				<spring:message code='all.d'/> <fmt:formatNumber value="${pagination.totalCount}" type="number"/> <spring:message code='search.what.count'/>
				<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
			</p>
		</div>
		<div class="boardList">
			<table>
				<thead>
					<tr>
						<th><spring:message code='number'/></th>
						<th><spring:message code='client.name'/></th>
						<th><spring:message code='user.id'/></th>
						<th><spring:message code='request.ip'/></th>
						<th><spring:message code='request.url'/></th>
						<th>응답 코드</th>
						<th>메세지</th>
						<th><spring:message code='search.insert.date'/></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="aPILog" items="${aPILogList}" varStatus="status">
						<tr>
							<td class="alignCenter">${pagination.rowNumber - status.index }</td>
							<td class="alignCenter">${aPILog.client_name}</td>
							<td class="alignCenter">${aPILog.user_id}</td>
							<td class="alignCenter">${aPILog.request_ip}</td>
							<td class="alignCenter">${aPILog.url}</td>
							<td class="alignCenter">${aPILog.status_code}</td>
							<td class="alignCenter">
								<c:if test="${aPILog.message ne '' and aPILog.message ne null}">
									<button type="button" title="보기" class="intd">보기</button>
								</c:if>
							</td>
							<td class="alignCenter">${aPILog.viewInsert_date}</td>
						</tr>
					</c:forEach>
					
				</tbody>
			</table>
			
			<ul class="pagination">
				<c:if test="${pagination.existPrePage == 'true'}">
					<li><a href="${pagination.uri }?pageNo=${pagination.firstPage}${pagination.searchParameters}" class="first"><span class="ico first"></span></a></li>
					<li><a href="${pagination.uri }?pageNo=${pagination.prePageNo }${pagination.searchParameters}" class="prev"><span class="ico forward"></span></a></li>
				</c:if>
				
				<c:forEach var="pageIndex" begin="${pagination.startPage }" end="${pagination.endPage }" step="1">
					<c:if test="${pageIndex == pagination.pageNo }">
						<li class="on"><a href="#">${pageIndex}</a></li>
					</c:if>
					<c:if test="${pageIndex != pagination.pageNo }">
						<li><a href="${pagination.uri }?pageNo=${pageIndex }${pagination.searchParameters}">${pageIndex }</a></li>
					</c:if>
				</c:forEach>
				
				<c:if test="${pagination.existNextPage == 'true' }">
					<a href="${pagination.uri }?pageNo=${pagination.nextPageNo }${pagination.searchParameters}" class="next"><span class="ico back"></span></a>
					<a href="${pagination.uri }?pageNo=${pagination.lastPage }${pagination.searchParameters}" class="last"><span class="ico end"></span></a>
				</c:if>	
			</ul>
		</div>
		<!-- END BOARDLIST -->
	</div>
	<!-- E: CONTENTS -->
	
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#logMenu").addClass("on");
		$("#aPILogMenu").addClass("on");
		
		initJqueryCalendar();
		initCalendar(new Array("search_start_date", "search_end_date"), new Array("${simulationLog.search_start_date}", "${simulationLog.search_end_date}"));
		
	});
</script>

</body>
</html>
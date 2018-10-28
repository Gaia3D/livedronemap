<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>상태 점검 | LiveDroneMap</title>
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
	
	<%@ include file="/WEB-INF/views/scheduler/scheduler-menu.jsp" %>
	
	<div class="contents limited">
		<h3>상태 점검</h3>
		<form:form id="searchForm" modelAttribute="healthCheckLog" method="post" action="/scheduler/list-health-check" onsubmit="return searchCheck();">
			<ul class="searchForm">
				<li>
					<form:label path="status"><spring:message code='simulation.status'/></form:label>
					<form:select path="status" name="status" class="select">
						<form:option value=""> <spring:message code='search.basic'/> </form:option>
		  				<form:option value="ALIVE">정상</form:option>
		  				<form:option value="DOWN">다운</form:option>
		  				<form:option value="UNKNOWN">알수없음</form:option>
					</form:select>
				</li>
				<li>
					<form:label path="search_value"><spring:message code='client.name'/></form:label>
					<form:select path="search_option" name="search_option" class="select">
						<form:option value="0"><spring:message code='search.same'/></form:option>
						<form:option value="1"><spring:message code='search.include'/></form:option>
					</form:select>
					<form:input path="search_value" maxlength="20" cssClass="s" />
					<form:errors path="search_value" cssClass="error" />
				</li>
				<li>
					<label for="start_date"><spring:message code='search.date'/></label>
					<input type="text" class="s date" id="start_date" name="start_date" />
					<span class="delimeter tilde">~</span>
					<input type="text" class="s date" id="end_date" name="end_date" />
				</li>
				<li>
					<form:label path="order_word"><spring:message code='search.order'/></form:label>
					<form:select path="order_word" name="order_word" class="select">
						<form:option value=""> <spring:message code='search.basic'/> </form:option>
						<form:option value="status"><spring:message code='simulation.status'/></form:option>
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
		
		<!-- 목록정렬 -->
		<form:form id="listForm" modelAttribute="healthCheckLog" method="post">
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
						<th><spring:message code='search.status'/></th>
						<th><spring:message code='http.code'/></th>
						<th><spring:message code='message'/></th>
						<th><spring:message code='search.insert.date'/></th>
					</tr>
				</thead>
				<tbody>
<c:if test="${empty healthCheckLogList }">
										<tr>
											<td colspan="6" class="col-none" style="text-align: center; font-size: 14px;">스케줄 이력이 존재하지 않습니다.</td>
										</tr>
</c:if>
<c:if test="${!empty healthCheckLogList }">
	<c:forEach var="healthCheckLog" items="${healthCheckLogList}" varStatus="status">
						<tr>
							<td class="alignCenter">${pagination.rowNumber - status.index}</td>
							<td class="alignCenter">${healthCheckLog.client_name}</td>
							<td class="alignCenter">
		<c:if test="${healthCheckLog.status == 'ALIVE'}">
									<span class="alive">정상</span>
		</c:if>
		<c:if test="${healthCheckLog.status == 'DOWN'}">
									<span class="down">다운</span>
		</c:if>
		<c:if test="${healthCheckLog.status == 'UNKNOWN'}">
									<span class="unknown">알수없음</span>
		</c:if>
							</td>
							<td class="alignCenter">${healthCheckLog.status_code}</td>
							<td class="alignCenter">
		<c:if test="${healthCheckLog.message ne '' and healthCheckLog.message ne null}">
									<button type="button" title="<spring:message code='open.message'/>" class="intd"><spring:message code='open.message'/></button>
		</c:if>
							</td>
							<td class="alignCenter">${healthCheckLog.viewInsertDate}</td>
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
		$("#schedulerMenu").addClass("on");
		$("#healthCheckMenu").addClass("on");
		
		initJqueryCalendar();
		initCalendar(new Array("start_date", "end_date"), new Array("${healthCheckLog.start_date}", "${healthCheckLog.end_date}"));
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
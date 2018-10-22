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
</head>

<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="contentsWrap">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<%@ include file="/WEB-INF/views/scheduler/scheduler-menu.jsp" %>
	
	<div class="contents limited">
		<h3>상태 점검</h3>
		<form:form id="HealthCheckLogSearchForm" modelAttribute="healthCheckLog" method="post" action="/scheduler/list-health-check" onsubmit="return searchCheck();">
			<ul class="searchForm">
				<li>
					<form:label path="search_status"><spring:message code='simulation.status'/></form:label>
					<form:select path="search_status" name="search_status" class="select">
						<form:option value=""> <spring:message code='search.basic'/> </form:option>
		  				<form:option value="ALIVE">ALIVE</form:option>
		  				<form:option value="DOWN">DOWN</form:option>
		  				<form:option value="UNKNOWN">UNKNOWN</form:option>
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
					<form:label path="search_start_date"><spring:message code='search.date'/></form:label>
					<input type="text" class="s date" id="search_start_date" name="search_start_date" readonly="readonly" />
					<span class="delimeter tilde">~</span>
					<input type="text" class="s date" id="search_end_date" name="search_end_date" readonly="readonly" />
				</li>
				<li>
					<form:label path="order_word"><spring:message code='search.order'/></form:label>
					<form:select path="order_word" name="order_word" class="select">
						<form:option value=""> <spring:message code='search.basic'/> </form:option>
						<form:option value="client_id"><spring:message code='client.name'/></form:option>
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
				<button type="submit" form="HealthCheckLogSearchForm" value="<spring:message code='search'/>" class="point"><spring:message code='search'/></button>
			</div>
		</form:form>
		<!-- 목록정렬 -->
		<div class="boardHeader">
			<p>
				<span>10</span>건 / 총200건
			</p>
		</div>
		<div class="boardList">
			<table>
				<thead>
					<tr>
						<th><spring:message code='number'/></th>
						<th><spring:message code='client.name'/></th>
						<th>상태</th>
						<th>응답 코드</th>
						<th>메세지</th>
						<th><spring:message code='search.insert.date'/></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="healthCheckLog" items="${healthCheckLogList}" varStatus="status">
						<tr>
							<td class="alignCenter">${pagination.rowNumber - status.index}</td>
							<td class="alignCenter">${healthCheckLog.client_name}</td>
							<td class="alignCenter">${healthCheckLog.status}</td>
							<td class="alignCenter">${healthCheckLog.status_code}</td>
							<td class="alignCenter">
								<c:if test="${healthCheckLog.message ne '' and healthCheckLog.message ne null}">
									<button type="button" title="보기" class="intd">보기</button>
								</c:if>
							</td>
							<td class="alignCenter">${healthCheckLog.viewInsertDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#schedulerMenu").addClass("on");
		$("#healthCheckMenu").addClass("on");
	});
</script>

</body>
</html>
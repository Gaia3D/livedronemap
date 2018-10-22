<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>시뮬레이션 | LiveDroneMap</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" /> 
	<link rel="stylesheet" href="/css/${lang}/style.css">
    <link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/live-drone-map.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="contentsWrap">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<%@ include file="/WEB-INF/views/simulation/simulation-menu.jsp" %>
	
	<div class="contents limited">
		<h3>시뮬레이션</h3>
		<form:form id="simulationSearchForm" modelAttribute="simulationLog" method="post" action="/simulation/list-simulation" onsubmit="return searchCheck();">
			<ul class="searchForm">
				<li>
					<form:label path="search_type"><spring:message code='simulation.type'/></form:label>
					<form:select path="search_type" class="select">
						<form:option value=""> <spring:message code='search.basic'/> </form:option>
		  				<form:option value="0"><spring:message code='simulation.type.all'/></form:option>
		  				<form:option value="1"><spring:message code='simulation.type.client'/></form:option>
		  				<form:option value="2"><spring:message code='simulation.type.inner'/></form:option>
					</form:select>
				</li>
				<li>
					<form:label path="search_status"><spring:message code='simulation.status'/></form:label>
					<form:select path="search_status" name="search_status" class="select">
						<form:option value=""> <spring:message code='search.basic'/> </form:option>
		  				<form:option value="0"><spring:message code='status.success'/></form:option>
		  				<form:option value="1"><spring:message code='status.fail'/></form:option>
		  				<form:option value="2"><spring:message code='status.progressing'/></form:option>
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
					<form:label path="search_date"><spring:message code='search.date'/></form:label>
					<form:select path="search_date" name="search_date" class="select">
		  				<form:option value="start_date"><spring:message code='search.start.date'/></form:option>
		  				<form:option value="complete_date"><spring:message code='search.complete.date'/></form:option>
					</form:select>
					<input type="text" class="s date" id="search_start_date" name="search_start_date" readonly="readonly" />
					<span class="delimeter tilde">~</span>
					<input type="text" class="s date" id="search_end_date" name="search_end_date" readonly="readonly" />
				</li>
				<li>
					<form:label path="order_word"><spring:message code='search.order'/></form:label>
					<form:select path="order_word" name="order_word" class="select">
						<form:option value=""> <spring:message code='search.basic'/> </form:option>
						<form:option value="client_id"><spring:message code='client.name'/></form:option>
	                	<form:option value="simulation_type"><spring:message code='simulation.type'/></form:option>
	                	<form:option value="status"><spring:message code='simulation.status'/></form:option>
	                	<form:option value="start_date"><spring:message code='search.start.date'/></form:option>
	                	<form:option value="complete_date"><spring:message code='search.complete.date'/></form:option>
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
				<button type="submit" form="simulationSearchForm" value="<spring:message code='search'/>" class="point"><spring:message code='search'/></button>
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
						<th><spring:message code='simulation.type'/></th>
						<th><spring:message code='client.name'/></th>
						<th><spring:message code='simulation.status'/></th>
						<th><spring:message code='search.start.date'/></th>
						<th><spring:message code='search.complete.date'/></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="simulationLog" items="${simulationLogList}" varStatus="status">
						<tr>
							<td class="alignCenter">${pagination.rowNumber - status.index }</td>
							<c:if test="${simulationLog.simulation_type eq '0'}">
								<td class="alignCenter"><spring:message code='simulation.type.all'/></td>
							</c:if>
							<c:if test="${simulationLog.simulation_type eq '1'}">
								<td class="alignCenter"><spring:message code='simulation.type.client'/></td>
							</c:if>
							<c:if test="${simulationLog.simulation_type eq '2'}">
								<td class="alignCenter"><spring:message code='simulation.type.inner'/></td>
							</c:if>
							<td class="alignCenter">${simulationLog.client_name}</td>
							<c:if test="${simulationLog.status eq '0'}">
								<td class="alignCenter"><span class="state good"></span><spring:message code='status.success'/></td>
							</c:if>
							<c:if test="${simulationLog.status eq '1'}">
								<td class="alignCenter"><span class="state error"></span><spring:message code='status.fail'/></td>
							</c:if>
							<c:if test="${simulationLog.status eq '2'}">
								<td class="alignCenter"><spring:message code='status.progressing'/></td>
							</c:if>
							<td class="alignCenter">${simulationLog.viewStart_date}</td>
							<td class="alignCenter">${simulationLog.viewComplete_date}</td>
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
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#simulationMenu").addClass("on");
		$("#simulationLogMenu").addClass("on");
		
		initJqueryCalendar();
		initCalendar(new Array("search_start_date", "search_end_date"), new Array("${simulationLog.search_start_date}", "${simulationLog.search_end_date}"));
		
	});
	
	function simulateProcess(clientId, step) {
		$.ajax({
			url: "/simulations/" + clientId + "/" + step,
			type: "POST",
			cache: false,
			success: function(msg){
				console.log(msg)
				if(msg.result == "success") {
					alert(JS_MESSAGE["success"]);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request,status,error){
		        //alert(JS_MESSAGE["ajax.error.message"]);
		        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
</script>

</body>
</html>
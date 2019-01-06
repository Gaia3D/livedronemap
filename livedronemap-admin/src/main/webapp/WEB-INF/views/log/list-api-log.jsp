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
    <link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/live-drone-map.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/views/common/detail-message.jsp" %>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="contentsWrap">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<%@ include file="/WEB-INF/views/log/log-menu.jsp" %>
	
	<div class="contents limited"><!-- 컨텐츠영역을 100%로 사용하려면 limited를 삭제하세요 -->
		<h3>API 로그</h3>
		<!-- 검색폼 -->
		<form:form id="searchForm" modelAttribute="aPILog" method="post" action="/log/list-api-log" onsubmit="return searchCheck();">
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
					<form:input type="text" path="search_value" name="search_value"/>
				</li> --%>
				<li>
					<form:label path="status_code"><spring:message code='http.code'/></form:label>
					<form:select path="status_code" name="status_code" class="select">
						<form:option value=""><spring:message code='search.basic'/></form:option>
	                	<form:option value="200">2xx</form:option>
	                	<form:option value="300">3xx</form:option>
	                	<form:option value="400">4xx</form:option>
	                	<form:option value="500">5xx</form:option>
					</form:select>
				</li>
				<li>
					<label for="start_date"><spring:message code='search.date'/></label>
					<input type="text" class="s date" id="start_date" name="start_date" size="10"/>
					<span class="delimeter tilde">~</span>
					<input type="text" class="s date" id="end_date" name="end_date" size="10"/>
				</li>
				<li>
					<form:label path="order_word"><spring:message code='search.order'/></form:label>
					<form:select path="order_word" name="order_word" class="select">
						<form:option value=""><spring:message code='search.basic'/></form:option>
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
		<form:form id="listForm" modelAttribute="aPILog" method="post">
		<div class="boardHeader">
			<p>
				<spring:message code='all.d'/> <strong></strong><fmt:formatNumber value="${pagination.totalCount}" type="number"/></strong> <spring:message code='search.what.count'/>
				<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
			</p>
		</div>
		<div class="boardList">
			<table>
				<thead>
					<tr>
						<th style="font-weight: bold"><spring:message code='number'/></th>
						<th style="font-weight: bold"><spring:message code='client.name'/></th>
						<th style="font-weight: bold"><spring:message code='user.id'/></th>
						<th style="font-weight: bold"><spring:message code='request.ip'/></th>
						<th style="font-weight: bold"><spring:message code='request.url'/></th>
						<th style="font-weight: bold"><spring:message code='http.code'/></th>
						<th style="font-weight: bold"><spring:message code='message'/></th>
						<th style="font-weight: bold"><spring:message code='search.insert.date'/></th>
					</tr>
				</thead>
				<tbody>
<c:if test="${empty aPILogList }">
						<tr>
							<td colspan="8" class="col-none" style="text-align: center; font-size: 14px;">API 로그가 존재하지 않습니다.</td>
						</tr>
</c:if>
<c:if test="${!empty aPILogList }">
	<c:forEach var="aPILog" items="${aPILogList}" varStatus="status">
						<tr>
							<td class="alignCenter">${pagination.rowNumber - status.index }</td>
							<td class="alignCenter">${aPILog.client_name}</td>
							<td class="alignCenter">${aPILog.user_id}</td>
							<td class="alignRight">${aPILog.request_ip}</td>
							<td class="alignLeft">${aPILog.url}</td>
							<td class="alignCenter">${aPILog.status_code}</td>
							<td class="alignCenter">
								<c:if test="${aPILog.message ne '' and aPILog.message ne null}">
									<button type="button" title="<spring:message code='open.message'/>" class="intd" onclick="showDetailMessage(${aPILog.api_log_id})"><spring:message code='open.message'/></button>
								</c:if>
							</td>
							<td class="alignCenter">${aPILog.viewInsert_date}</td>
						</tr>
	</c:forEach>
</c:if>
					
				</tbody>
			</table>
			
			<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
		</div>
		</form:form>
		<!-- END BOARDLIST -->
	</div>
	<!-- E: CONTENTS -->
	
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#logMenu").addClass("on");
		$("#aPILogMenu").addClass("on");
		
		initJqueryCalendar();
		initCalendar(new Array("start_date", "end_date"), new Array("${aPILog.start_date}", "${aPILog.end_date}"));
		
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
	
	function showDetailMessage(apiLogId) {
		$.ajax({
			url: "/log/" + apiLogId + "/messages",
			type: "GET",
			cache: false,
			success: function(msg){
				console.log(msg)
				if(msg.result == "success") {
					$("#detailMessageContents").html(msg.message);
					$("#detailMessage").show();
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request,status,error){
		        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
</script>

</body>
</html>
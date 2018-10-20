<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Health Check | LiveDroneMap</title>
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
	
	<%@ include file="/WEB-INF/views/simulation/simulation-menu.jsp" %>
	
	<div class="contents limited">
		<h3><spring:message code='simulation'/></h3>
		
		<ul class="searchForm">
			<li>
				<label for="">프로젝트명</label>
				<select name="" id="">
					<option value="">전체</option>
				</select>
			</li>
			<li>
				<label for="">검색어</label>
				<select name="" id="">
					<option value="">전체</option>
				</select>
				<select name="" id="">
					<option value="">전체</option>
				</select>
				<select name="" id="">
					<option value="">전체</option>
				</select>
			</li>
			<li>
				<label for="">검색</label>
				<input type="text">
			</li>
		</ul>
		<div class="alignRight">
			<button type="button" class="point">검색</button>
		</div>
		
		<!-- 목록정렬 -->
		<div class="boardHeader">
			<p>
				<span>10</span>건 / 총200건
			</p>
			<div class="tableBtn">
				<button type="button" title="일괄삭제">일괄삭제</button>
				<button type="button" title="등록">등록</button>
				<button type="button" title="엑셀로 자료받기">엑셀로 자료받기</button>
			</div>
		</div>
		<div class="boardList">
			<table>
				<thead>
					<th><input type="checkbox"></th>
					<th>번호</th>
					<th>프로젝트명</th>
					<th>데이터명</th>
					<th>제어속성</th>
					<th>등록일</th>
					<th>수정/삭제</th>
				</thead>
				<tbody>
					<tr>
						<td class="alignCenter"><input type="checkbox"></td>
						<td>123</td>
						<td>3DS</td>
						<td>imun_del</td>
						<td>definite ptkurpose circuit breaker</td>
						<td class="alignCenter">2018-10-10  17:11:59</td>
						<td class="alignCenter">
							<button type="button" title="수정" class="intd">수정</button>
							<button type="button" title="삭제" class="intd">삭제</button>
						</td>
					</tr>
					<tr>
						<td class="alignCenter"><input type="checkbox"></td>
						<td>123</td>
						<td>3DS</td>
						<td>imun_del</td>
						<td>definite ptkurpose circuit breaker</td>
						<td class="alignCenter">2018-10-10  17:11:59</td>
						<td class="alignCenter">
							<button type="button" title="수정" class="intd">수정</button>
							<button type="button" title="삭제" class="intd">삭제</button>
						</td>
					</tr>
					<tr>
						<td class="alignCenter"><input type="checkbox"></td>
						<td>123</td>
						<td>3DS</td>
						<td>imun_del</td>
						<td>definite ptkurpose circuit breaker</td>
						<td class="alignCenter">2018-10-10  17:11:59</td>
						<td class="alignCenter">
							<button type="button" title="수정" class="intd">수정</button>
							<button type="button" title="삭제" class="intd">삭제</button>
						</td>
					</tr>
					<tr>
						<td class="alignCenter"><input type="checkbox"></td>
						<td>123</td>
						<td>3DS</td>
						<td>imun_del</td>
						<td>definite ptkurpose circuit breaker</td>
						<td class="alignCenter">2018-10-10  17:11:59</td>
						<td class="alignCenter">
							<button type="button" title="수정" class="intd">수정</button>
							<button type="button" title="삭제" class="intd">삭제</button>
						</td>
					</tr>
					<tr>
						<td class="alignCenter"><input type="checkbox"></td>
						<td>123</td>
						<td>3DS</td>
						<td>imun_del</td>
						<td>definite ptkurpose circuit breaker</td>
						<td class="alignCenter">2018-10-10  17:11:59</td>
						<td class="alignCenter">
							<button type="button" title="수정" class="intd">수정</button>
							<button type="button" title="삭제" class="intd">삭제</button>
						</td>
					</tr>
					<tr>
						<td class="alignCenter"><input type="checkbox"></td>
						<td>123</td>
						<td>3DS</td>
						<td>imun_del</td>
						<td>definite ptkurpose circuit breaker</td>
						<td class="alignCenter">2018-10-10  17:11:59</td>
						<td class="alignCenter">
							<button type="button" title="수정" class="intd">수정</button>
							<button type="button" title="삭제" class="intd">삭제</button>
						</td>
					</tr>
					<tr>
						<td class="alignCenter"><input type="checkbox"></td>
						<td>123</td>
						<td>3DS</td>
						<td>imun_del</td>
						<td>definite ptkurpose circuit breaker</td>
						<td class="alignCenter">2018-10-10  17:11:59</td>
						<td class="alignCenter">
							<button type="button" title="수정" class="intd">수정</button>
							<button type="button" title="삭제" class="intd">삭제</button>
						</td>
					</tr>
					<tr>
						<td class="alignCenter"><input type="checkbox"></td>
						<td>123</td>
						<td>3DS</td>
						<td>imun_del</td>
						<td>definite ptkurpose circuit breaker</td>
						<td class="alignCenter">2018-10-10  17:11:59</td>
						<td class="alignCenter">
							<button type="button" title="수정" class="intd">수정</button>
							<button type="button" title="삭제" class="intd">삭제</button>
						</td>
					</tr>
					<tr>
						<td class="alignCenter"><input type="checkbox"></td>
						<td>123</td>
						<td>3DS</td>
						<td>imun_del</td>
						<td>definite ptkurpose circuit breaker</td>
						<td class="alignCenter">2018-10-10  17:11:59</td>
						<td class="alignCenter">
							<button type="button" title="수정" class="intd">수정</button>
							<button type="button" title="삭제" class="intd">삭제</button>
						</td>
					</tr>
					<tr>
						<td class="alignCenter"><input type="checkbox"></td>
						<td>123</td>
						<td>3DS</td>
						<td>imun_del</td>
						<td>definite ptkurpose circuit breaker</td>
						<td class="alignCenter">2018-10-10  17:11:59</td>
						<td class="alignCenter">
							<button type="button" title="수정" class="intd">수정</button>
							<button type="button" title="삭제" class="intd">삭제</button>
						</td>
					</tr>
				</tbody>
			</table>
			<ul class="pagination">
				<li class="ico first" title="맨앞으로">처음</li>
				<li class="ico forward" title="앞으로">앞으로</li>
				<li>1</li>
				<li>2</li>
				<li>3</li>
				<li class="on">4</li>
				<li>5</li>
				<li>6</li>
				<li class="ico back" title="뒤로">뒤로</li>
				<li class="ico end" title="맨뒤로">마지막</li>
			</ul>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- S: 페이징 -->
<div class="paginationWrap">
<c:if test="${pagination.totalCount > 0}">
	<ul class="pagination">
		<li>
			<a href="${pagination.uri }?pageNo=${pagination.firstPage }${pagination.searchParameters}" class="first">처음</span></a>
		</li>
	<c:if test="${pagination.existPrePage == 'true' }">
		<li>	
			<a href="${pagination.uri }?pageNo=${pagination.prePageNo }${pagination.searchParameters}" class="ico forward">앞으로</a>
		</li>
	</c:if>
					
	<c:forEach var="pageIndex" begin="${pagination.startPage }" end="${pagination.endPage }" step="1">
		<li>
		<c:if test="${pageIndex == pagination.pageNo }">
			<a href="#" class="on">${pageIndex }</a>
		</c:if>
		<c:if test="${pageIndex != pagination.pageNo }">
			<a href="${pagination.uri }?pageNo=${pageIndex }${pagination.searchParameters}">${pageIndex }</a>
		</c:if>
		</li>
	</c:forEach>
	
	<c:if test="${pagination.existNextPage == 'true' }">
		<li>
			<a href="${pagination.uri }?pageNo=${pagination.nextPageNo }${pagination.searchParameters}" class="ico back">뒤로</a>
		</li>
	</c:if>	
		<li>		
			<a href="${pagination.uri }?pageNo=${pagination.lastPage }${pagination.searchParameters}" class="last">마지막</a>
		</li>
	</ul>
</c:if>
</div>
<!-- E: 페이징 -->	
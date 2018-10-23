<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:if test="${pagination.totalCount > 0}">
	<ul class="pagination">
		<c:if test="${pagination.pageNo != pagination.firstPage}">
			<li><a href="${pagination.uri }?pageNo=${pagination.firstPage}${pagination.searchParameters}" class="first"><span class="ico first"></span></a></li>
		</c:if>
		<c:if test="${pagination.existPrePage == 'true'}">
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
		</c:if>	
		<c:if test="${pagination.pageNo != pagination.lastPage }">
			<a href="${pagination.uri }?pageNo=${pagination.lastPage }${pagination.searchParameters}" class="last"><span class="ico end"></span></a>
		</c:if>	
	</ul>
</c:if>
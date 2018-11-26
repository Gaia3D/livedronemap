<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="snb">
	<h2 class="simulation"><span>시뮬레이션</span></h2>
	<ul>
	<li id="simulationLogMenu" class="" title="시뮬레이션">
			<div style="margin-top:15px;">
				<table>
					<tr style="height:35px; font-weight: bold">
						<td style="width:150px; color:#444; font-family:'Malgun Gothic','돋움',dotum, sans-serif; font-size:13px; line-height:1.5em;"><span> 전체 테스트</span></td>
						<td><button type="button" class="btnText" onclick="simulateProcess('all')">테스트</button></td>
					</tr>
					
					<tr style="height:35px; font-weight: bold">
						<td style="width:150px; color:#444; font-family:'Malgun Gothic','돋움',dotum, sans-serif; font-size:13px; line-height:1.5em;"><span> 단계 테스트 (영상처리)</span></td>
						<td><button type="button" class="btnText" onclick="simulateProcess('client')">테스트</button></td>
					</tr>
					
					<tr style="height:35px; font-weight: bold">
						<td style="width:150px; color:#444; font-family:'Malgun Gothic','돋움',dotum, sans-serif; font-size:13px; line-height:1.5em;"><span> 단계 테스트 (시각화) </span></td>
						<td><button type="button" class="btnText" onclick="simulateProcess('inner')">테스트</button></td>
					</tr>
						
					<%-- <c:forEach var="client" items="${clientList}" varStatus="status">
						<tr style="height:25px;">
							<td style="width:150px;"><span>- ${client.client_name}</span></td>
							<c:if test="${client.client_group_id eq '2'}">
								<td><button type="button" class="btnText" onclick="simulateProcess(${client.client_id},'inner')">테스트</button></td>
							</c:if>
							<c:if test="${client.client_group_id eq '1'}">
								<td><button type="button" class="btnText" onclick="simulateProcess(${client.client_id},'client')">테스트</button></td>
							</c:if>
						</tr>
					</c:forEach> --%>
				</table>
			</div>
		</li> 
	</ul>
</div>
	
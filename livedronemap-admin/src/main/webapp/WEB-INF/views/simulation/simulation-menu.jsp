<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="snb">
	<h2 class="log"><span><spring:message code='monitoring'/></span></h2>
	<ul>
		<li id="simulationMenu" class="" title="<spring:message code='monitoring.simulation'/>" onclick="goPage('/monitoring/list-simulation');">
		<spring:message code='monitoring.simulation'/>
			<div style="margin-top:15px;">
				<table>
					<tr style="height:25px;">
						<td style="width:150px;"><span>- 전체</span></td>
						<td><button type="button" class="btnText">테스트</button></td>
					</tr>
					<tr style="height:25px;">
						<td style="width:150px;"><span>- 클라이언트 1</span></td>
						<td><button type="button" class="btnText">테스트</button></td>
					</tr>
					<tr style="height:25px;">
						<td style="width:150px;"><span>- 가이아 쓰리디</span></td>
						<td><button type="button" class="btnText">테스트</button></td>
					</tr>
				</table>
			</div>
		</li>
		<li id="healthCheckMenu" class="" title="<spring:message code='monitoring.health.check'/>" onclick="goPage('/monitoring/list-health-check');">
		<spring:message code='monitoring.health.check'/>
			<div style="margin-top:15px;">
				<table>
					<tr style="height:25px;">
						<td style="width:150px;"><span>- 드론 1</span></td>
						<td><button type="button" class="btnText">점검</button></td>
					</tr>
					<tr style="height:25px;">
						<td style="width:150px;"><span>- 클라이언트 1</span></td>
						<td><button type="button" class="btnText">점검</button></td>
					</tr>
					<tr style="height:25px;">
						<td style="width:150px;"><span>- 가이아 쓰리디</span></td>
						<td><button type="button" class="btnText">점검</button></td>
					</tr>
				</table>
			</div>
		</li>
	</ul>
</div>

	
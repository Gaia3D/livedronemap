<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form id="policySimulation" modelAttribute="policy" method="post" onsubmit="return false;">
<form:hidden path="policy_id" />
	<div id="simulation_tab" class="boardNew">
		<table>
			<tr>
				<th scope="row">
					<form:label path="simulation_server_url"><spring:message code='config.simulation.server.url'/></form:label>
				</th>
				<td>
					<form:input path="simulation_server_url" maxlength="100" cssClass="s"/>
					<form:errors path="simulation_server_url" cssClass="error" />
				</td>
			</tr>
		</table>
		<div class="alignCenter">
			<button type="button" onclick="updatePolicySimulation();" class="point">저장</button>
		</div>
	</div>
</form:form>
							
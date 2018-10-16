<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form id="policyProject" modelAttribute="policy" method="post" onsubmit="return false;">
<form:hidden path="policy_id" />
	<div id="project_tab" class="boardNew">
		<table>
			<tr>
				<th scope="row">
					<form:label path="project_drone_expired_time"><spring:message code='config.project.drone.expired.time'/></form:label>
				</th>
				<td>
					<form:input path="project_drone_expired_time" maxlength="3" cssClass="s"/>
					<span class="table-desc"><spring:message code='unit.day'/></span>
					<form:errors path="project_drone_expired_time" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="rest_api_token_max_age"><spring:message code='config.project.project.max.idle.time'/></form:label>
				</th>
				<td>
					<form:input path="rest_api_token_max_age" maxlength="2" cssClass="s"/>
					<span class="table-desc"><spring:message code='unit.hour'/></span>
					<form:errors path="rest_api_token_max_age" cssClass="error" />
				</td>
			</tr>
		</table>
		<div class="alignCenter">
			<button type="button" onclick="updatePolicyProject();" class="point">저장</button>
		</div>
	</div>
</form:form>
							
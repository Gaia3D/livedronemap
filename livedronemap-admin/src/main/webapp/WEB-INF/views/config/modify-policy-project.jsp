<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="project_tab" style="display:none;">
	<form:form id="policyProject" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id" />
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="project_drone_expired_time"><spring:message code='config.project.drone.expired.time'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="project_drone_expired_time" maxlength="3" cssClass="s"/>
				<span class="table-desc"><spring:message code='unit.day'/></span>
				<form:errors path="project_drone_expired_time" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="rest_api_token_max_age"><spring:message code='config.project.project.max.idle.time'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="rest_api_token_max_age" maxlength="2" cssClass="s"/>
				<span class="table-desc"><spring:message code='unit.hour'/></span>
				<form:errors path="rest_api_token_max_age" cssClass="error" />
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
					<a href="#" onclick="updatePolicyProject();" class="button">저장</a>
		</div>
	</div>
	</form:form>
</div>
							
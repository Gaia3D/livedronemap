<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form id="policySolution" modelAttribute="policy" method="post" onsubmit="return false;">
<form:hidden path="policy_id" />
	<div id="solution_tab" class="boardNew">
		<table>
			<tbody>
				<tr>
					<th scope="row">
						<form:label path="solution_name"><spring:message code='config.solution.name'/></form:label>
					</th>
					<td>
						<form:input path="solution_name" maxlength="5" cssClass="s" />
						<form:errors path="solution_name" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<form:label path="solution_version"><spring:message code='config.solution.version'/></form:label>
					</th>
					<td>
						<form:input path="solution_version" maxlength="10" cssClass="s" />
						<form:errors path="solution_version" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<form:label path="solution_company"><spring:message code='config.solution.campany'/></form:label>
					</th>
					<td>
						<form:input path="solution_company" maxlength="20" cssClass="s" />
						<form:errors path="solution_company" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<form:label path="solution_company_phone"><spring:message code='config.solution.phone'/></form:label>
					</th>
					<td>
						<form:input path="solution_company_phone" maxlength="13" cssClass="s" />
						<form:errors path="solution_company_phone" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<form:label path="solution_manager"><spring:message code='config.solution.manager.name'/></form:label>
					</th>
					<td>
						<form:input path="solution_manager" maxlength="5" cssClass="s" />
						<form:errors path="solution_manager" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<form:label path="solution_manager_phone"><spring:message code='config.solution.manager.phone'/></form:label>
					</th>
					<td>
						<form:input path="solution_manager_phone" maxlength="13" cssClass="s" />
						<form:errors path="solution_manager_phone" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<form:label path="solution_manager_email"><spring:message code='config.solution.manager.email'/></form:label>
					</th>
					<td>
						<form:input path="solution_manager_email" maxlength="40" cssClass="s" />
						<form:errors path="solution_manager_email" cssClass="error" />
					</td>
				</tr>
			</tbody>
		</table>
		<div class="alignCenter">
			<button type="button" onclick="updatePolicySolution();" class="point">저장</button>
		</div>
		
	</div>
</form:form>
			


							
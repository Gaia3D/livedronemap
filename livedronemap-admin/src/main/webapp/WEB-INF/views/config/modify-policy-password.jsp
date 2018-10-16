<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form id="policyPassword" modelAttribute="policy" method="post" onsubmit="return false;">
<form:hidden path="policy_id" />
	<div id="password_tab" class="boardNew">
		<table>
			<tr>
				<th scope="row">
					<form:label path="password_change_term"><spring:message code='config.password.change.period'/></form:label>
				</th>
				<td>
					<form:input path="password_change_term" maxlength="3" cssClass="s" />
					<span class="table-desc"><spring:message code='unit.day'/></span>
					<form:errors path="password_change_term" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="password_min_length"><spring:message code='config.password.min.length'/></form:label>
				</th>
				<td>
					<form:input path="password_min_length" maxlength="2" cssClass="s" />
					<form:errors path="password_min_length" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="password_max_length"><spring:message code='config.password.max.length'/></form:label>
				</th>
				<td>
					<form:input path="password_max_length" maxlength="2" cssClass="s" />
					<form:errors path="password_max_length" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="password_eng_upper_count"><spring:message code='config.password.min.upper.count'/></form:label>
				</th>
				<td>
					<form:input path="password_eng_upper_count" maxlength="1" cssClass="s" />
					<form:errors path="password_eng_upper_count" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="password_eng_lower_count"><spring:message code='config.password.min.lower.count'/></form:label>
				</th>
				<td>
					<form:input path="password_eng_lower_count" maxlength="1" cssClass="s" />
					<form:errors path="password_eng_lower_count" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="password_number_count"><spring:message code='config.password.min.number.count'/></form:label>
				</th>
				<td>
					<form:input path="password_number_count" maxlength="1" cssClass="s" />
					<form:errors path="password_number_count" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="password_special_char_count"><spring:message code='config.password.min.special.count'/></form:label>
				</th>
				<td>
					<form:input path="password_special_char_count" maxlength="1" cssClass="s" />
					<form:errors path="password_special_char_count" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="password_continuous_char_count"><spring:message code='config.password.max.continuous.count'/></form:label>
				</th>
				<td>
					<form:input path="password_continuous_char_count" maxlength="1" cssClass="s" />
					<form:errors path="password_continuous_char_count" cssClass="error" />
				</td>
				<tr>
				<th scope="row">
					<form:label path="password_exception_char"><spring:message code='config.password.disable.char'/></form:label>
				</th>
				<td>
					<form:input path="password_exception_char" maxlength="1" cssClass="s" />
					<form:errors path="password_exception_char" cssClass="error" />
				</td>
			</tr>
		</table>
		<div class="alignCenter">
			<button type="button" onclick="updatePolicyPassword();" class="point">저장</button>
		</div>
	</div>
</form:form>
							
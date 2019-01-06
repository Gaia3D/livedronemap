<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form id="policyUpload" modelAttribute="policy" method="post" onsubmit="return false;">
<form:hidden path="policy_id" />
	<div id="upload_tab" class="boardNew">
		<table>
			<tr>
				<th scope="row">
					<form:label path="user_upload_type"><spring:message code='config.uplaod.type'/></form:label>
				</th>
				<td>
					<form:input path="user_upload_type" maxlength="100" cssClass="s"/>
					<form:errors path="user_upload_type" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="user_upload_max_filesize"><spring:message code='config.uplaod.max.size'/></form:label>
				</th>
				<td>
					<form:input path="user_upload_max_filesize" size="5" maxlength="3" cssClass="s"/>
					<form:errors path="user_upload_max_filesize" cssClass="error" />
				</td>
			</tr>
		</table>
		<div class="alignCenter">
			<button type="button" onclick="updatePolicyUpload();" class="point">저장</button>
		</div>
	</div>
</form:form>
							
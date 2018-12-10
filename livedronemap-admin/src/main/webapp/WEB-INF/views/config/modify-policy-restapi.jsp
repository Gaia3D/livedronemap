<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form id="policyRestapi" modelAttribute="policy" method="post" onsubmit="return false;">
<form:hidden path="policy_id" />
	<div id="restapi_tab" class="boardNew">
		<table class="input-table scope-row">
			<tr>
				<th scope="row">
					<form:label path="rest_api_converter_url"><spring:message code='config.restapi.url'/></form:label>
				</th>
				<td>
					<form:input path="rest_api_converter_url" maxlength="100" cssClass="s"/>
					<form:errors path="rest_api_converter_url" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="rest_api_encryption_yn"><spring:message code='config.restapi.encrypt.use'/></form:label>
				</th>
				
				<spring:message code='use' var='use'/>
				<spring:message code='no.use' var='noUse'/>
				<td class="col-input radio-set">
					<form:radiobutton path="rest_api_encryption_yn" value="Y" label="${use}"/>
					<form:radiobutton path="rest_api_encryption_yn" value="N" label="${noUse}" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="rest_api_token_max_age"><spring:message code='config.restapi.token.max.age'/></form:label>
				</th>
				<td>
					<form:input path="rest_api_token_max_age" maxlength="5" cssClass="s"/>
					<span class="table-desc"><spring:message code='unit.minute'/></span>
					<form:errors path="rest_api_token_max_age" cssClass="error" />
				</td>
			</tr>
		</table>
		<div class="alignCenter">
			<button type="button" onclick="updatePolicyRestApi();" class="point">저장</button>
		</div>
	</div>
</form:form>
							
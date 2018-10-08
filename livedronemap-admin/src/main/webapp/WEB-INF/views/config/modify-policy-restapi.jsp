<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="restapi_tab" style="display:none;">
	<form:form id="policyRestapi" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id" />
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="rest_api_converter_url"><spring:message code='config.restapi.url'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="rest_api_converter_url" maxlength="100" cssClass="s"/>
				<form:errors path="rest_api_converter_url" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="rest_api_encryption_yn"><spring:message code='config.restapi.encrypt.use'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			
			<spring:message code='use' var='use'/>
			<spring:message code='no.use' var='noUse'/>
			<td class="col-input radio-set">
				<form:radiobutton path="rest_api_encryption_yn" value="Y" label="${use}"/>
				<form:radiobutton path="rest_api_encryption_yn" value="N" label="${noUse}" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="rest_api_token_max_age"><spring:message code='config.restapi.token.max.age'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="rest_api_token_max_age" maxlength="5" cssClass="s"/>
				<span class="table-desc"><spring:message code='unit.minute'/></span>
				<form:errors path="rest_api_token_max_age" cssClass="error" />
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
					<a href="#" onclick="updatePolicyRestapi();" class="button">저장</a>
		</div>
	</div>
	</form:form>
</div>
							
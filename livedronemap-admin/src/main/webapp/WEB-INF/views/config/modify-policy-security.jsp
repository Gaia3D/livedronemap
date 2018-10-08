<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="security_tab" style="display:none;">
	<form:form id="policySecurity" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id" />
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="security_session_timeout_yn"><spring:message code='config.security.session.timeout.use'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			
			<spring:message code='use' var='use'/>
			<spring:message code='no.use' var='noUse'/>
			<td class="col-input radio-set">
				<form:radiobutton path="security_session_timeout_yn" value="Y" label="${use}"/>
				<form:radiobutton path="security_session_timeout_yn" value="N" label="${noUse}" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="security_session_timeout"><spring:message code='config.security.session.timeout'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="security_session_timeout" maxlength="5" cssClass="s"/>
				<span class="table-desc"><spring:message code='unit.minute'/></span>
				<form:errors path="security_session_timeout" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="security_user_ip_check_yn"><spring:message code='config.security.check.ip'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			
			<td class="col-input radio-set">
				<form:radiobutton path="security_user_ip_check_yn" value="Y" label="${use}"/>
				<form:radiobutton path="security_user_ip_check_yn" value="N" label="${noUse}" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="security_log_save_type"><spring:message code='config.security.log.save.type'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">	
				<select id="security_log_save_type" name="security_log_save_type" class="select">
	  				<option value="0"><spring:message code='config.security.log.save.type.db'/></option>
	  				<option value="1"><spring:message code='config.security.log.save.type.file'/></option>
				</select>
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="security_log_save_term"><spring:message code='config.security.log.expired.time'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="security_log_save_term" maxlength="5" cssClass="s" readonly="true" />
				<span class="table-desc"><spring:message code='unit.year'/></span>
				<form:errors path="security_log_save_term" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="security_api_result_secure_yn"><spring:message code='config.security.api.result.encrypt.use'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			
			<td class="col-input radio-set">
				<form:radiobutton path="security_api_result_secure_yn" value="Y" label="${use}"/>
				<form:radiobutton path="security_api_result_secure_yn" value="N" label="${noUse}" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="security_masking_yn"><spring:message code='config.security.user.info.masking.use'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			
			<td class="col-input radio-set">
				<form:radiobutton path="security_masking_yn" value="Y" label="${use}"/>
				<form:radiobutton path="security_masking_yn" value="N" label="${noUse}" />
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
					<a href="#" onclick="updatePolicySecurity();" class="button">저장</a>
		</div>
	</div>
	</form:form>
</div>
							
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="notice_tab" style="display:none;">
	<form:form id="policyNotice" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id" />
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="notice_service_yn"><spring:message code='config.notice.use'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			
			<spring:message code='use' var='use'/>
			<spring:message code='no.use' var='noUse'/>
			<td class="col-input radio-set">
				<form:radiobutton path="notice_service_yn" value="Y" label="${use}"/>
				<form:radiobutton path="notice_service_yn" value="N" label="${noUse}" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="notice_service_send_type"><spring:message code='config.notice.type'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">	
				<select id="notice_service_send_type" name="notice_service_send_type" class="select">
	  				<option value="0"><spring:message code='config.notice.type.sms'/></option>
	  				<option value="1"><spring:message code='config.notice.type.email'/></option>
	  				<option value="2"><spring:message code='config.notice.type.messenger'/></option>
				</select>
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="notice_risk_yn"><spring:message code='config.notice.risk.use'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			
			<td class="col-input radio-set">
				<form:radiobutton path="notice_risk_yn" value="Y" label="${use}"/>
				<form:radiobutton path="notice_risk_yn" value="N" label="${noUse}" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="notice_risk_send_type"><spring:message code='config.notice.risk.type'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">	
				<select id="notice_risk_send_type" name="notice_risk_send_type" class="select">
	  				<option value="0"><spring:message code='config.notice.type.sms'/></option>
	  				<option value="1"><spring:message code='config.notice.type.email'/></option>
	  				<option value="2"><spring:message code='config.notice.type.messenger'/></option>
				</select>
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="notice_risk_grade"><spring:message code='config.notice.risk.grade'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">	
				<select id="notice_risk_grade" name="notice_risk_grade" class="select">
	  				<option value="1"><spring:message code='grade.first'/></option>
	  				<option value="2"><spring:message code='grade.second'/></option>
	  				<option value="3"><spring:message code='grade.third'/></option>
				</select>
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
					<a href="#" onclick="updatePolicyNotice();" class="button">저장</a>
		</div>
	</div>
	</form:form>
</div>
							
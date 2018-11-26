<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form id="policyNotice" modelAttribute="policy" method="post" onsubmit="return false;">
<form:hidden path="policy_id" />
	<div id="notice_tab" class="boardNew">
		<table>
			<tr>
				<th scope="row" style="height: 38px;">
					<form:label path="notice_service_yn"><spring:message code='config.notice.use'/></form:label>
				</th>
				
				<spring:message code='use' var='use'/>
				<spring:message code='no.use' var='noUse'/>
				<td>
					<form:radiobutton path="notice_service_yn" value="Y" label="${use}"/>
					<form:radiobutton path="notice_service_yn" value="N" label="${noUse}" />
				</td>
			</tr>
			<tr>
				<th scope="row" style="height: 38px;">
					<form:label path="notice_service_send_type"><spring:message code='config.notice.type'/></form:label>
				</th>
				<td>	
					<select id="notice_service_send_type" name="notice_service_send_type" class="select">
		  				<option value="0"><spring:message code='config.notice.type.sms'/></option>
		  				<option value="1"><spring:message code='config.notice.type.email'/></option>
		  				<option value="2"><spring:message code='config.notice.type.messenger'/></option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row" style="height: 38px;">
					<form:label path="notice_risk_yn"><spring:message code='config.notice.risk.use'/></form:label>
				</th>
				
				<td>
					<form:radiobutton path="notice_risk_yn" value="Y" label="${use}"/>
					<form:radiobutton path="notice_risk_yn" value="N" label="${noUse}" />
				</td>
			</tr>
			<tr>
				<th scope="row" style="height: 38px;">
					<form:label path="notice_risk_send_type"><spring:message code='config.notice.risk.type'/></form:label>
				</th>
				<td>	
					<select id="notice_risk_send_type" name="notice_risk_send_type" class="select">
		  				<option value="0"><spring:message code='config.notice.type.sms'/></option>
		  				<option value="1"><spring:message code='config.notice.type.email'/></option>
		  				<option value="2"><spring:message code='config.notice.type.messenger'/></option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row" style="height: 38px;">
					<form:label path="notice_risk_grade"><spring:message code='config.notice.risk.grade'/></form:label>
				</th>
				<td>	
					<select id="notice_risk_grade" name="notice_risk_grade" class="select">
		  				<option value="1"><spring:message code='grade.first'/></option>
		  				<option value="2"><spring:message code='grade.second'/></option>
		  				<option value="3"><spring:message code='grade.third'/></option>
					</select>
				</td>
			</tr>
		</table>
		<div class="alignCenter">
			<button type="button" onclick="updatePolicyNotice();" class="point">저장</button>
		</div>
	</div>
</form:form>
							
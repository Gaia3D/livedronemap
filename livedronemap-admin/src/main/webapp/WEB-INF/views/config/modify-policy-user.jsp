<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form id="policyUser" modelAttribute="policy" method="post" onsubmit="return false;">
<form:hidden path="policy_id" />
	<div id="user_tab" class="boardNew">
		<table>
			<tbody>
				<tr>
					<th scope="row">
						<form:label path="user_id_min_length"><spring:message code='config.user.min.length'/></form:label>
					</th>
					<td>
						<form:input path="user_id_min_length" size="1" maxlength="2" cssClass="s" />
						<span class="table-desc" style="color:Gray;font-size:13px">5 이상</span>
						<form:errors path="user_id_min_length" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<form:label path="user_fail_login_count"><spring:message code='config.user.login.fail'/></form:label>
					</th>
					<td>
						<form:input path="user_fail_login_count" size="1" maxlength="2" cssClass="s" />
						<form:errors path="user_fail_login_count" cssClass="error" />
					</td>
				</tr>
				
				<tr>
					<th scope="row">
						<form:label path="user_fail_lock_release"><spring:message code='config.user.unlock.period'/></form:label>
					</th>
					<td>
						<form:input path="user_fail_lock_release" size="1" maxlength="5" cssClass="s" readonly="true" />
						<span class="table-desc" style="font-size:13px"><spring:message code='unit.minute'/></span>
						<form:errors path="user_fail_lock_release" size="1" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<form:label path="user_last_login_lock"><spring:message code='config.user.sleep.period'/></form:label>
					</th>
					<td>
						<form:input path="user_last_login_lock" size="1" maxlength="3" cssClass="s" />
						<span class="table-desc" style="font-size:13px"><spring:message code='unit.day'/></span>
						<form:errors path="user_last_login_lock" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row" style="height: 28px;">
						<form:label path="user_duplication_login_yn"><spring:message code='config.user.login.duplication'/></form:label>
					</th>
					
					<spring:message code='use' var='use'/>
					<spring:message code='no.use' var='noUse'/>
					<td>
						<form:radiobutton path="user_duplication_login_yn" value="Y" label="${use}"/>
						<form:radiobutton path="user_duplication_login_yn" value="N" label="${noUse}" />
					</td>
				</tr>
				<tr>
					<th scope="row" style="height: 28px;">
						<form:label path="user_update_check"><spring:message code='config.user.check.update'/></form:label>
					</th>
					
					<spring:message code='check' var='check'/>
					<spring:message code='no.check' var='noCheck'/>
					<td>
						<form:radiobutton path="user_update_check" value="0" label="${check}"/>
						<form:radiobutton path="user_update_check" value="1" label="${noCheck}" />
					</td>
				</tr>
				<tr>
					<th scope="row" style="height: 28px;">
						<form:label path="user_delete_check"><spring:message code='config.user.check.delete'/></form:label>
					</th>
					
					<td>
						<form:radiobutton path="user_delete_check" value="0" label="${check}"/>
						<form:radiobutton path="user_delete_check" value="1" label="${noCheck}" />
					</td>
				</tr>
				<tr>
					<th scope="row" style="height: 28px;">
						<form:label path="user_delete_type"><spring:message code='config.user.method.delete'/></form:label>
					</th>
					<td align:"center">	
						<form:select path="user_delete_type" name="user_delete_type" class="select">
			  				<form:option value="0"><spring:message code='config.user.method.delete.logical'/></form:option>
			  				<form:option value="1"><spring:message code='config.user.method.delete.physical'/></form:option>
						</form:select>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="alignCenter">
			<button type="button" onclick="updatePolicyUser();" class="point">저장</button>
		</div>
		
	</div>
</form:form>
									
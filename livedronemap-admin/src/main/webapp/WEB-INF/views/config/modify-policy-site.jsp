<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form id="policySite" modelAttribute="policy" method="post" onsubmit="return false;">
<form:hidden path="policy_id" />
	<div id="site_tab" class="boardNew">
		<table>
			<tbody>
				<tr>
					<th scope="row">
						<form:label path="site_name"><spring:message code='config.site.name'/></form:label>
					</th>
					<td>
						<form:input path="site_name" maxlength="10" cssClass="s" />
						<form:errors path="site_name" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<form:label path="site_admin_name"><spring:message code='config.site.admin.name'/></form:label>
					</th>
					<td>
						<form:input path="site_admin_name" maxlength="5" cssClass="s" />
						<form:errors path="site_admin_name" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<form:label path="site_admin_mobile_phone"><spring:message code='config.site.admin.phone'/></form:label>
					</th>
					<td>
						<form:input path="site_admin_mobile_phone" maxlength="13" cssClass="s" />
						<form:errors path="site_admin_mobile_phone" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<form:label path="site_admin_email"><spring:message code='config.site.admin.email'/></form:label>
					</th>
					<td>
						<form:input path="site_admin_email" maxlength="100" cssClass="s" />
						<form:errors path="site_admin_email" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<form:label path="site_product_log"><spring:message code='config.site.logo.solution'/></form:label>
					</th>
					<td>
						<form:input path="site_product_log" maxlength="15" cssClass="s" />
						<form:errors path="site_product_log" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<form:label path="site_company_log"><spring:message code='config.site.logo.company'/></form:label>
					</th>
					<td>
						<form:input path="site_company_log" maxlength="15" cssClass="s" />
						<form:errors path="site_company_log" cssClass="error" />
					</td>
				</tr>
			</tbody>
		</table>
		<div class="alignCenter">
			<button type="button" onclick="updatePolicySite();" class="point">저장</button>
		</div>
		
	</div>
</form:form>
			


							
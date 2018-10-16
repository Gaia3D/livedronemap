<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form id="policyGeoserver" modelAttribute="policy" method="post" onsubmit="return false;">
<form:hidden path="policy_id" />
	<div id="geoserver_tab" class="boardNew">
		<table>
			<tr>
				<th scope="row">
					<form:label path="geoserver_enable"><spring:message code='config.geoserver.use'/></form:label>
				</th>
				
				<spring:message code='use' var='use'/>
				<spring:message code='no.use' var='noUse'/>
				<td>
					<form:radiobutton path="geoserver_enable" value="Y" label="${use}"/>
					<form:radiobutton path="geoserver_enable" value="N" label="${noUse}" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="geoserver_wms_version"><spring:message code='config.geoserver.wms.version'/></form:label>
				</th>
				<td class="col-input">	
					<select id="geoserver_wms_version" name="geoserver_wms_version" class="select">
		  				<option value="1.1.1">1.1.1</option>
		  				<option value="1.3.0">1.3.0</option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="geoserver_background_url"><spring:message code='config.geoserver.background.url'/></form:label>
				</th>
				<td class="col-input">
					<form:input path="geoserver_background_url" maxlength="100" cssClass="s"/>
					<form:errors path="geoserver_background_url" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="geoserver_background_workspace"><spring:message code='config.geoserver.background.workspace'/></form:label>
				</th>
				<td class="col-input">
					<form:input path="geoserver_background_workspace" maxlength="50" cssClass="s"/>
					<form:errors path="geoserver_background_workspace" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="geoserver_background_layer"><spring:message code='config.geoserver.background.layer'/></form:label>
				</th>
				<td class="col-input">
					<form:input path="geoserver_background_layer" maxlength="50" cssClass="s"/>
					<form:errors path="geoserver_background_layer" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="geoserver_background_format"><spring:message code='config.geoserver.background.format'/></form:label>
				</th>
				<td class="col-input">
					<form:input path="geoserver_background_format" maxlength="50" cssClass="s"/>
					<form:errors path="geoserver_background_format" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="geoserver_terrain_url"><spring:message code='config.geoserver.terrain.url'/></form:label>
				</th>
				<td class="col-input">
					<form:input path="geoserver_terrain_url" maxlength="100" cssClass="s"/>
					<form:errors path="geoserver_terrain_url" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="geoserver_terrain_workspace"><spring:message code='config.geoserver.terrain.workspace'/></form:label>
				</th>
				<td class="col-input">
					<form:input path="geoserver_terrain_workspace" maxlength="50" cssClass="s"/>
					<form:errors path="geoserver_terrain_workspace" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="geoserver_terrain_layer"><spring:message code='config.geoserver.terrain.layer'/></form:label>
				</th>
				<td class="col-input">
					<form:input path="geoserver_terrain_layer" maxlength="50" cssClass="s"/>
					<form:errors path="geoserver_terrain_layer" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="geoserver_terrain_format"><spring:message code='config.geoserver.terrain.format'/></form:label>
				</th>
				<td class="col-input">
					<form:input path="geoserver_terrain_format" maxlength="50" cssClass="s"/>
					<form:errors path="geoserver_terrain_format" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="geoserver_data_url"><spring:message code='config.geoserver.data.url'/></form:label>
				</th>
				<td class="col-input">
					<form:input path="geoserver_data_url" maxlength="100" cssClass="s"/>
					<form:errors path="geoserver_data_url" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="geoserver_data_workspace"><spring:message code='config.geoserver.data.workspace'/></form:label>
				</th>
				<td class="col-input">
					<form:input path="geoserver_data_workspace" maxlength="50" cssClass="s"/>
					<form:errors path="geoserver_data_workspace" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="geoserver_data_format"><spring:message code='config.geoserver.data.format'/></form:label>
				</th>
				<td class="col-input">
					<form:input path="geoserver_data_format" maxlength="50" cssClass="s"/>
					<form:errors path="geoserver_data_format" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="geoserver_user"><spring:message code='config.geoserver.user'/></form:label>
				</th>
				<td class="col-input">
					<form:input path="geoserver_user" maxlength="50" cssClass="s"/>
					<form:errors path="geoserver_user" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<form:label path="geoserver_password"><spring:message code='config.geoserver.password'/></form:label>
				</th>
				<td class="col-input">
					<form:input path="geoserver_password" maxlength="50" cssClass="s"/>
					<form:errors path="geoserver_password" cssClass="error" />
				</td>
			</tr>
		</table>
		<div class="alignCenter">
			<button type="button" onclick="updatePolicyGeoserver();" class="point">저장</button>
		</div>
	</div>
</form:form>
							
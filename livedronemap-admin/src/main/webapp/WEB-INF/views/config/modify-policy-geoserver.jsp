<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="geoserver_tab" style="display:none;">
	<form:form id="policyGeoserver" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id" />
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_enable"><spring:message code='config.geoserver.use'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			
			<spring:message code='use' var='use'/>
			<spring:message code='no.use' var='noUse'/>
			<td class="col-input radio-set">
				<form:radiobutton path="geoserver_enable" value="Y" label="${use}"/>
				<form:radiobutton path="geoserver_enable" value="N" label="${noUse}" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_wms_version"><spring:message code='config.geoserver.wms.version'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">	
				<select id="geoserver_wms_version" name="geoserver_wms_version" class="select">
	  				<option value="1.1.1">1.1.1</option>
	  				<option value="1.3.0">1.3.0</option>
				</select>
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_background_url"><spring:message code='config.geoserver.background.url'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="geoserver_background_url" maxlength="100" cssClass="s"/>
				<form:errors path="geoserver_background_url" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_background_workspace"><spring:message code='config.geoserver.background.workspace'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="geoserver_background_workspace" maxlength="50" cssClass="s"/>
				<form:errors path="geoserver_background_workspace" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_background_layer"><spring:message code='config.geoserver.background.layer'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="geoserver_background_layer" maxlength="50" cssClass="s"/>
				<form:errors path="geoserver_background_layer" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_background_format"><spring:message code='config.geoserver.background.format'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="geoserver_background_format" maxlength="50" cssClass="s"/>
				<form:errors path="geoserver_background_format" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_terrain_url"><spring:message code='config.geoserver.terrain.url'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="geoserver_terrain_url" maxlength="100" cssClass="s"/>
				<form:errors path="geoserver_terrain_url" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_terrain_workspace"><spring:message code='config.geoserver.terrain.workspace'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="geoserver_terrain_workspace" maxlength="50" cssClass="s"/>
				<form:errors path="geoserver_terrain_workspace" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_terrain_layer"><spring:message code='config.geoserver.terrain.layer'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="geoserver_terrain_layer" maxlength="50" cssClass="s"/>
				<form:errors path="geoserver_terrain_layer" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_terrain_format"><spring:message code='config.geoserver.terrain.format'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="geoserver_terrain_format" maxlength="50" cssClass="s"/>
				<form:errors path="geoserver_terrain_format" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_data_url"><spring:message code='config.geoserver.data.url'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="geoserver_data_url" maxlength="100" cssClass="s"/>
				<form:errors path="geoserver_data_url" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_data_workspace"><spring:message code='config.geoserver.data.workspace'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="geoserver_data_workspace" maxlength="50" cssClass="s"/>
				<form:errors path="geoserver_data_workspace" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_data_format"><spring:message code='config.geoserver.data.format'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="geoserver_data_format" maxlength="50" cssClass="s"/>
				<form:errors path="geoserver_data_format" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_user"><spring:message code='config.geoserver.user'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="geoserver_user" maxlength="50" cssClass="s"/>
				<form:errors path="geoserver_user" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geoserver_password"><spring:message code='config.geoserver.password'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="geoserver_password" maxlength="50" cssClass="s"/>
				<form:errors path="geoserver_password" cssClass="error" />
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
					<a href="#" onclick="updatePolicyGeoserver();" class="button">저장</a>
		</div>
	</div>
	</form:form>
</div>
							
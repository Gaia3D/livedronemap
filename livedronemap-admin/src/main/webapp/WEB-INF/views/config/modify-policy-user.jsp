<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="user_tab">
	<form:form id="policyUser" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id" />
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="user_id_min_length">아이디 최소 길이</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="user_id_min_length" maxlength="2" cssClass="s" />
				<span class="table-desc">5 이상</span>
				<form:errors path="user_id_min_length" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="user_fail_login_count">로그인 최대 실패 횟수</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="user_fail_login_count" maxlength="2" cssClass="s" />
				<form:errors path="user_fail_login_count" cssClass="error" />
			</td>
		</tr>
		
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="user_fail_lock_release">계정 잠금 해제 기간</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="user_fail_lock_release" maxlength="5" cssClass="s" readonly="true" />
				<span class="table-desc">분 단위</span>
				<form:errors path="user_fail_lock_release" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="user_last_login_lock">휴면 계정 전환 기간</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="user_last_login_lock" maxlength="3" cssClass="s" />
				<span class="table-desc">일 단위</span>
				<form:errors path="user_last_login_lock" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<span>중북 로그인 허용 여부</span>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			
			
			<td class="col-input radio-set">
				<form:radiobutton path="user_duplication_login_yn" value="Y" label="사용"/>
				<form:radiobutton path="user_duplication_login_yn" value="N" label="미사용" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="user_delete_type">정보 삭제 방법</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">	
				<select id="user_delete_type" name="user_delete_type" class="select">
	  				<option value="0">논리적 삭제</option>
	  				<option value="1">물리적 삭제</option>
				</select>
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
					<a href="#" onclick="updatePolicyUser();" class="button">저장</a>
		</div>
	</div>
	</form:form>
</div>
							
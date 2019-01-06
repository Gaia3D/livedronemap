<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>

#detailMessage {
	width:100%;
	height:120%;
	z-index:2;
	position: absolute;
	background-color: rgba( 0, 0, 0, 0.25 );
	display:none;
}

#detailMessage > div {
	position:absolute;
	top:50%;
	left:50%;
	width:400px;
	height:300px;
	background:white;
	margin:-150px 0 0 -200px;
}

#detailMessageContents {
	height: 224px;
	padding: 10px;
	overflow: auto;
}

</style>

<div id="detailMessage">
	<div class="layer">
		<div class="layerHeader">
			<h2><spring:message code='message'/></h2>
			<div class="ctrlBtn">
				<button type="button" title="닫기" class="layerClose" onClick="closeDetailMessage()">닫기</button>
			</div>
		</div>
		<div id="detailMessageContents">
			
		</div>
	</div>
</div>

<script type="text/javascript">

	function closeDetailMessage() {
		$("#detailMessage").hide();
	}

</script>
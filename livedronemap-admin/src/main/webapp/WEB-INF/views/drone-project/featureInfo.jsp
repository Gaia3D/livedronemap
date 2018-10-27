<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>

#featureInfoLayer {
	display: none;
	width: 250px; 
	position: absolute; 
	z-index: 1; 
	right: 20px; 
	top: 100px;
	background-color: white;
}

#featureInfoHeader {
    background-color: #5563cf;
    padding: 5px;
    color: #FFF;
}

#featureInfo {
	border: 1px solid;
    padding: 5px;
}

</style>
<div id="featureInfoLayer" >
	<div id="featureInfoHeader">
		<h3>객체 속성</h3>
		<div class="ctrlBtn">
			<button type="button" title="닫기" class="close" onClick="closeFeatureInfo()">닫기</button>
		</div>
	</div>
	<div id="featureInfo">
		<p>객체 ID: </p>
		<p>객체 종류: </p>
		<p>탐지 일시: </p>
		<p>위도: </p>
		<p>경도: </p>
		<p>방향: </p>
		<p>속도: </p>
		<p>길이: </p>
	</div>
</div>
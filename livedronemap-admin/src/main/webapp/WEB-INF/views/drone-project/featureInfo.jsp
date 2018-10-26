<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>

#featureInfo {
	display: none;
	width: 250px; 
	position: absolute; 
	z-index: 1; 
	right: 20px; 
	top: 100px;
	background-color: white;
}

#featureInfo div {
	margin: 5px; 
	padding: 5px; 
	border: 1px solid;
}
#featureInfo div h3 {
	margin-bottom: 10px;
}

#featureInfo div p {
	margin-bottom: 5px;
}

</style>
<div id="featureInfo" >
	<div>
		<h3>객체 속성</h3>
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
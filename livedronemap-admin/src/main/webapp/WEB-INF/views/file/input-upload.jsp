<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="${accessibility}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LiveDroneMap</title>
<style>
iframe {
	width: 0px;
	height: 0px;
	border:0px;		}
</style>
</head>
<body>
<!-- 
	<form id="fileupload" action="/file/upload" method="post" enctype="multipart/form-data">
		<input type="file" name="file">
		<input type="submit" value="파일 저장">
	</form>

 -->
	<form id="fileUpload" action="/file/upload" method="post" enctype="multipart/form-data" target="zeroFrame">
		<input type="file" name="file">
		<input type="submit" value="파일 저장">
	</form>
		
	<iframe name="zeroFrame"></iframe>
	
<script>
	function addFilePath(msg) {
		alert(msg);
		documnet.getElementById("fileUpload").reset();
	}
</script>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="${accessibility}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LiveDroneMap</title>
<style>
.fileDrop {
	width: 100%;
	height: 200px;
	border:1px dotted blue;		}
samll {
	margin-left: 3px;
	font-weight: bold;
	color: gray;		}
</style>
</head>
<script src="../../../externlib/jquery/jquery.js"></script>
<body>
	
	<h3>Ajax File Upload</h3>
	<div class="fileDrop"></div>
	
	<div class="uploadedList"></div>
	
<script>

function getOriginalName(fileName) {
	
	var idx = fileName.indexOf("_") + 1;
	return fileName.substr(idx);
	
}

	$(".fileDrop").on("dragenter dragover", function(event) {
		event.preventDefault();
	});
	
	$(".fileDrop").on("drop", function(event) {
		event.preventDefault();
		
		var files = event.originalEvent.dataTransfer.files;
		
		var file = files[0];
		
		//console.log(file);
		var formData = new FormData();
		
		formData.append("file", file);
		
		console.log(formData);
		
		$.ajax({
			url: '/file/uploadAjax',
			data: formData,
			dataType: 'text',
			processData: false,
			contentType: false,
			type: "POST",
			success: function(data) {
				alert(data);
				
				var str= "<div><a href='displayFile?fileName=" + data + "'>" + getOriginalName(data) + "</a>"
						+ "\t<small data-src=" + data + ">[X]</samll></div>";

				$(".uploadedList").append(str);
				
			}
		});
	});
	
	$('.uploadedList').on("click", "small", function(event) {
		var that = $(this);
		console.log(that);
		
		$.ajax({
			url: "/file/deleteFile",
			type: "POST",
			data: {fileName: $(this).attr("data-src")},
			dataType: "text",
			success: function(result) {
				if(result = 'delete') {
					alert("deleted");
				}
			}
		});
	});
	
	
	
</script>
	
</body>
</html>
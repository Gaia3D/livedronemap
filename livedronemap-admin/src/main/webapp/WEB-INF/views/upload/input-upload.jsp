<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>main | mago3D User</title>
	<link rel="stylesheet" href="/externlib/dropzone/dropzone.css">
	<link rel="stylesheet" href="/css/ko/style.css">
	
	<script src="/externlib/dropzone/dropzone.js"></script>
</head>
<body>
	

<div id="right-panel" class="right-panel">

	<div class="content mt-3" style="min-height: 750px; background-color: white;">
		
		<div class="page-content">
			<div class="tabs">
				
				<form id="my-dropzone" action="" class="dropzone" ></form>

				<div style="margin-top: 10px; margin-left: 5px;">
					<button id="allFileUpload">업로드</button>
					<button id="allFileClear">All Clear</button>
				</div>
			</div>
		</div>
					
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>

<script src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript">
	// https://ncube.net/13905
	// http://blog.naver.com/PostView.nhn?blogId=wolfre&logNo=220154561376&parentCategoryNo=&categoryNo=1&viewDate=&isShowPopularPosts=true&from=search

	Dropzone.options.myDropzone = {
		url: "/upload/insert-upload.do",	
		//paramName: "file",
		// Prevents Dropzone from uploading dropped files immediately
		autoProcessQueue: false,
		// 여러개의 파일 허용
		uploadMultiple: true,
		method: "post",
		// 병렬 처리
		parallelUploads: 20,
		// 최대 파일 업로드 갯수
		maxFiles: 20,
		// 최대 업로드 용량 Mb단위
		maxFilesize: 500,
		dictDefaultMessage: "Drop files here or click to upload",
		/* headers: {
			"x-csrf-token": document.querySelectorAll("meta[name=csrf-token]")[0].getAttributeNode("content").value,
		}, */
		// 허용 확장자
		acceptedFiles: ".js, .css, .jpg .3ds, .obj, .dae, .ifc, .3DS, .OBJ, .DAE, .IFC, .txt, JPP, PNG, png,
		// 업로드 취소 및 추가 삭제 미리 보기 그림 링크 를 기본 추가 하지 않음
		// 기본 true false 로 주면 아무 동작 못함
		//clickable: true,
		fallback: function() {
	    	// 지원하지 않는 브라우저인 경우
	    	alert("죄송합니다. 최신의 브라우저로 Update 후 사용해 주십시오.");
	    	return;
	    },
		init: function() {
			var magoDropzone = this; // closure
			var uploadTask = document.querySelector("#allFileUpload");
			var clearTask = document.querySelector("#allFileClear");
			
			uploadTask.addEventListener("click", function(e) {
				e.preventDefault();
	            e.stopPropagation();
	            magoDropzone.processQueue(); // Tell Dropzone to process all queued files.
			});

			clearTask.addEventListener("click", function () {
                // Using "_this" here, because "this" doesn't point to the dropzone anymore
                if (confirm("정말 전체 항목을 삭제하겠습니까?")) {
                	// true 주면 업로드 중인 파일도 다 같이 삭제
                	magoDropzone.removeAllFiles(true);
                }
            });
			
			// maxFiles 카운터를 초과하면 경고창
			this.on("maxfilesexceeded", function (data) {
				alert("최대 업로드 파일 수는 20개 입니다.");
			});
			
			this.on("success", function(file, responseText) {

	            console.log("----------------------" + responseText);
	        });
			
			this.on("error", function(file, response) {
				console.log("-------error---------------" + responseText);

            });
		}
	};
</script>
</body>
</html>

$.ajax({
			type : 'post',
			url : '/replies/',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : 'text',
			data : JSON.stringify({
				studyNo : studyNo,
				userNo : replyer,
				replyText : replyText
			}),
			success : function(result) {
				if (result == 'SUCCESS') {
					replyPage = 1;
					getPage("/replies/" + studyNo + "/" + replyPage); // 댓글 리프레쉬 함수
					replytextObj.val(""); // 댓글내용 초기화
				}
			}
		});
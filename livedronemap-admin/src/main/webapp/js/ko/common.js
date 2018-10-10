// 삭제 처리 경고
function deleteWarning() {
	if(confirm("삭제 하시겠습니까?")) {
		return true;
	} else {
		return false;
	}
}

// 로딩중 Spinner 처리
function startSpinner(loadingId) {
	var $spinnerDiv = $("#" + loadingId);
    var $spinner = $spinnerDiv.progressSpin({ activeColor: "white", fillColor:"green" });
    $spinner.start();
}

// 팝업
function popupOpen(url, title, width, height) {
	var popWin = window.open(url, "","toolbar=no ,width=" + width + " ,height=" + height 
			+ ", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
	popWin.document.title = title;
}

//숫자체크
function isNumber(control) {
	var val = control;
	var Num = "1234567890";
	for (var i=0; i<val.length; i++) {
		if(Num.indexOf(val.substring(i,i+1))<0) {
			alert("숫자만 입력 가능 합니다.");
			return false;
		}
	}
	return true;
}

// IP 체크
var ipRegularExpression = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/;
function isIP(ipAddress) {
	if (ipAddress == null || ipAddress == "" || !ipRegularExpression.test(ipAddress)) {
		return false;
	}
	return true;
}

// 엑셀 파일 체크
function isExcelFile(fileName) {
	if(fileName.lastIndexOf("xlsx") >0 || fileName.lastIndexOf("xls") >0) {
		return true;
	} else {
		return false;
	}
}

// 선택된 checkbox 가 있으면 true, 없으면 false
function checkedStatus(element) {
	var returnVal = true;
	var checkStatusVal = 0;
	$.each(element, function(index) {			
		if (element[index].checked == true) {
			checkStatusVal++;
		}
	});
	//console.log("@@@@@@@@@@@@@@@@@ checkStatusVal = " + checkStatusVal);
	if (checkStatusVal == 0) {
		returnVal = false;
	}		
	return returnVal; 
}

function initJqueryCalendar() {
	$( ".date" ).datepicker({ 
		dateFormat : "yymmdd",
		dayNames : [ "일", "월", "화", "수", "목", "금", "토" ],
		dayNamesShort : [ "일", "월", "화", "수", "목", "금", "토" ],
		dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
		monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
		monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
		prevText : "",
		nextText : "",
		showMonthAfterYear : true,
		yearSuffix : "년"
	});
}

// Select Box 초기화
function initSelect(idArray, valueArray) {
	for(var i=0; i<idArray.length; i++) {
		if(valueArray[i] != null && valueArray[i] != "") {
			//console.log(idArray[i] + ", " + valueArray[i]);
			$("#" + idArray[i]).val(valueArray[i]);
		}
	}
}

// Radio 버튼 초기화
function initRadio(nameArray, valueArray) {
	for(var i=0; i<nameArray.length; i++) {
		if(valueArray[i] != null && valueArray[i] != "") {
			$("[name=" + nameArray[i] + "]").filter("[value=" + valueArray[i] + "]").prop("checked",true);
		}
	}
}

// CheckBox 초기화
function initCheckBox(idArray, valueArray) {
	for(var i=0; i<idArray.length; i++) {
		if(valueArray[i] != null && valueArray[i] != "") {
			$("#" + idArray[i]).prop("checked", true);
		}
	}
}

// Calendar 초기화
function initCalendar(idArray, valueArray) {
	for(var i=0; i<idArray.length; i++) {
		$("#" + idArray[i]).datepicker( { dateFormat: 'yymmdd' } );
		if(valueArray[i] != null && valueArray[i] != "") {
			$("#" + idArray[i]).val(valueArray[i].substring(0,8));
		}
	}
}

//팝업창인지 체크하여 팝업창일시 사이즈조절. 팝업창을 가운데로 위치시킴.
function isPopChk() {
	if(opener != undefined) {
		var popWidth = document.body.scrollWidth + 10;
		var popHeight = document.body.scrollHeight + 35;

		self.moveTo(screen.width/2-(popWidth/2),screen.height/2-(popHeight/2));
		self.resizeTo(popWidth , popHeight);
	}
}

function popup(url, title, width, height, scroll) {
	var xPos = (window.screen.availWidth - width)/2;
	var yPos = (window.screen.availHeight - height)/2;

	win = window.open(url,title,'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars='+scroll+',toolbar=no,resizable=no,copyhistory=no,width='+width+',height='+height+',left='+ xPos +',top='+ yPos+'\'');
	win.focus();
}

function drawPage(pagination, jobtype, areaId) {
	var pagecontent = "";
	var pageIndex = null;
	if(pagination.totalCount > 0) {
		pagecontent +=			"<a href=\"#\" class=\"first\" onclick=\"drawGroupPage('" + pagination.startPage + "', '" + jobtype + "'); return false;\"><span class=\"icon-glyph glyph-first\"></span></a>";
		if(pagination.existPrePage == true) {
			pagecontent +=		"<a href=\"#\" class=\"prev\" onclick=\"drawGroupPage('" + pagination.prePageNo + "', '" + jobtype + "'); return false;\"><span class=\"icon-glyph glyph-prev\"></span></a>";
		}
		for(var pageIndex = pagination.startPage; pageIndex <= pagination.endPage; pageIndex++) {
			if(pageIndex == pagination.pageNo) {
				pagecontent +=	"<a href=\"#\" class=\"current-page\">" + pageIndex + "</a>";
			} else {
				pagecontent +=	"<a href=\"#\" onclick=\"drawGroupPage('" + pageIndex + "', '" + jobtype + "'); return false;\">" + pageIndex + "</a>";
			}
		}
		if(pagination.existNextPage == true) {
			pagecontent +=		"<a href=\"#\" class=\"next\" onclick=\"drawGroupPage('" + pagination.nextPageNo + "', '" + jobtype + "'); return false;\"><span class=\"icon-glyph glyph-next\"></span></a>";
		}
		pagecontent +=			"<a href=\"#\" class=\"last\" onclick=\"drawGroupPage('" + pagination.lastPage + "', '" + jobtype + "'); return false;\"><span class=\"icon-glyph glyph-last\"></span></a>";
	}
	
	$("#" + areaId).empty();
	$("#" + areaId).html(pagecontent);
}

/**
 * 동일 문자 연속 입력 검증 (111, aaa)
 */
function isContinueSameChar(input){
	var result = false;
   
//         result = /(\w)\1\1/.test(input);
   
	for(var i=0; i < input.length; i++){
		tmp = input.charAt(i);
		if(tmp == input.charAt(i+1) && tmp == input.charAt(i+2)){                                    
			result = true;
		}
		
	}
	
	return result;
 }
 
/**
 * 연속되는 문자 입력 검증 (123, abc)
 */
function isSequenceChar(input){
	var result = false;
	
	for(var i=0; i <  input.length; i++){
		
		tmp = input.charCodeAt(i);
		
		if(input.charCodeAt(i + 1) - tmp == 1 && input.charCodeAt(i + 2) - input.charCodeAt(i + 1) == 1){
			result = true;
		}                              
		
	}

	return result;             
}

function changeLanguage(lang) {
	var updateFlag = true;
	if(updateFlag) {
		updateFlag = false;
		$.ajax({
			url: "/login/ajax-change-language.do?lang=" + lang,
			type: "GET",
			//data: info,
			cache: false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					//alert(JS_MESSAGE["success"]);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
				updateFlag = true;
			},
			error:function(request,status,error){
		        //alert(JS_MESSAGE["ajax.error.message"]);
		        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		        updateFlag = true;
			}
		});
	} else {
		alert(JS_MESSAGE["button.dobule.click"]);
		return;
	}
}


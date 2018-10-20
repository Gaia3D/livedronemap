<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>위젯 | LiveDroneMap</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" /> 
	<link rel="stylesheet" href="/css/${lang}/style.css">
	<link rel="stylesheet" href="/css/${lang}/live-drone-map.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
    <link rel="stylesheet" href="/externlib/jqplot/jquery.jqplot.min.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/externlib/echarts/echarts.min.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/live-drone-map.js"></script>
</head>

<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="contentsWrap">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<%@ include file="/WEB-INF/views/config/config-menu.jsp" %>
	
	<div class="contents">
		<h3>위젯</h3>
		
		<form:form id="widget" modelAttribute="widget" method="post" onsubmit="return false;">
		<form:hidden path="widget_order" />
		<div id="sortable" class="widgets row">
<c:forEach var="dbWidget" items="${widgetList }">
	<c:choose>
		<c:when test="${dbWidget.name == 'droneProjectWidget'}">		
			<div id="${dbWidget.widget_id }" class="widget one-third column" style="font-size: 16px;">
				<div class="widget-header row">
					<div class="widget-heading u-pull-left">						
						<h3 class="widget-title">최근 드론 프로젝트 현황<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
					</div>
					<div class="widget-functions u-pull-right">
						<a href="/data/list-data.do" title="최근 드론 프로젝트 현황 뎌보기"><span class="icon-glyph glyph-plus"></span></a>
					</div>
				</div>
				<div id="${dbWidget.name}" class="widget-content row" style="width: 300px; height: 250px;">
					<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
	            		<div id="droneProjectSpinner" style="width: 150px; height: 70px;"></div>
	            	</div>
				</div>
			</div>
		</c:when>
		<c:when test="${dbWidget.name == 'transferDataListWidget'}">		
			<div id="${dbWidget.widget_id }" class="widget one-third column" style="font-size: 16px;">
				<div class="widget-header row">
					<div class="widget-heading u-pull-left">						
						<h3 class="widget-title">데이터 상태별 현황<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
					</div>
					<div class="widget-functions u-pull-right">
						<a href="/data/list-data.do" title="<spring:message code='config.widget.data.info.more'/>"><span class="icon-glyph glyph-plus"></span></a>
					</div>
				</div>
				<div id="${dbWidget.name}" class="widget-content row">
					<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
	            		<div id="dataInfoSpinner" style="width: 150px; height: 70px;"></div>
	            	</div>
				</div>
			</div>
		</c:when>
		<c:when test="${dbWidget.name == 'tokenLogListWidget'}">		
			<div id="${dbWidget.widget_id }" class="widget one-third column">
				<div class="widget-header row">
					<div class="widget-heading u-pull-left">						
						<h3 class="widget-title">데이터 변경 요청 이력<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
					</div>
					<div class="widget-functions u-pull-right">
						<a href="/data/list-data-log.do" title="<spring:message code='config.widget.data.info.log.more'/>"><span class="icon-glyph glyph-plus"></span></a>
					</div>
				</div>
				<div id="${dbWidget.name}" class="widget-content row">
					<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
	            		<div id="dataInfoLogListSpinner" style="width: 150px; height: 70px;"></div>
	            	</div>
				</div>
			</div>
		</c:when>
		<c:when test="${dbWidget.name == 'simulationLogListWidget'}">		
			<div id="${dbWidget.widget_id }" class="widget one-third column">
				<div class="widget-header row">
					<div class="widget-heading u-pull-left">						
						<h3 class="widget-title">최근 이슈<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
					</div>
					<div class="widget-functions u-pull-right">
						<a href="/issue/list-issue.do" title="<spring:message code='config.widget.issue.more'/>"><span class="icon-glyph glyph-plus"></span></a>
					</div>
				</div>
				<div id="${dbWidget.name}" class="widget-content row">
					<div style="text-align: center; padding-top: 80px; padding-left: 30px;">
	            		Recent Issue List is under development...
	            	</div>
				</div>
			</div>
		</c:when>
		<c:when test="${dbWidget.name == 'userWidget'}">		
			<div id="${dbWidget.widget_id }" class="widget one-third column" style="font-size: 16px;">
				<div class="widget-header row">
					<div class="widget-heading u-pull-left">						
						<h3 class="widget-title"><spring:message code='config.widget.user.status'/><span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
					</div>
					<div class="widget-functions u-pull-right">
						<a href="/user/list-user.do" title="<spring:message code='config.widget.user.status.more'/>"><span class="icon-glyph glyph-plus"></span></a>
					</div>
				</div>
				<div id="${dbWidget.name}" class="widget-content row">
				</div>
			</div>
		</c:when>
		<c:when test="${dbWidget.name == 'healthCheckLogListWidget'}">	
			<div id="${dbWidget.widget_id }" class="widget one-third column">
				<div class="widget-header row">
					<div class="widget-heading u-pull-left">						
						<h3 class="widget-title"><spring:message code='config.widget.schedule'/><span class="widget-desc">${thisYear }<spring:message code='config.widget.last.year.7'/></span></h3>
					</div>
					<div class="widget-functions u-pull-right">
						<a href="/schedule/list-schedule-log.do" title="<spring:message code='config.widget.schedule.more'/>"><span class="icon-glyph glyph-plus"></span></a>
					</div>
				</div>
				<div id="${dbWidget.name}" class="widget-content row">
					<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
	            		<div id="scheduleLogListSpinner" style="width: 150px; height: 70px;"></div>
	            	</div>
				</div>
			</div>
		</c:when>
		<c:when test="${dbWidget.name == 'accessLogWidget'}">		
			<div id="${dbWidget.widget_id }" class="widget one-third column">
				<div class="widget-header row">
					<div class="widget-heading u-pull-left">						
						<h3 class="widget-title"><spring:message code='config.widget.user.tracking'/><span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
					</div>
					<div class="widget-functions u-pull-right">
						<a href="/log/list-access-log.do" title="<spring:message code='config.widget.user.tracking.more'/>"><span class="icon-glyph glyph-plus"></span></a>
					</div>
				</div>
				
				<div id="${dbWidget.name}" class="widget-content row">
					<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
	            		<div id="accessLogSpinner" style="width: 150px; height: 70px;"></div>
	            	</div>
				</div>
			</div>
		</c:when>
		<c:when test="${dbWidget.name == 'dbcpWidget'}">
			<div id="${dbWidget.widget_id }" class="widget one-third column">
				<div class="widget-header row">
					<div class="widget-heading u-pull-left">						
						<h3 class="widget-title"><spring:message code='config.widget.db.connection'/><span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
					</div>
				</div>
				
				<div id="${dbWidget.name}" class="widget-content row">
					<table class="widget-table">
						<col class="col-left" />
						<col class="col-center" />
						<col class="col-center" />
						<col class="col-center" />
						<tr>
							<td class="col-left">
								<em><spring:message code='config.widget.db.property'/></em>
							</td>
							<td class="col-center">
								<em><spring:message code='config.widget.db.admin'/></em>
							</td>
							<td class="col-center">
								<em><spring:message code='config.widget.db.user'/></em>
							</td>
							<td class="col-center">
								<em><spring:message code='config.widget.db.status'/></em>
							</td>
						</tr>
						<tr>
							<td class="col-left">
								<span class="icon-glyph glyph-users-circle"></span>
								<em><spring:message code='config.widget.db.now.session'/></em>
							</td>
							<td class="col-center">
								<span id="userSessionCount" class="tendency increase">${userSessionCount }</span>
							</td>
							<td class="col-center">
								<span id="userUserSessionCount" class="tendency increase">${userUserSessionCount }</span>
							</td>
							<td class="col-center">
								<span class="tendency increase">
									<span class="icon-glyph glyph-up"></span>
								</span>
							</td>
						</tr>
						<tr>
							<td class="col-left">
								<span class="icon-glyph glyph-imark-circle"></span>
								<em><spring:message code='config.widget.db.init'/></em> (initialSize)
							</td>
							<td class="col-center">
								<span id="initialSize" class="tendency increase">${initialSize }</span>
							</td>
							<td class="col-center">
								<span id="userInitialSize" class="tendency increase">${userInitialSize }</span>
							</td>
							<td class="col-center">
								<span class="tendency increase">
									<span class="icon-glyph glyph-up"></span>
								</span>
							</td>
						</tr>
						<tr>
							<td class="col-left">
								<span class="icon-glyph glyph-plus-circle"></span>
								<em><spring:message code='config.widget.db.max.total'/></em> (maxTotal)
							</td>
							<td class="col-center">
								<span id="maxTotal" class="tendency decrease">${maxTotal }</span>
							</td>
							<td class="col-center">
								<span id="userMaxTotal" class="tendency decrease">${userMaxTotal }</span>
							</td>
							<td class="col-center">
								<span class="tendency decrease">
									<span class="icon-glyph glyph-down"></span>
								</span>
							</td>
						</tr>
						<tr>
							<td class="col-left">
								<span class="icon-glyph glyph-top-circle"></span>
								<em><spring:message code='config.widget.db.max.idle'/></em> (maxIdle)
							</td>
							<td class="col-center">
								<span id="maxIdle" class="tendency decrease">${maxIdle }</span>
							</td>
							<td class="col-center">
								<span id="userMaxIdle" class="tendency decrease">${userMaxIdle }</span>
							</td>
							<td class="col-center">
								<span class="tendency decrease">
									<span class="icon-glyph glyph-down"></span>
								</span>
							</td>
						</tr>
						<tr>
							<td class="col-left">
								<span class="icon-glyph glyph-mouse-circle"></span>
								<em><spring:message code='config.widget.db.using'/></em> (numActive)
							</td>
							<td class="col-center">
								<span id="numActive" class="tendency increase">${numActive }</span>
							</td>
							<td class="col-center">
								<span id="userNumActive" class="tendency increase">${userNumActive }</span>
							</td>
							<td class="col-center">
								<span class="tendency increase">
									<span class="icon-glyph glyph-up"></span>
								</span>
							</td>
						</tr>
						<tr>
							<td class="col-left">
								<span class="icon-glyph glyph-bottom-circle"></span>
								<em><spring:message code='config.widget.db.min.idle'/></em> (minIdle, numIdle)
							</td>
							<td class="col-center">
								<span id="minIdle" class="tendency increase">${minIdle },${numIdle }</span>
							</td>
							<td class="col-center">
								<span id="userMinIdle" class="tendency increase">${userMinIdle },${userNumIdle }</span>
							</td>
							<td class="col-center">
								<span class="tendency increase">
									<span class="icon-glyph glyph-up"></span>
								</span>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</c:when>
		<c:when test="${dbWidget.name == 'dbSessionWidget'}">			
			<div id="${dbWidget.widget_id }" class="widget one-third column">
				<div class="widget-header row">
					<div class="widget-heading u-pull-left">						
						<h3 class="widget-title"><spring:message code='config.widget.db.session'/>(${dbSessionCount })<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
					</div>
					<div class="widget-functions u-pull-right">
						<a href="/monitoring/list-db-session.do" title="<spring:message code='config.widget.db.session.more'/>"><span class="icon-glyph glyph-plus"></span></a>
					</div>
				</div>
				<div id="${dbWidget.name}" class="widget-content row">
					<table class="widget-table">
						<col class="col-left" />
						<col class="col-left" />
			<c:if test="${empty dbSessionList }">					
						<tr>
							<td colspan="2" class="col-none"><spring:message code='config.widget.db.session.no'/></td>
						</tr>
			</c:if>
			<c:if test="${!empty dbSessionList }">
				<c:forEach var="pGStatActivity" items="${dbSessionList}" varStatus="status">
						<tr>
							<td class="col-left">
								<span class="index"></span>
								${pGStatActivity.client_addr }
							</td>
							<td class="col-left">${pGStatActivity.viewQuery }</td>
						</tr>
				</c:forEach>
			</c:if>
					</table>
				</div>
			</div>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
</c:forEach>
						</div>
						</form:form>
						<div class="button-group">
							<div class="center-buttons">
								<input type="submit" value="<spring:message code='save'/>" onclick="updateWidget(); return false;"/>
							</div>
						</div>
	</div>
</div>


<script type="text/javascript" src="/externlib/jqplot/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.barRenderer.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.categoryAxisRenderer.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.dateAxisRenderer.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.pieRenderer.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.pointLabels.js"></script>
<script type="text/javascript" src="/externlib/spinner/progressSpin.min.js"></script>
<script type="text/javascript" src="/externlib/spinner/raphael.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	$("#sortable").sortable({  
		update: function( event, ui ) {
			var widgetValue = "";
			$(".widget").each(function() {  
				widgetValue = widgetValue + "," + $(this).attr("id");
			});
			$("#widget_order").val(widgetValue);
			console.log(widgetValue);
		}
	});
	$("#sortable").disableSelection();
	
	//startSpinner("droneProjectSpinner");
	test();
	//setTimeout(test, 3000);
	
	//setInterval(test, 3000);
	
	//droneProjectWidget();
	/* dataInfoWidget();
	startSpinner("dataInfoSpinner");
	dataInfoLogWidget();
	startSpinner("dataInfoLogListSpinner");
	userWidget();
	startSpinner("scheduleLogListSpinner");
	scheduleLogListWidget();
	startSpinner("accessLogSpinner");
	accessLogWidget(); */
});

function test() {
	console.log("echarts call");
	var myChart = echarts.init(document.getElementById('droneProjectWidget'));

	var app = {};
	option = null;
	var posList = [
	    'left', 'right', 'top', 'bottom',
	    'inside',
	    'insideTop', 'insideLeft', 'insideRight', 'insideBottom',
	    'insideTopLeft', 'insideTopRight', 'insideBottomLeft', 'insideBottomRight'
	];

	app.configParameters = {
	    rotate: {
	        min: -90,
	        max: 90
	    },
	    align: {
	        options: {
	            left: 'left',
	            center: 'center',
	            right: 'right'
	        }
	    },
	    verticalAlign: {
	        options: {
	            top: 'top',
	            middle: 'middle',
	            bottom: 'bottom'
	        }
	    },
	    position: {
	        options: echarts.util.reduce(posList, function (map, pos) {
	            map[pos] = pos;
	            return map;
	        }, {})
	    },
	    distance: {
	        min: 0,
	        max: 100
	    }
	};

	app.config = {
	    rotate: 90,
	    align: 'left',
	    verticalAlign: 'middle',
	    position: 'insideBottom',
	    distance: 15,
	    onChange: function () {
	        var labelOption = {
	            normal: {
	                rotate: app.config.rotate,
	                align: app.config.align,
	                verticalAlign: app.config.verticalAlign,
	                position: app.config.position,
	                distance: app.config.distance
	            }
	        };
	        myChart.setOption({
	            series: [{
	                label: labelOption
	            }, {
	                label: labelOption
	            }, {
	                label: labelOption
	            }, {
	                label: labelOption
	            }]
	        });
	    }
	};


	var labelOption = {
	    normal: {
	        show: true,
	        position: app.config.position,
	        distance: app.config.distance,
	        align: app.config.align,
	        verticalAlign: app.config.verticalAlign,
	        rotate: app.config.rotate,
	        formatter: '{c}  {name|{a}}',
	        fontSize: 16,
	        rich: {
	            name: {
	                textBorderColor: '#fff'
	            }
	        }
	    }
	};

	option = {
	    color: ['#003366', '#006699', '#4cabce', '#e5323e'],
	    tooltip: {
	        trigger: 'axis',
	        axisPointer: {
	            type: 'shadow'
	        }
	    },
	    legend: {
	        data: ['Forest', 'Steppe', 'Desert', 'Wetland']
	    },
	    toolbox: {
	        show: true,
	        orient: 'vertical',
	        left: 'right',
	        top: 'center',
	        feature: {
	            mark: {show: true},
	            dataView: {show: true, readOnly: false},
	            magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},
	            restore: {show: true},
	            saveAsImage: {show: true}
	        }
	    },
	    calculable: true,
	    xAxis: [
	        {
	            type: 'category',
	            axisTick: {show: false},
	            data: ['2012', '2013', '2014', '2015', '2016']
	        }
	    ],
	    yAxis: [
	        {
	            type: 'value'
	        }
	    ],
	    series: [
	        {
	            name: 'Forest',
	            type: 'bar',
	            barGap: 0,
	            label: labelOption,
	            data: [320, 332, 301, 334, 390]
	        },
	        {
	            name: 'Steppe',
	            type: 'bar',
	            label: labelOption,
	            data: [220, 182, 191, 234, 290]
	        },
	        {
	            name: 'Desert',
	            type: 'bar',
	            label: labelOption,
	            data: [150, 232, 201, 154, 190]
	        },
	        {
	            name: 'Wetland',
	            type: 'bar',
	            label: labelOption,
	            data: [98, 77, 101, 99, 40]
	        }
	    ]
	};;
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}

function droneProjectWidget() {
	var url = "/config/drone-project-widget.do";
	var info = "";
	$.ajax({
		url: url,
		type: "GET",
		data: info,
		dataType: "json",
		headers: { "X-mago3D-Header" : "mago3D"},
		success : function(msg) {
			if(msg.result === "success") {
				showDroneProject(msg);
			} else {
				alert(JS_MESSAGE[msg.result]);
			}
		},
		error : function(request, status, error) {
			alert(JS_MESSAGE["ajax.error.message"]);
			console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
		}
	});
}

function showDroneProject(jsonData) {
	
	$("#droneProjectWidget").empty();
	
	
	
	
	var ticks = new Array();
	var ortho_image_count = new Array();
	var postprocessing_image_count = new Array();
	var ortho_detected_object_count = new Array();
	
	var droneProjectList = jsonData.droneProjectList;
	if (droneProjectList != null && droneProjectList.length > 0) {
		for(i=0; i<droneProjectList.length; i++) {
			var droneProject = droneProjectList[i];
			ticks.push(droneProject.drone_project_name);
			ortho_image_count.push(droneProject.ortho_image_count);
			postprocessing_image_count.push(droneProject.postprocessing_image_count);
			ortho_detected_object_count.push(droneProject.ortho_detected_object_count);
		}
	}
		
	/* var useTotalCount = parseInt(jsonData.useTotalCount);
	var forbidTotalCount = parseInt(jsonData.forbidTotalCount);
	var etcTotalCount = parseInt(jsonData.etcTotalCount); */
	
	var dataValues = [ ortho_image_count, postprocessing_image_count, ortho_detected_object_count];
	//var ticks = [use, unused, etc];
	var yMax = 100;
	/* if(useTotalCount > 10 || forbidTotalCount > 10 || etcTotalCount > 10) {
		yMax = Math.max(useTotalCount, forbidTotalCount, etcTotalCount) + (useTotalCount * 0.2);
	} */
	
	var plot = $.jqplot("droneProjectWidget", [ortho_image_count, postprocessing_image_count, ortho_detected_object_count], {
    	//title : "data info status",
    	height: 205,
    	animate: !$.jqplot.use_excanvas,
    	//seriesColors: [ "#40a7fe", "#3fbdf8" ],
    	seriesDefaults:{
        	shadow:false,
        	renderer:$.jqplot.BarRenderer,
            pointLabels: { show: true },
            rendererOptions: {
            	barWidth: 50
            }
        },
        grid: {
			background: "#fff",
			//background: "#14BA6C"
			gridLineWidth: 0.7,
			//borderColor: 'transparent',
			shadow: false,
			borderWidth:0.1
			//shadowColor: 'transparent'
		},
        gridPadding:{
	        left:35,
	        right:1,
	        to:40,
	        bottom:27
	    },
        axes: {
            xaxis: {
                renderer: $.jqplot.CategoryAxisRenderer,
                ticks: ticks,
                tickOptions:{ 
                	formatString: "%'d",
                	fontSize: "10pt"
                } 
            },
            yaxis: {
            	numberTicks : 6,
                min : 0,
                max : yMax,
                tickOptions:{ 
                	formatString: "%'d",
                	fontSize: "10pt"
                }
			}
        },
        highlighter: { show: false }
    });
}
</script>

</body>
</html>
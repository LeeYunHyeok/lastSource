<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>

		<!-- 업무타이틀(location)
		<div class="banner">
			<div class="container">
				<h2 class="ir">업무명 및 현재위치</h2>
				<div class="title_area">
					<h3>스캔 관리</h3>
					<p class="location">스캔 관리 > 스캔 스캐줄</p>
				</div>
			</div>
		</div>
		<!-- 업무타이틀(location)-->

		<!-- section -->
		<section>
			<!-- container -->
			<div class="container">
			<%@ include file="../../include/menu.jsp"%>

				<!-- content -->
				<div class="content magin_t45">
					<div class="location_area">
						<p class="location">스캔관리 > 스캔 스케쥴</p>
					</div>
					<div class="left_area2 width_17 minW">
						<h3style="padding-left:0; text-align:center;">스캔 스케줄 검색</h3>
							<div class="scan_left">
								<div class="sch_left">
									<input type="text" id="searchHost" value="" class="edt_sch">
									<button id="btnSearchScan" class="btn_sch">검색</button>
								</div>
								<ul class="task">
									<li><input type="checkbox" name="chk_schedule" id="chk_completed" value="completed"> <label for="chk_completed">완료된 작업</label></li>
									<li><input type="checkbox" name="chk_schedule" id="chk_deactivated"  value="deactivated"> <label for="chk_deactivated">비활성화된 작업</label></li>
									<li><input type="checkbox" name="chk_schedule" id="chk_cancelled"  value="cancelled"> <label for="chk_cancelled">취소된 작업</label></li>
									<li><input type="checkbox" name="chk_schedule" id="chk_stopped"  value="stopped"> <label for="chk_stopped">정지된 작업</label></li>
									<li><input type="checkbox" name="chk_schedule" id="chk_failed"  value="failed"> <label for="chk_failed">실패한 작업</label></li>
								</ul>
								<ul class="calendar">
									<li>
										<p>From</p>
										<input type="date" id="fromDate" value="${befDate}" style="text-align: center;" readonly="readonly">
									</li>
									<li>
										<p>To</p>
										<input type="date" id="toDate" value="${curDate}" style="text-align: center;" readonly="readonly">
									</li>
								</ul>
								<div class="clear"></div>
							</div>
						</div>


					<div class="grid_top" style="margin-left: 17vw;">
						<h3>스케줄 리스트</h3>
						<div class="list_sch">
							<div class="sch_area">
								<button type="button" id="btnDownloadExel" class="btn_new">다운로드</button>
								<button type="button" id="btnScanRegist" class="btn_new">신규스캔등록</button>
							</div>
						</div>
						<div class="left_box2 minW_2" style="height: auto; min-height: 750px; overflow: hidden; width:59vw;">
    						<table id="targetGrid"></table>
    						<div id="targetGridPager"></div>
						</div>
					</div>
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->

<div id="taskWindow" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px; touch-action: none; width: 150px; z-index: 999; 
	border-top: 2px solid #7b6a5a; box-shadow: 2px 2px 5px #ddd; display:none">
	<ul>
		<li class="status status-completed status-scheduled status-scanning status-paused status-stopped status-cancelled status-deactivated status-failed">
			<button id="viewSchedule" >보기</button></li>
		<li  class="status status-completed status-scheduled status-paused status-stopped status-failed">
			<button id="deactivateSchedule">비활성화</button></li>
			<!-- 
		<li class="status status-scheduled status-scanning">
			<button id="modifySchedule" >수정</button></li>
			 -->
		<li class="status status-completed status-scheduled status-scanning status-paused status-stopped">
			<button id="skipSchedule">스킵</button></li>
		<li class="status status-scanning">
			<button id="pauseSchedule">일시정지</button></li>
		<li class="status status-completed status-paused status-stopped status-failed">
			<button id="restartSchedule">재시작</button></li>
		<li class="status status-scanning">
			<button id="stopSchedule">정지</button></li>
		<li class="status status-completed status-scheduled status-scanning status-paused status-stopped status-failed status-deactivated">
			<button id="cancelSchedule">취소</button></li>
		<li  class="status status-deactivated">
			<button id="reactivateSchedule">활성화</button></li>
								
	</ul>
</div>
	
<div id="viewWindow" class="ui-widget-content" style="position:absolute; left: 700px; top: 300px; touch-action: none; 
		border: 1px solid #1F3546; max-width: 500px; z-index: 999; display:none">
	<div class="popup_top" style="cursor: grab;">
		<h1>스케쥴 세부사항</h1>
	</div>
	<div class="popup_content">
		<div class="content-box">
			<h2>세부사항</h2>
			<table class="popup_tbl">
				<colgroup>
					<col width="30%">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th>스캔명</th>
						<td id="scanLabel"></td>
					</tr>
					<tr>
						<th>스캔시간</th>
						<td id="scanNextScan"></td>
					</tr>
					<tr>
						<th>주기</th>
						<td id="scanRepeat"></td>
					</tr>
					<tr>
						<th>CPU</th>
						<td id="scanCPU"></td>
					</tr>
					<tr>
						<th>Throughput</th>
						<td id="scanThroughput"></td>
					</tr>
					<tr>
						<th>Memory 제한</th>
						<td id="scanMemory"></td>
					</tr>
					<tr>
						<th>개인정보 유형</th>
						<td id="scanDataType"></td>
					</tr>
				</tbody>
			</table>
			<h2 id="targets" style="padding-top: 10px;">targets</h2>
			<table class="popup_tbl">
				<colgroup>
					<col width="30%">
					<col width="*">
				</colgroup>
				<tbody id="targetBody">
					<tr>
						<th>서버이름</th>
						<td id="scanName"></td>
					</tr>
					<tr>
						<th>스캔경로</th>
						<td id="scanLocations"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="popup_btn">
		<div class="btn_area" style="border: 1px solid #efefef;">
			<button type="button" id="viewWindowClose" style="background: #1898D2;">확인</button>
		</div>
	</div>
</div>
	
	<%@ include file="../../include/footer.jsp"%>
 
<script type="text/javascript"> 

var oGrid = $("#targetGrid");

$(document).ready(function () {

	$(document).click(function(e){
		$("#taskWindow").hide();
	});
	$("#taskWindow").click(function(e){
		e.stopPropagation();
	});
	$("#taskWindowClose").click(function(){
		$("#taskWindow").hide();
	});

  	$("#viewWindow").draggable({
 	    containment: '.content',
 	 	cancel : '.popup_content, .popup_btn'
	});
	
	$("#viewWindowClose").click(function(){
		$("#viewWindow").hide();
	});

	var ifConnect = function(cellvalue, options, rowObject) {
		return cellvalue.indexOf("<") >= 0 ? '< ' + cellvalue.replace("<","").replace(">","") + ' >' : cellvalue;
	};
	
	var createView = function(cellvalue, options, rowObject) {
		//return '<img src="/resources/assets/images/img_check.png" style="cursor: pointer;" name="gridSubSelBtn" class="gridSubSelBtn" value=" 선택 "></a>';
		return "<button type='button' class='gridSubSelBtn' name='gridSubSelBtn'>선택</button>"; 
	};
	
	$("#fromDate").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat: 'yy-mm-dd',
		onSelect: function(dateText) {
			$("#btnSearchScan").click();
		}
	});
	$("#toDate").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat: 'yy-mm-dd',
		onSelect: function(dateText) {
			$("#btnSearchScan").click();
		}
	});

	var gridWidth = $("#targetGrid").parent().width();
	var gridHeight = 632;

	$("#targetGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['서버 이름','스캔명','개인정보 유형','스캔 상태','스캔 시간','작업','','',''],
		colModel: [      
			{ index: 'SCHEDULE_TARGET_NAME', 		name: 'SCHEDULE_TARGET_NAME', 		width: 250, align: 'left', formatter:ifConnect},
			{ index: 'SCHEDULE_LABEL', 				name: 'SCHEDULE_LABEL',				width: 400, align: 'left'},
			{ index: 'DATATYPE_LABEL',				name: 'DATATYPE_LABEL',				width: 150, align: 'center'},
			{ index: 'SCHEDULE_STATUS',				name: 'SCHEDULE_STATUS', 			width: 80, align: 'center', formatter:'select',
				editoptions:{value:{'completed':'완료','deactivated':'비활성화','cancelled':'취소','stopped':'중지','failed':'실패','scheduled':'예약','paused':'일시정지','scanning':'스캔중'}}},
			{ index: 'SCHEDULE_NEXT_SCAN_DATE_STATUS',		name: 'SCHEDULE_NEXT_SCAN_DATE_STATUS', 	width: 160, align: 'center'},
			{ index: 'SCHEDULE_ID2', 				name: 'SCHEDULE_ID2', 				width: 100, align: 'center', formatter:createView, exportcol : false},
			{ index: 'SCHEDULE_NEXT_SCAN_DATE',		name: 'SCHEDULE_NEXT_SCAN_DATE', 	width: 160, align: 'center', hidden: true},
			{ index: 'SCHEDULE_DATATYPE_PROFILES',	name: 'SCHEDULE_DATATYPE_PROFILES',	width: 200, align: 'center', hidden: true},
			{ index: 'SCHEDULE_ID', 				name: 'SCHEDULE_ID', 				width: 100, align: 'center', hidden: true}
		],
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: gridHeight,
		loadonce: true, // this is just for the demo
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 30, // 행번호 열의 너비	
		rowNum:15,
	   	rowList:[15,30,50],			
		pager: "#targetGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	  	
	  	},
		loadComplete: function(data) {
			$(".gridSubSelBtn").on("click", function(e) {
		  		e.stopPropagation();
				
				$("#targetGrid").setSelection(event.target.parentElement.parentElement.id);
				// 조건에 따라 Option 변경
				var status = ".status-" + $("#targetGrid").getCell(event.target.parentElement.parentElement.id, 'SCHEDULE_STATUS');
				$(".status").css("display", "none"); 
				$(status).css("display", "block");

				var offset = $(this).parent().offset();
				$("#taskWindow").css("left", (offset.left - $("#taskWindow").width()) + "px");
				// $("#taskWindow").css("left", (offset.left - $("#taskWindow").width() + $(this).parent().width()) + "px");
				$("#taskWindow").css("top", offset.top + $(this).height() + "px");

				var bottomLimit = $(".left_box2").offset().top + $(".left_box2").height();
				var taskBottom = Number($("#taskWindow").css("top").replace("px","")) + $("#taskWindow").height();

				if (taskBottom > bottomLimit) { 
					$("#taskWindow").css("top", Number($("#taskWindow").css("top").replace("px","")) - (taskBottom - bottomLimit) + "px");
				}
				$("#taskWindow").show();
			});
	    },
	    gridComplete : function() {
	    }
	});

	// 초기 조회
	var searchType = ['scheduled'];
	var postData = {searchType : JSON.stringify(searchType)};
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/scan/pi_scan_schedule", postData : postData, datatype:"json" }).trigger("reloadGrid");
	
	// 버튼 Action 설정
	$("#btnSearchScan").click(function() {

		var idx = 1;		
		var searchType = ['scheduled'];
		$("input[name=chk_schedule]:checked").each(function(i, elem) {
			searchType[idx++] = $(elem).val();	
		});

		var postData = {
				fromDate : $("#fromDate").val(),
				toDate : $("#toDate").val(),
				hostName : $("#searchHost").val(),
				searchType : JSON.stringify(searchType)
		};

		$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/scan/pi_scan_schedule", postData : postData, datatype:"json" }).trigger("reloadGrid");
    });

	$("#searchHost").keyup(function(e){
		
		if (e.keyCode == 13) {
			$("#btnSearchScan").click();
		}
	});
	
	$("#chk_completed, #chk_deactivated, #chk_cancelled, #chk_stopped, #chk_failed").change(function() {
		$("#btnSearchScan").click();
	});
	
	$("#viewSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');

		var postData = {id : id};
		$.ajax({
			type: "POST",
			url: "/scan/viewSchedule",
			async : false,
			data : postData,
		    success: function (resultMap) {

		        if (resultMap.resultCode != 0) {
			        alert("FAIL : " + resultMap.resultMessage);
		        	return;
			    }
			    /* Scan 상세 내역 찍기 */ 
			    var data = resultMap.resultData;

			    $("#scanLabel").html(resultMap.resultData.label);

				/*
			    CPU low	낮음
			    CPU - 기타
			    */
			    var useCPU = "";
			    if (resultMap.resultData.cpu == "low") useCPU = "낮음";
			    else useCPU = "보통";
			    $("#scanCPU").html(useCPU);

			    $("#scanNextScan").html(convertUnixTime2Date(resultMap.resultData.next_scan));
			    //$("#scanNextScan").html(resultMap.resultData.next_scanDate);
				/*
			    <repeat_days> 1	매일
			    <repeat_days> 7	일주일 마다
			    <repeat_days> 14	2주일 마다
			    <repeat_months> 1	한달마다
			    <repeat_months> 3	분기마다
			    <repeat_months> 6	6개월 마다
			    <repeat_months> 12	1년 마다
			    */
			    var repeat = "";
			    if (resultMap.resultData.repeat_days == "1") repeat = "매일";
			    else if (resultMap.resultData.repeat_days == "7") repeat = "일주일 마다";
			    else if (resultMap.resultData.repeat_days == "14") repeat = "2주일 마다";
			    else if (resultMap.resultData.repeat_months == "1") repeat = "한달 마다";
			    else if (resultMap.resultData.repeat_months == "3") repeat = "분기 마다";
			    else if (resultMap.resultData.repeat_months == "6") repeat = "6개월 마다";
			    else if (resultMap.resultData.repeat_months == "12") repeat = "1년 마다";
			    else repeat = "한번만";
			    $("#scanRepeat").html(repeat);
			    
			    // Throughput 없으면 unlimited			    
			    if (isNull(resultMap.resultData.throughput)) {
			    	$("#scanThroughput").html("제한없음");
				}
			    else {
			    	$("#scanThroughput").html(resultMap.resultData.throughput + " MB");
				}
			    
			    if (isNull(resultMap.resultData.memory)) {
			    	$("#scanMemory").html("1024 MB");
				}
			    else {
			    	$("#scanMemory").html(resultMap.resultData.memory + " MB");
				}
			    
			    
			    var profiles  = resultMap.resultData.profilesLabel; //", datatypeLabelList
			    var profilesLabel = "";
				for (var i = 0; i < profiles.length; i++) {
					profilesLabel += profiles[i].DATATYPE_LABEL + " v" + profiles[i].VERSION + "</br>";
				}
				$("#scanDataType").html(profilesLabel);
			    
			    var targets = resultMap.resultData.targets;
			    if (targets.length == 1) $("#targets").html(targets.length + " Target");
			    else $("#targets").html(targets.length + " Targets");
			    $("#targetBody").empty();
				for (var i = 0; i < targets.length; i++) {
					var locationNames = "";
					var locations = targets[i].locations;
					if(!isNull(locations)) {
						for (var j = 0; j < locations.length; j++) {
							locationNames += locations[j].name + "</br>";
						}
					}
					var html = "<tr><th>서버이름</th><td>" + targets[i].name + "</td></tr><tr><th>스캔경로</th><td>" + locationNames + "</td></tr>";
					$("#targetBody").append( html );
				}
				/*
				<tbody id="targetBody">
					<tr>
						<th>서버이름</th>
						<td id="scanName"></td>
					</tr>
					<tr>
						<th>스캔경로</th>
						<td id="scanLocations"></td>
					</tr>
			    $("#scanName").html(targets[0].name);			    
			    var locationNames = "";
			    var locations = targets[0].locations;
				for (var i = 0; i < locations.length; i++) {
					locationNames += locations[i].name + "</br>";
				}
			    $("#scanLocations").html(locationNames);
			    */
				// 위치 잡기
			    $("#viewWindow").css("top","150px");
			    $("#viewWindow").css("left","750px");
		        $("#viewWindow").show();
		    },
		    error: function (request, status, error) {
		    	alert("Recon Server에 접속할 수 없습니다.");
		        console.log("ERROR : ", error);
		    }
		});
	});
	
	$("#deactivateSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "deactivate", row);
	});
	$("#modifySchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "modify", row);
	});
	$("#skipSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "skip", row);
	});
	$("#pauseSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "pause", row);
	});
	$("#restartSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "restart", row);
	});
	$("#stopSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "stop", row);
	});
	$("#cancelSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "cancel", row);
	});
	$("#reactivateSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "reactivate", row);
	});
	
	$("#btnScanRegist").click(function(){
		window.location = "${pageContext.request.contextPath}/scan/pi_scan_regist";
	});
	
	$("#btnDownloadExel").click(function(){
		downLoadExcel();
	});
});

var today = new Date();
var dd = today.getDate();
var mm = today.getMonth()+1; //January is 0!
var yyyy = today.getFullYear();

if(dd<10) {
    dd='0'+dd
} 

if(mm<10) {
    mm='0'+mm
} 

today = yyyy+mm+dd;

function downLoadExcel()
{
    oGrid.jqGrid("exportToCsv",{
        separator: ",",
        separatorReplace : "", // in order to interpret numbers
        quote : '"', 
        escquote : '"', 
        newLine : "\r\n", // navigator.userAgent.match(/Windows/) ? '\r\n' : '\n';
        replaceNewLine : " ",
        includeCaption : true,
        includeLabels : true,
        includeGroupHeader : true,
        includeFooter: true,
        fileName : "스케줄리스트_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        returnAsString : false
    })
}

/**
 * id : schedule ID, 
 * task : 변경할 Task 
 * row : 그리드의 변경 Row ID
 * Task 변경 규칙 
 * 	- deactivate -->  deactivated
 * 	- modify --> 스캐줄 정의 및 등록 화면으로 이동, 
 * 	- skip --> scheduled
 * 	- pause --> paused
 * 	- restart --> scheduled
 * 	- stop --> scheduled
 * 	- cancel --> cancelled
 * 	- reactivate --> scheduled
 */
function changeSchedule(id, task, row)
{
	var postData = {id : id, task : task};
	$.ajax({
		type: "POST",
		url: "/scan/changeSchedule",
		async : false,
		data : postData,
	    success: function (resultMap) {

	        if ((resultMap.resultCode != 0) && (resultMap.resultCode != 200) && (resultMap.resultCode != 204)) {
		        alert("FAIL : " + resultMap.resultMessage);
	        	return;
		    }
	     	// 작업변경이 성공하면 상태도 변경 해 준다.
	     	var changedTask = "scheduled";
	     	switch (task) {
	     	case "deactivate" :
	     		changedTask = "deactivated";
	     		break;
	     	case "skip" :
	     		changedTask = "scheduled";
	     		break;
	     	case "pause" :
	     		changedTask = "pause";
	     		break;
	     	case "restart" :
	     		changedTask = "scheduled";
	     		break;
	     	case "stop" :
	     		changedTask = "stoped";
	     		break;
	     	case "cancel" :
	     		changedTask = "cancelled";
	     		break;
	     	case "reactivate" :
	     		changedTask = "scheduled";
	     		break;
     		default :
	     		changedTask = "scheduled";
     		break;
	     	}
	     	$("#targetGrid").jqGrid('setCell', row, 'SCHEDULE_STATUS', changedTask);

	     	alert("스캔 스케줄의 상태가 변경되었습니다.");
		    
	    },
	    error: function (request, status, error) {
			alert("ERROR");
	        console.log("ERROR : ", error);
	    }
	});
}

</script>


</body>
</html>
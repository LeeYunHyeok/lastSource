<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>


		<!-- 업무타이틀(location)
		<div class="banner">
			<div class="container">
				<h2 class="ir">업무명 및 현재위치</h2>
				<div class="title_area">
					<h3>타겟 관리</h3>
					<p class="location">사용자 관리 > 접속로그관리</p>
				</div>
			</div>
		</div>
		<!-- 업무타이틀(location)-->

		<!-- section -->
		<section>
			<!-- container -->
			<div class="container" style="max-width:1400px; min-width:1200px;">
			<%@ include file="../../include/menu.jsp"%>
				<!-- content -->
				<div class="content magin_t45">
					<div class="location_area">
						<p class="location">사용자 관리 > 접속로그관리</p>
					</div>
					<!-- user info -->
					<div class="grid_top">
						<h3>접속로그관리</h3>
						<table class="user_info" style="width: auto !important;">
							<caption>사용자정보</caption>
							<colgroup>
								<col width="120px"/>
								<col width="320px"/>
								<col width="120px"/>
								<col width="320px"/>
								<col width="120px"/>
								<col width="355px"/>
								<col width="120px"/>
							</colgroup>
							<tbody>
								<tr>
									<td style="text-align: center; background-color: #d6e4ed; max-width:10vw; font-size:.85vw; padding: 10px 3px;">사용자 ID</td>
									<td style="max-width:2vw"><input type="text" style="width: 9.5vw; font-size:.85vw;" id="userNo" placeholder="사용자 ID를 입력하세요"></td>
									<td style="text-align: center; background-color: #d6e4ed; max-width:10vw; font-size:.85vw; padding: 10px 3px;">사용자 명</td>
									<td style="max-width:2vw;"><input type="text" style="width: 9.5vw; font-size:.85vw;" id="userName" placeholder="사용자명을 입력하세요"></td>
									<td style="text-align: center; background-color: #d6e4ed; width:10vw; font-size:.85vw; padding: 10px 3px;">사용기간</td>
									<td style="padding: 10px 3px;">
										<input type="date" id="fromDate" style="width: 6.5vw; text-align: center; font-size:.7vw; padding-right: 12px;" readonly="readonly" value="${fromDate}" >
										<span style="width: 8%; margin-right: 0;">~</span>
										<input type="date" id="toDate" style="width: 6.5vw; text-align: center; font-size:.7vw; padding-right: 12px;" readonly="readonly" value="${toDate}" >
									</td>
									<td class="btn_area2" style="text-align: right;">
										<button class="margin_reset" type="button" id="serch_log"> 검색 </button>
									</td>								
								</tr>
							</tbody>
						</table>
					</div>

					<!-- list -->
					<div class="grid_top" style="margin-top: 20px;">
						<h3>사용 현황</h3>
						<div class="list_sch">
							<div class="sch_area">
								<button type="button" name="button" class="btn_new" id="btnDownloadExel">다운로드</button>
							</div>
						</div>
						<div class="left_box2 minW minH_2" style="overflow: hidden; max-height: 615px; height: 615px;">
		   					<table id="userGrid"></table>
		   					<div id="userGridPager"></div>
						</div>
					</div>
				</div>
			</div>
			<!-- container -->
		</section>
		
	<%@ include file="../../include/footer.jsp"%>
	
<script type="text/javascript">

var oGrid = $("#userGrid");

function fn_search () {
	var postData = {
		userNo : $("#userNo").val(),
		userName : $("#userName").val(),
		fromDate : $("#date1").val(),
		toDate : $("#date2").val() 
	};
	
	$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/user/pi_userlog_list", postData : postData, datatype:"json" }).trigger("reloadGrid");
}

$(document).ready(function () {

	$("#fromDate").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat: 'yy-mm-dd'
	});
	$("#toDate").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat: 'yy-mm-dd'
	});
	
	var gridWidth = $("#userGrid").parent().width();
	var gridHeight = 515;
	$("#userGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['사용자 ID','사용자명','아이피', '사용화면', '작업내용', '일자'],
		colModel: [      
			{ index: 'USER_NO', 			name: 'USER_NO', 			width: 150,	align: 'center'},
			{ index: 'USER_NAME',			name: 'USER_NAME',			width: 150, align: 'center'},
			{ index: 'USER_IP',				name: 'USER_IP',			width: 200, align: 'center'},
			{ index: 'MENU_NAME',			name: 'MENU_NAME',			width: 200, align: 'left'},
			{ index: 'JOB_INFO',			name: 'JOB_INFO',			width: 500, align: 'left'},
			{ index: 'REGDATE',				name: 'REGDATE', 			width: 200, align: 'center'}
		],
		width: gridWidth,
		height: gridHeight,
		loadonce: true, // this is just for the demo
		viewrecords: true, // show the current page, data rang and total records on the toolbar
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : true, // 행번호 표시여부
		rownumWidth : 50, // 행번호 열의 너비	
		rowNum:30,
	   	rowList:[10,20,30],
	    search: true,			
		pager: "#userGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	  		
	  	},
		loadComplete: function(data) {
	    },
	    gridComplete : function() {
	    }
	});

	var postData = {
		userNo : $("#userNo").val(),
		userName : $("#userName").val(),
		fromDate : $("#date1").val(),
		toDate : $("#date2").val() 
	};
	$("#userGrid").setGridParam({
		url:"<%=request.getContextPath()%>/user/pi_userlog_list",
		postData : postData, 
		datatype:"json" 
		}).trigger("reloadGrid");
	});

	$("#serch_log").click(function() {
		fn_search();
    });

	$('#userNo').keyup(function(e) { //userNo userName
		if (e.keyCode == 13) {
			fn_search();
	    }
	});

	$('#userName').keyup(function(e) { //userNo userName
		if (e.keyCode == 13) {
			fn_search();
	    }
	});
	
	$("#btnDownloadExel").click(function(){
		downLoadExcel();
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
        fileName : "접속_로그_리스트_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        returnAsString : false
    })
}
</script>

</body>
</html>


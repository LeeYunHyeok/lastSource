<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>

<!-- section -->
<section>
	<!-- container -->
	<div class="container minMenu_2">
	<%@ include file="../../include/menu.jsp"%>
		<!-- content -->
		<div class="content magin_t45">
			<div class="location_area">
				<p class="location">리포트관리 > 통합 보고서</p>
			</div>
            <div class="grid_top">
                <h3>통합 보고서</h3>
                <div class="list_sch">
                    <div class="sch_area">
                        <button type="button" name="button" class="btn_new" id="btnSearch">Search</button>
                        <button type="button" name="button" class="btn_new" id="btnDownloadExel">다운로드</button>
                    </div>
                </div>
                <table class="user_info narrowTable">
                    <caption>사용자정보</caption>
                    <tbody>
                        <tr>
                            <td style="text-align: center; background-color: #d6e4ed; width:4vw; font-size:.85vw">업무구분</td>
                            <td style="width:7vw;">
                                <select id="selectList" name="selectList" style="width:6.5vw;">
                                    <option value="/report/pi_report_summary" selected>통합 보고서</option>
                                    <option value="/report/pi_report_exception">예외/오탐수용 보고서</option>
                                </select>
                            </td>
                            <td style="text-align: center; background-color: #d6e4ed; width:4vw">호스트</td>
                            <td style="width:10vw"><input type="text" style="width: 100%;" size="10" id="schOwner" placeholder="호스트명을 입력하세요"></td>
                            <td style="text-align: center; background-color: #d6e4ed; width:4vw">경로명</td>
                            <td style="width:10vw"><input type="text" style="width: 100%;" size="20" id="schFilename" placeholder="문서명을 입력하세요"></td>
                            <td style="text-align: center; background-color: #d6e4ed; width:5.5vw">문서저장일</td>
                            <td style="width:17vw;">
                                <input type="date" id="fromDate" style="text-align: center; width:8.5vw;" readonly="readonly" value="${fromDate}" >
                                <span style="width: 8%; margin-right: 3px;">~</span>
                                <input type="date" id="toDate" style="text-align: center; width:8.5vw;" readonly="readonly" value="${toDate}" >
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
			<div class="left_box2 minW" style="overflow: hidden; max-height: 732px; height: 732px;">
				<table id="targetGrid"></table>
				<div id="targetGridPager"></div>
			</div>
		</div>
	</div>
</section>
<%@ include file="../../include/footer.jsp"%>

<script type="text/javascript">
// var postData = {target_id : $("#hostSelect").val()};
// var gridWidth = $("#targetGrid").parent().width();
var oGrid = $("#targetGrid");

$(document).ready(function () {

    // 날짜 설정
    setSelectDate();

    // SelectList를 선택하면 선택된 화면으로 이동한다.
    $("#selectList").change(function () {
        location.href = $("#selectList").val();
    });

    $("#btnDownloadExel").on("click", function(){
    	downLoadExcel();
    });

    $("#btnSearch").on("click", function(){
    	fn_search();
    });

    loadJqGrid();
});

function loadJqGrid()
{
	var oPostDt = {};
	oPostDt["owner"]    = $("#schOwner").val();
	oPostDt["filename"] = $("#schFilename").val();
	oPostDt["fromDate"] = $("#fromDate").val();
	oPostDt["toDate"]   = $("#toDate").val();
	
	oGrid.jqGrid({
		url: "${getContextPath}/report/searchSummaryList",
		datatype: "json",
	   	mtype : "POST",
	   	postData: oPostDt, 
	   	contentType:"application/x-www-form-urlencoded; charset=utf-8",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true 
		},
		colNames:['호스트', '경로', '기안자','결재자','기안일','결재일','메모','상태'],
		colModel: [		
			{ index: 'TARGET_NAME',	name: 'TARGET_NAME',	width: 100, align: 'center'},
			{ index: 'PATH',		name: 'PATH',			width: 150, align: 'left'},
			{ index: 'USER_NO',		name: 'USER_NO',		width: 70, align: 'center'},
			{ index: 'OKUSER_NO',	name: 'OKUSER_NO', 		width: 70, align: 'center'},
			{ index: 'REGDATE',		name: 'REGDATE', 		width: 70, align: 'center'},
			{ index: 'OKDATE',		name: 'OKDATE', 		width: 70, align: 'center'},
			{ index: 'NOTE',		name: 'NOTE', 			width: 100, align: 'left'},
			{ index: 'APPROVAL_STATUS',		name: 'APPROVAL_STATUS', 		width: 50, align: 'center', formatter:'select', editoptions:{value:{'E':'승인완료','D':'반려','W':'승인대기'}}}
		],
		loadonce :true,
		viewrecords: false, // show the current page, data rang and total records on the toolbar
		width: 600,
		height: 600,
		loadonce: true, // this is just for the demo
	   	autowidth: true,
		shrinkToFit: true,
		pager: "#targetGridPager",
		rownumbers : true, // 행번호 표시여부
		rownumWidth : 40, // 행번호 열의 너비	
		rowNum:14,
		jsonReader : {
			id : "ID"
		}
	});
}


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
        fileName :  "통합_보고서_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        returnAsString : false
    })
}

//문서 기안일
function setSelectDate() 
{
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
	
	var oToday = new Date();
	$("#toDate").val(getFormatDate(oToday));
	
	var oFromDate = new Date(oToday.setDate(oToday.getDate() - 30));
	$("#fromDate").val(getFormatDate(oFromDate));
}

//검색
function fn_search() 
{
	// 정탐/오탐 리스트 그리드
	var oPostDt = {};
	oPostDt["owner"]    = $("#schOwner").val();
	oPostDt["filename"] = $("#schFilename").val();
	oPostDt["fromDate"] = $("#fromDate").val();
	oPostDt["toDate"]   = $("#toDate").val();
	
	oGrid.clearGridData();
	oGrid.setGridParam({
	    url: "${getContextPath}/report/searchSummaryList",
	    postData: oPostDt, 
	    datatype: "json"
	}).trigger("reloadGrid");
}

//
function getFormatDate(oDate)
{
	var nYear = oDate.getFullYear();           // yyyy 
	var nMonth = (1 + oDate.getMonth());       // M 
	nMonth = ('0' + nMonth).slice(-2);         // month 두자리로 저장 
	
	var nDay = oDate.getDate();                // d 
	nDay = ('0' + nDay).slice(-2);             // day 두자리로 저장
	
	return nYear + '-' + nMonth + '-' + nDay;
}
</script>

</body>
</html>

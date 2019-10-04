<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>

<!-- section -->
<section>
	<!-- container -->
	<div class="container">
	<%@ include file="../../include/menu.jsp"%>
		<!-- content -->
		<div class="content magin_t45">
			<div class="location_area">
				<p class="location">리포트관리 > 예외/오탐수용 보고서</p>
			</div>
            <div class="grid_top">
                <h3>예외/오탐수용 보고서</h3>
                <div class="list_sch">
                    <div class="sch_area">
                        <button type="button" name="button" class="btn_new" id="btnSearch">Search</button>
                        <button type="button" name="button" class="btn_new" id="btnDownloadExel">다운로드</button>
                    </div>
                </div>
                <table class="user_info">
                    <caption>사용자정보</caption>
                    <tbody>
                        <tr>
                            <td style="text-align: center; background-color: #eeeeee; width:100px">업무구분</td>
                            <td style="width:180px;">
                                <select id="selectList" name="selectList" style="width:160px;">
                                    <option value="/report/pi_report_summary">통합 보고서</option>
                                    <option value="/report/pi_report_exception" selected>예외/오탐수용 보고서</option>
                                </select>
                            </td>
                            <td style="text-align: center; background-color: #eeeeee; width:100px">호스트</td>
                            <td><input type="text" style="width: 100%;" size="10" id="schOwner" placeholder="호스트명을 입력하세요"></td>
                            <td style="text-align: center; background-color: #eeeeee; width:100px">문서명</td>
                            <td><input type="text" style="width: 100%;" size="20" id="schFilename" placeholder="문서명을 입력하세요"></td>
                            <td style="text-align: center; background-color: #eeeeee; width:100px">문서저장일</td>
                            <td style="width:300px;">
                                <input type="date" id="fromDate" style="text-align: center; width:127px" readonly="readonly" value="${fromDate}" >
                                <span style="width: 8%; margin-right: 3px;">~</span>
                                <input type="date" id="toDate" style="text-align: center; width:127px" readonly="readonly" value="${toDate}" >
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
			<div class="left_box2" style="overflow: hidden; max-height: 732px; height: 732px;">
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

    $("#btnSearch").click(function () {
    	fn_search();
    });

    $("#btnDownloadExel").on("click", function(){
        downLoadExcel();
    });

    loadJqGrid();
});

function loadJqGrid()
{
	oGrid.jqGrid({
		url: "${getContextPath}/report/searchExceptionList",
		datatype: "json",
	   	mtype : "POST",
	   	contentType: 'application/json; charset=UTF-8',
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['호스트 이름', '경로', '기안자','기안자ID','결재자','결재자ID','기안일','결재일','메모'],
		colModel: [		
			{ index: 'name',		name: 'name',		    width: 100, align: 'left'},
			{ index: 'path_ex',		name: 'path_ex',		width: 200, align: 'left'},
			{ index: 'user_nm',		name: 'user_nm', 		width: 60,  align: 'center'},
			{ index: 'user_no',     name: 'user_no',        width: 70,  align: 'left', hidden: true},
			{ index: 'ok_user_nm',	name: 'ok_user_nm', 	width: 60,  align: 'center'},
			{ index: 'ok_user_no',  name: 'ok_user_no',     width: 70,  align: 'left', hidden: true},
			{ index: 'regdate',		name: 'regdate', 		width: 90,  align: 'center'},
			{ index: 'okdate',		name: 'okdate', 		width: 90,  align: 'center'},
			{ index: 'reason',		name: 'reason', 		width: 180, align: 'left'},
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
		rowNum:25,
		rowList:[25,50,100],
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
        fileName : "예외_오탐수용_보고서_" + today + ".csv",
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
function fn_search(obj) 
{
    // 정탐/오탐 리스트 그리드
    var oPostDt = {};
    oPostDt["owner"]    = $("#schOwner").val();
    oPostDt["filename"] = $("#schFilename").val();
    oPostDt["fromDate"] = $("#fromDate").val();
    oPostDt["toDate"]   = $("#toDate").val();
    
    oGrid.clearGridData();
    oGrid.setGridParam({
        url: "${getContextPath}/report/searchExceptionList",
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

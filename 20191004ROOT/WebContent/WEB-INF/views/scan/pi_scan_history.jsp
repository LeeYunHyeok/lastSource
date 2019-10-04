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
					<h3>예외처리 관리</h3>
					<p class="location">예외처리 관리 > 검출 관리</p>
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
						<p class="location">스캔 관리 > 스캔 히스토리</p>
					</div>
					<div class="grid_top">
						<h3>스캔 히스토리</h3>
						<div class="select_area bold" style=" position: absolute; right: 200px; top: 0;">
							Host : 
							<select id="hostSelect" name="hostSelect">
								<c:forEach items="${targetList}" var="targetList">
				   				<option value="${targetList.TARGET_ID}"<c:if test="${targetList.TARGET_ID == target_id}">selected</c:if>>${targetList.AGENT_NAME} - ${targetList.AGENT_CONNECTED_IP}</option>
								</c:forEach>
							</select>	
						</div>
						<div class="list_sch">
							<div class="sch_area">
								<button type="button" name="button" class="btn_new" id="btnDownloadExel">다운로드</button>
								</div>
						</div>
					</div>
					<div class="left_box2" style="overflow: hidden; max-height: 732px;height: 732px;">
	   					<table id="targetGrid"></table>
					</div>
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->


<%@ include file="../../include/footer.jsp"%>
<script type="text/javascript"> 

var oGrid = $("#targetGrid");

function fnfnChangeScanHistory() {

	var postData = {target_id : $("#hostSelect").val()};
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/scan/viewScanHistory", postData : postData, datatype:"json",treedatatype : 'json' }).trigger("reloadGrid");
} 

$(document).ready(function () {
	
	var createCheckbox = function(cellvalue, options, rowObject) {
		var value = rowObject['ID'];
	    var str = "<input type=\"checkbox\" name=\"gridChk\" value="+ rowObject['ID'] +" data-rowid=" + options['rowId'] + ">";
	    
	    if (rowObject['LEVEL'] == "1") return str;
		else return "";
	    /*
		if ((rowObject['LEVEL'] == "1") && (rowObject['STATUS'] != "E") && (rowObject['STATUS'] != "W")) return str;
		else return ""
		*/
	};
	
	$("#hostSelect").change(function(e){
		fnfnChangeScanHistory();
	});
	
	var postData = {target_id : $("#hostSelect").val()};
	var gridWidth = $("#targetGrid").parent().width();
	$("#targetGrid").jqGrid({
		url: "<%=request.getContextPath()%>/scan/viewScanHistory",
		postData : postData,
		datatype: "json",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['','스 캔 경 로','호스트','스캔날짜','상태', 'TARGET_ID'], 
		colModel: [      
			{ index: 'CHK', 		name: 'CHK',		width: 30,  align: 'center', editable: true, edittype: 'checkbox', classes: 'pointer',
				editoptions: { value: "1:0" }, formatoptions: { disabled: false }, formatter: createCheckbox, sortable: false},
			{ index: 'URI', 		name: 'URI',		width: 400, align: 'left', },
			{ index: 'NAME',		name: 'NAME',		width: 170, align: 'center'},
			{ index: 'DATE',		name: 'DATE', 		width: 170, align: 'center' },
			{ index: 'INACCESS',	name: 'INACCESS', 	width: 70, 	align: 'center'},
			{ index: 'TARGET_ID',	name: 'TARGET_ID',  width: 1, 	hidden:true}
		],
		loadonce :true,
		viewrecords: false, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 660,
		loadonce: true, // this is just for the demo
	   	autowidth: true,
	   	shrinkToFit: true,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 75, // 행번호 열의 너비	
		rowNum:1000000,
		// multiselect:true,
	   	// rowList:[10,20,30],			
		// pager: "#targetGridPager",
		// enable tree grid
        ExpandColClick: true,
		onCellSelect: function(rowid,icol,cellcontent,e) {
	  	},
		loadComplete: function(data) {
	    }
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

// 첫번째에 인덱스 넣을지 결정, 그리고 상태 컬럼 없음
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
        fileName : "스캔히스토리_리스트_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        returnAsString : false
    })
}

</script>

</body>
</html>
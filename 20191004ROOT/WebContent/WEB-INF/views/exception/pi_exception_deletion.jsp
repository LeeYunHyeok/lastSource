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
						<p class="location">예외처리 관리 > 예외 리스트</p>
					</div>
					<div class="grid_top">
						<h3>삭제 리스트</h3>
						
						<div class="select_area bold" style=" position: absolute; font-size:.75vw; width:20vw; top:0; right: 37vw;">
							Host : 
							<select id="hostSelect" name="hostSelect" style="min-width:12vw; font-size:.75vw">
								<c:forEach items="${targetList}" var="targetList">
				   				<option value="${targetList.TARGET_ID}"<c:if test="${targetList.TARGET_ID == target_id}">selected</c:if>>${targetList.AGENT_NAME} - ${targetList.AGENT_CONNECTED_IP}</option>
								</c:forEach>
							</select>
						</div>
							
						<div class="select_area bold" style=" position: absolute; right: 10vw; top: 0px; width: 20vw;">
							<div class="radio_area" style="margin:0;">
								<input type="date" id="fromDate" style="text-align: center; width:8.5vw; font-size:.7vw;" readonly="readonly" value="${fromDate}" >
								<span style="width: 8%; margin-right: 3px;">~</span>
								<input type="date" id="toDate" style="text-align: center; width:8.5vw; font-size:.7vw;" readonly="readonly" value="${toDate}" >
							</div>
						</div>
						<div class="list_sch">
							<div class="sch_area">
								<button class="btn_new" type="button" id="btnDeletionDelete"> 등록 삭제 </button>
							</div>
						</div>
					</div>
					<div class="left_box2 minW" style="overflow: hidden; max-height: 732px;height: 732px;">
	   					<table id="targetGrid"></table>
		   				<div id="targetGridPager"></div>
					</div>
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->

	<%@ include file="../../include/footer.jsp"%>

<script type="text/javascript"> 

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
	
	var createImg = function(cellvalue, options, rowObject) {
		var imgStr = "<img src='<%=request.getContextPath()%>/resources/assets/images/file.png' id='' ";

		imgStr += "onclick='event.stopPropagation(); fnSetException(" + options["rowId"] + ");";
		imgStr += " ' />";

		return imgStr;			
	};

	$("#hostSelect").change(function(e){

		fn_search();
	});

	var gridWidth = $("#targetGrid").parent().width();
	$("#targetGrid").jqGrid({
		// url: "<%=request.getContextPath()%>/exception/selectDeletionList",
		// postData : postData,
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['경 로','호스트','등록일자','PID','IDX','GROUP_ID','TARGET_ID','HASH_ID','REASON',
				'REG_USER_NO','REG_USER_NAME'],
		colModel: [    
			{ index: 'PATH', 			name: 'PATH', 				width: 600, align: 'left'},
			{ index: 'TARGET_NAME', 	name: 'TARGET_NAME', 		width: 350, align: 'left'},
			{ index: 'REGDATE',			name: 'REGDATE', 			width: 180, align: 'center'},   
			{ index: 'PID', 			name: 'PID', 				width: 100, hidden:true},
			{ index: 'IDX', 			name: 'IDX',				width: 100, hidden:true},
			{ index: 'GROUP_ID',		name: 'GROUP_ID',			width: 100, hidden:true},
			{ index: 'TARGET_ID',		name: 'TARGET_ID', 			width: 100, hidden:true},
			{ index: 'HASH_ID',			name: 'HASH_ID', 			width: 100, hidden:true},
			{ index: 'REASON',			name: 'REASON', 			width: 100, hidden:true},
			{ index: 'REG_USER_NO',		name: 'REG_USER_NO', 		width: 100, hidden:true},
			{ index: 'REG_USER_NAME',	name: 'REG_USER_NAME', 		width: 100, hidden:true}
			],
		loadonce :true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 632,
	   	multiselect : true,
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 75, // 행번호 열의 너비	
		rowNum:25,
	   	rowList:[25,50,100],		
		pager: "#targetGridPager",
		onCellSelect: function(rowid,icol,cellcontent,e) {
	  	},
		loadComplete: function(data) {
	    }
	});

	fn_search();
	
	$('input[type=radio][name=rdo_task]').change(function() {
		fn_search();
	});
	
	$('input[type=radio][name=rdo_status]').change(function() {
		fn_search();
	});
	
	$('#btn_search').click(function() {
		fn_search();
	});

	$('#txt_path').keyup(function(e) {
		if (e.keyCode == 13) {
			fn_search();
	    }
	});

	$("#btnDeletionDelete").on("click", function(e) {
		
		var deletionList = new Array();
		var selRows = $("#targetGrid").getGridParam('selarrrow');
		for (var i = 0; i < selRows.length; i++) {
			deletionList.push($("#targetGrid").jqGrid('getCell', selRows[i], 'HASH_ID'));
		}

		if (deletionList.length == 0) {
			alert("삭제할 항목을 선택하십시요");
			return;
		}
		var postData = {deletionList : deletionList};
		$.ajax({
			type: "POST",
			url: "/exception/deleteDeletion",
			async : false,
			data : postData,
		    success: function (result) {
		    	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/exception/selectDeletionList", datatype:"json" }).trigger("reloadGrid");
				alert("삭제목록을 삭제하였습니다.");
		    },
		    error: function (request, status, error) {
		    	alert("삭제에 실패 하였습니다.");
		        console.log("ERROR : ", error);
		    }
		});
	});

	$("#btnCancel").on("click", function(e) {
		$("#exceptionReasonPopup").hide();
	});
	
});

function fn_search() {
	var postData = {
		target_id : $("#hostSelect").val(),
		fromDate : $('#fromDate').val(),
		toDate : $('#toDate').val()
	};
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/exception/selectDeletionList", postData : postData, datatype:"json" }).trigger("reloadGrid");	
}

function fnSetException(rowID) {

	$("#reg_user_name").val($("#targetGrid").jqGrid('getCell', rowID, 'REG_USER_NAME'));
	$("#ok_user_name").val($("#targetGrid").jqGrid('getCell', rowID, 'OK_USER_NAME'));
	$("#regdate").val($("#targetGrid").jqGrid('getCell', rowID, 'REGDATE'));
	$("#okdate").val($("#targetGrid").jqGrid('getCell', rowID, 'OKDATE'));
	$("#reason").val($("#targetGrid").jqGrid('getCell', rowID, 'REASON'));

	if (isNull($("#targetGrid").jqGrid('getCell', rowID, 'OKDATE'))) {
		$("#reason").attr("readonly", false);
		$("#reason").css("background-color", "#d6fbff");
		$("#exceptionReasonPopup").show();
		$("#reason").focus();
	}
	else {
		$("#btnSave").css("display", "none");
		$("#exceptionReasonPopup").show();
	}

}

</script>

</body>
</html>
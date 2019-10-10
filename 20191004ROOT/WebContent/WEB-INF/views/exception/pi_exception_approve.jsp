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
						<p class="location">예외처리 관리 > 예외처리 승인</p>
					</div>
					<div class="grid_top">
						<h3>예외처리 승인</h3>
					
						<div class="select_area bold" style="position:absolute; font-size:.75vw; right: 40vw; top:0; width: 18vw">
							신청자 : 
							<select id="userSelect" name="userSelect" style="min-width:12vw;  font-size:.75vw;">
								<c:forEach items="${teamMemberList}" var="teamMemberList">
				   				<option value="${teamMemberList.USER_NO}">${teamMemberList.USER_NAME} ${teamMemberList.JIKGUK} (${teamMemberList.USER_NO})</option>
								</c:forEach>
							</select>
						</div>
							
						<div class="select_area bold" style="position:absolute; font-size:.75vw; right: 23.5vw; top:0; width: 17vw">
							<div class="radio_area" style="margin:0;">
								Host :  
								<select id="hostSelect" name="hostSelect" style="min-width:12vw; width:14vw; font-size:.75vw">
									<c:forEach items="${targetList}" var="targetList">
				   					<option value="${targetList.TARGET_ID}"<c:if test="${targetList.TARGET_ID == target_id}">selected</c:if>>${targetList.AGENT_NAME} - ${targetList.AGENT_CONNECTED_IP}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<!-- 
						<div class="select_area bold" style=" position: absolute; right: 250px; top: 0px;">
							<div class="radio_area">
								<input type="radio" name="rdo_status" id="rdo001" value="E" checked="checked"><label for="rdo001">승인</label>
								<input type="radio" name="rdo_status" id="rdo002" value="D"><label for="rdo002">반려</label>
								<input type="radio" name="rdo_status" id="rdo003" value="W"><label for="rdo003">대기</label>
							</div>
						</div>
 -->
						<div class="select_area bold" style="position:absolute; font-size:.75vw; right: 9vw; width: 13vw; top:0; ">
							<div class="radio_area" style="margin:0;">
								<input type="date" id="fromDate" style="text-align: center; width:6vw; padding-right:16px; font-size:.6vw;" readonly="readonly" value="${fromDate}" >
								<span style="width: 8%;">~</span>
								<input type="date" id="toDate" style="text-align: center; width:6vw; padding-right:16px; font-size:.6vw;" readonly="readonly" value="${toDate}" >
							</div>
						</div>
						<div class="list_sch">
							<div class="sch_area">
								<button class="btn_new" type="button" id="btnExceptionAppr"> 예외 확인 </button>
							</div>
						</div>
					</div>
					<div class="left_box2 minW minH" style="overflow: hidden; max-height: 732px;height: 732px;">
	   					<table id="targetGrid"></table>
		   				<div id="targetGridPager"></div>
					</div>
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->

<!-- 팝업창 시작 -->
<div id="exceptionReasonPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px;">
		<div class="popup_top">
			<h1>예외 등록 사유</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 450px;">
				<!-- <h2>세부사항</h2>  -->
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>요청자</th>
							<td><input type="text" id="reg_user_name" value="" class="edt_sch" style="border: 0px solid #cdcdcd;" readonly></td>
						</tr>
						<tr>
							<th>결재자</th>
							<td><input type="text" id="ok_user_name" value="" class="edt_sch" style="border: 0px solid #cdcdcd;" readonly></td>
						</tr>
						<tr>
							<th>요청일자</th>
							<td><input type="text" id="regdate" value="" class="edt_sch" style="border: 0px solid #cdcdcd;" readonly></td>
						</tr>
						<tr>
							<th>승인일자</th>
							<td><input type="text" id="okdate" value="" class="edt_sch" style="border: 0px solid #cdcdcd;" readonly></td>
						</tr>
						<tr>
							<th>의견</th>
							<td>
								<textarea id="reason" class="edt_sch" style="border: 0px solid #cdcdcd; width: 380px; height: 200px; margin-top: 5px; margin-bottom: 5px; resize: none;" readonly></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="btnCancel">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 종료 -->

<!-- 팝업창 시작 -->
<div id="exceptionApprPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px;">
		<div class="popup_top">
			<h1>예외 신청 확인</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 150px;">
				<!-- <h2>세부사항</h2>  -->
				<table class="popup_tbl">
					<colgroup>
						<col width="100%">
					</colgroup>
					<tbody>
						<tr style="height: 100px;">
							<td style="text-align: center;">
								<input type="radio" name="rdoAppr" id="rdoAppr1" value="E" checked><label for="rdoAppr1" class="magin_r1" style="margin-right: 100px;">승인</label>
								<input type="radio" name="rdoAppr" id="rdoAppr2" value="D"><label for="rdoAppr2">반려</label>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="btnSaveAppr">저장</button>
				<button type="button" id="btnCancelAppr">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 종료 -->

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

	$("#hostSelect, #userSelect").change(function(e){

		fn_search();
	});

	
	var gridWidth = $("#targetGrid").parent().width();
	$("#targetGrid").jqGrid({
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['경 로','호스트','신청자','요청일자','사유','IDX','PID','GROUP_ID','TARGET_ID','HASH_ID',
				'REG_USER_NO','OK_USER_NO','OK_USER_NAME','승인일자','상태'],
		colModel: [    
			{ index: 'PATH', 			name: 'PATH', 				width: 500, align: 'left'},
			{ index: 'TARGET_NAME', 	name: 'TARGET_NAME', 		width: 200, align: 'left'},
			{ index: 'REG_USER_NAME',	name: 'REG_USER_NAME', 		width: 150, align: 'center'},
			{ index: 'REGDATE',			name: 'REGDATE', 			width: 180, align: 'center'},
			{ index: 'REASON',			name: 'REASON', 			width: 400,},
			{ index: 'IDX', 			name: 'IDX', 				width: 100, hidden:true},
			{ index: 'PID', 			name: 'PID', 				width: 100, hidden:true},
			{ index: 'GROUP_ID',		name: 'GROUP_ID',			width: 100, hidden:true},
			{ index: 'TARGET_ID',		name: 'TARGET_ID', 			width: 100, hidden:true},
			{ index: 'HASH_ID',			name: 'HASH_ID', 			width: 100, hidden:true},
			{ index: 'REG_USER_NO',		name: 'REG_USER_NO', 		width: 100, hidden:true},
			{ index: 'OK_USER_NO',		name: 'OK_USER_NO', 		width: 100, hidden:true},
			{ index: 'OK_USER_NAME',	name: 'OK_USER_NAME', 		width: 200, hidden:true},
			{ index: 'OKDATE',			name: 'OKDATE', 			width: 180, hidden:true},
			{ index: 'APPROVAL_STATUS',	name: 'APPROVAL_STATUS', 	width: 80, align: 'center', formatter:'select',
				editoptions:{value:{'W':'대기','E':'완료','D':'반려'}}, hidden:true}				
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

	$("#btnExceptionAppr").on("click", function(e) {
		
		var exceptionApprList = new Array();
		var selRows = $("#targetGrid").getGridParam('selarrrow');
		for (var i = 0; i < selRows.length; i++) {
			exceptionApprList.push($("#targetGrid").jqGrid('getCell', selRows[i], 'IDX'));
		}

		if (exceptionApprList.length == 0) {
			alert("확인할 항목을 선택하십시요");
			return;
		}
		
		$("#exceptionApprPopup").show();
	});

	$("#btnCancelAppr").on("click", function(e) {
		$("#exceptionApprPopup").hide();
	});

	$("#btnSaveAppr").on("click", function(e) {

		var exceptionApprList = new Array();
		var apprType = $('input:radio[name="rdoAppr"]:checked').val();
		
		var selRows = $("#targetGrid").getGridParam('selarrrow');
		for (var i = 0; i < selRows.length; i++) {
			exceptionApprList.push($("#targetGrid").jqGrid('getCell', selRows[i], 'IDX'));
		}
		
		var postData = {exceptionApprList : exceptionApprList, apprType : apprType};
		console.log(postData);

		$.ajax({
			type: "POST",
			url: "/exception/registExceptionAppr",
			async : false,
			data : postData,
		    success: function (result) {
		    	fn_search();
				alert("예외 등록을 삭제하였습니다.");
				$("#exceptionApprPopup").hide();
		    },
		    error: function (request, status, error) {
		    	alert("예외 등록 삭제에 실패 하였습니다.");
		        console.log("ERROR : ", error);
		    }
		});
	});
	
	
});

function fn_search() {
	var postData = {
		target_id : $("#hostSelect").val(),
		user_no : $("#userSelect").val(),
		fromDate : $('#fromDate').val(),
		toDate : $('#toDate').val()
	};
	
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/exception/selectExceptionApprList", postData : postData, datatype:"json" }).trigger("reloadGrid");	
}

function fnSetException(rowID) {

	$("#reg_user_name").val($("#targetGrid").jqGrid('getCell', rowID, 'REG_USER_NAME'));
	$("#ok_user_name").val($("#targetGrid").jqGrid('getCell', rowID, 'OK_USER_NAME'));
	$("#regdate").val($("#targetGrid").jqGrid('getCell', rowID, 'REGDATE'));
	$("#okdate").val($("#targetGrid").jqGrid('getCell', rowID, 'OKDATE'));
	$("#reason").val($("#targetGrid").jqGrid('getCell', rowID, 'REASON'));
	$("#exceptionReasonPopup").show();
}
</script>

</body>
</html>
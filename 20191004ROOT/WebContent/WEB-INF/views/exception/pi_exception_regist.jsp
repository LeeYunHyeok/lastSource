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
						<p class="location">예외처리 관리 > 검출 관리</p>
					</div>
					<div class="grid_top">
						<h3>검출 리스트</h3>
						
						<div class="sch_left" style="position: absolute; top: 0; width: 15vw; right: 43vw; font-size:.75vw">
							경로 : <input type="text" id="searchLocation" value="" class="edt_sch" style="width: 12vw;">
							<button id="btnSearch" class="btn_sch" style="right:1vw;">검색</button>
						</div>
						<div class="select_area bold" style=" position: absolute; right: 10vw; font-size:.75vw; top: 0;">
							Host : 
							<select id="hostSelect" name="hostSelect" style="width:16vw; min-width: 15vw; font-size:0.75vw">
								<c:forEach items="${targetList}" var="targetList">
				   				<option value="${targetList.TARGET_ID}"<c:if test="${targetList.TARGET_ID == target_id}">selected</c:if>>${targetList.AGENT_NAME} - ${targetList.AGENT_CONNECTED_IP}</option>
								</c:forEach>
							</select>	
						</div>
						<div class="list_sch">
							<div class="sch_area">
								<button type="button" name="button" class="btn_new" id="btnExceptionRegist">예외 등록</button>
								<button type="button" name="button" class="btn_new" id="btnDeletionRegist">삭제 등록</button>
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

<!-- 팝업창 시작 예외 등록 사유 -->
<div id="exceptionReasonPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 510px;">
		<div class="popup_top">
			<h1>예외 등록 사유</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 390px;">
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
							<td class="btn_area" style="padding: 0px 0px 0px 20px; text-align: left;">
								<input type="text" id="ok_user_name" value="" class="edt_sch" style="width: 280px; border: 0px solid #cdcdcd;" readonly>
								<button type="button" id="btnUserSelectPopup" style="margin-bottom: 0px; background: #7b6a5a;">결재자 지정</button>
								<input type="text" id="ok_user_no" value="" class="edt_sch" style="border: 0px solid #cdcdcd; display:none;">
							</td>
						</tr>
						<tr>
							<th>요청일자</th>
							<td><input type="text" id="regdate" value="" class="edt_sch" style="border: 0px solid #cdcdcd;" readonly></td>
						</tr>
						<tr>
							<th>의견</th>
							<td>
								<textarea id="reason" class="edt_sch" placeholder="예외처리 사유를 입력하세요" style="border: 0px solid #cdcdcd; width: 380px; height: 200px; margin-top: 5px; margin-bottom: 5px; resize: none;"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="btnSave">저장</button>
				<button type="button" id="btnCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 종료 -->

<!-- 팝업창 시작 결재자 지정 -->
<div id="userSelect" class="popup_layer" style="display:none;">
	<div class="popup_box" style="height: 200px;">
		<div class="popup_top">
			<h1>결재자 지정</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 450px;">
  				<table id="userGrid"></table>
   				<div id="userGridPager"></div>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="btnUserSelect">선택</button>
				<button type="button" id="btnUserCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 종료 -->

<!-- 팝업창 시작 개인정보검출 상세정보 -->
<%
String browser = "";
String userAgent = request.getHeader("User-Agent");
if (userAgent.indexOf("Trident") > 0 || userAgent.indexOf("MSIE") > 0) {
%>
	<div id="taskWindow" style="position:absolute; left: 650px; top: 350px; touch-action: none; width: 50%; height: 365px; z-index: 999; display:none; min-width: 30%; min-height: 200px;" class="ui-widget-content">
	<table class="mxWindow" style="width: 100%; height: 100%;">
	<tbody>
		<tr>
			<td class="mxWindowTitle" style="background: #1898D2; cursor: grab; touch-action: none;">
				<table style="width: 100%; height: 36px;">
					<colgroup>
						<col width="*">
						<col width="30px">
					</colgroup>
					<tr>
						<td style="color: #ffffff; text-align: left; padding-left: 20px;"><h2>개인정보검출 상세정보</h2>
						</td>
						<td style="display: inline-block; padding-top: 6px; cursor: default;">
							<img src="${pageContext.request.contextPath}/resources/assets/images/close.gif" title="Close" id="taskWindowClose">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="mxWindowPane">
				<div class="mxWindowPane" style="width: 100%;height: 100%;">
					<table border="1" style="width: 100%;height: 100%;">
					<tbody>
						<tr>
							<td id="matchCount" style="width: 335px; min-width: 335px; max-width: 335px; height: 50px; padding: 5px;">&nbsp;</td>
							<td style="width: 100%; height: 100%;" rowspan="2">
								<div id="bodyContents" style="background: white; overflow:scroll; height: 315px; padding: 5px 5px;">&nbsp;</div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="matchData" style="background: white; overflow:scroll; height: 265px; padding: 5px">&nbsp;</div>
							</td>
						</tr>
					</tbody>
					</table>
				</div>
			</td>
		</tr>
	</tbody>
	</table>
</div>
<%
} else {
%>
<div id="taskWindow" style="position:absolute; left: 650px; top: 350px; touch-action: none; width: 50%; height: 300px; z-index: 999; display:none; min-width: 30%; min-height: 200px;" class="ui-widget-content">
	<table class="mxWindow" style="width: 100%; height: 100%;">
	<tbody>
		<tr>
			<td class="mxWindowTitle" style="background: #1898D2; cursor: grab; touch-action: none;">
				<table style="width: 100%; height: 100%;">
					<colgroup>
						<col width="*">
						<col width="30px">
					</colgroup>
					<tr>
						<td style="color: #ffffff; text-align: left; padding-left: 20px;"><h2>개인정보검출 상세정보</h2>
						</td>
						<td style="display: inline-block; padding-top: 6px; cursor: default;">
							<img src="${pageContext.request.contextPath}/resources/assets/images/close.gif" title="Close" id="taskWindowClose">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="mxWindowPane">
				<div class="mxWindowPane" style="width: 100%;height: 100%;">
					<table border="1" style="width: 100%;height: 100%;">
					<tbody>
						<tr>
							<td id="matchCount" style="width: 35%; height: 50px; padding: 5px;">&nbsp;</td>
							<td style="width: 65%; height: 100%;" rowspan="2">
								<div id="bodyContents" style="overflow-y:auto;height: 100%; padding: 5px 5px;">&nbsp;</div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="matchData" style="overflow-y:auto;height: 100%; padding: 5px">&nbsp;</div>
							</td>
						</tr>
					</tbody>
					</table>
				</div>
			</td>
		</tr>
	</tbody>
	</table>
</div>
<%
}
%>
<!-- 팝업창 종료 -->

	<%@ include file="../../include/footer.jsp"%>

<script type="text/javascript"> 

function fnSearchFindSubpath() {

	var postData = {target_id : $("#hostSelect").val(), location : $("#searchLocation").val()};
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/exception/selectFindSubpath", postData : postData, datatype:"json",treedatatype : 'json' }).trigger("reloadGrid");
} 

$(document).ready(function () {
	
	if("${dashclick}" != null && "${dashclick}" != ""){
		$("#hostSelect").val("${dashclick}").prop("selected","selected");
	}

	$("#userGridPager_left").css("width", "10px");
	$("#userGridPager_right").css("display", "none");

	var boss_user_name = "${teamManager.USER_NAME}"; 
	var boss_jikguk = "${teamManager.JIKGUK}"; 
	var boss_user_no = "${teamManager.USER_NO}";
	
	$("#ok_user_no").val(boss_user_no);
	$("#ok_user_name").val(boss_user_name + " " + boss_jikguk + " (" + boss_user_no + ")");
	
	$("#btnSearch").click(function(e){
				
		fnSearchFindSubpath();
	});
	
	$("#searchLocation").keyup(function(e){

		if (e.keyCode == 13) {
			fnSearchFindSubpath();
		}
	});

	$("#hostSelect").change(function(e){
		
		$("#searchLocation").val("");		
		fnSearchFindSubpath();
	});

	$("#taskWindow").draggable({
		containment: '.content',
   	 	cancel : '.mxWindowPane'
   	});

	var agent = navigator.userAgent.toLowerCase();
	if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
	}
	else {
		$("#taskWindow").resizable({
	   	});
	}

	$("#taskWindowClose").click(function(e){
		$("#taskWindow").hide();
	});
	$(".content").click(function(e){
		$("#taskWindow").hide();
	});
	$("#taskWindow").click(function(e){
		e.stopPropagation();
	});
	
	$("#btnSave").on("click", function(e) {

		var exception = "N";
		var exceptionList = new Array(); 
	    $('[name=gridChk]').each(function(i, element){

		    if (element.checked) {
			    var rowID = $(element).data("rowid");
			    var status = $("#targetGrid").jqGrid('getCell', rowID, 'STATUS');
			    if ((status == "E") || (status == "W")) {
			    	exception = "Y";
				}
			    exceptionList.push(element.value);
		    }
	    });
	    if (exception == "Y") {
	    	alert("기 예외 등록된 항목이 선택 되었습니다.");
	    	return;
	    }
	    
	    if (exceptionList.length == 0) {
		    alert("예외 처리 항목을 선택하세요.");
		    return;
		}

		var postData = {exceptionList : exceptionList, reason : $("#reason").val(), ok_user_no : $("#ok_user_no").val()};

		$.ajax({
			type: "POST",
			url: "/exception/registException",
			async : false,
			data : postData,
		    success: function (result) {
			    if (result.resultCode != "0") {
			    	alert("예외처리 등록을 실패 하였습니다.");
			    	return;
				}
				var postData = {target_id : $("#hostSelect").val()};
				$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/exception/selectFindSubpath", postData : postData, datatype:"json",treedatatype : 'json' }).trigger("reloadGrid");
				alert("예외처리를 등록 하였습니다.");
				$("#exceptionReasonPopup").hide();
		    },
		    error: function (request, status, error) {
		    	alert("예외처리 등록을 실패 하였습니다.");
		        console.log("ERROR : ", error);
		    }
		});
	});
		
	$("#btnCancel").on("click", function(e) {
		$("#exceptionReasonPopup").hide();
	});

	$("#btnUserSelectPopup").on("click", function(e) {
		$("#userSelect").show();

		if ($("#userGrid").width() == 0) {
			$("#userGrid").jqGrid({
				url: "<%=request.getContextPath()%>/user/selectTeamMember",
				datatype: "json",
			   	mtype : "POST",
			   	ajaxGridOptions : {
					type    : "POST",
					async   : true
				},
				colNames:['담당자','직위','사원번호'],
				colModel: [
					{ index: 'USER_NAME', 	name: 'USER_NAME', 	width: 180 },
					{ index: 'JIKGUK', 		name: 'JIKGUK', 	width: 180 },
					{ index: 'USER_NO', 	name: 'USER_NO', 	width: 180 }
				],
				id: "USER_NO",
				loadonce:true,
				viewrecords: true,
				width: 600,
				height: 280,
			   	autowidth: true,
				shrinkToFit: true,
				loadonce: true,
				rownumbers : false,
				rownumWidth : 75,	
				rowNum:25,
			   	rowList:[25,50,100],
				pager: "#userGridPager",
			  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
			  	},
			  	afterEditCell: function(rowid, cellname, value, iRow, iCol){
				},
			  	afterSaveCell : function(rowid,name,val,iRow,ICol){
		        },
			  	afterSaveRow : function(rowid,name,val,iRow,ICol){
		        },
				ondblClickRow: function(rowid,iRow,iCol) {
					var user_name = $(this).getCell(rowid, 'USER_NAME'); 
					var jikguk = $(this).getCell(rowid, 'JIKGUK'); 
					var user_no = $(this).getCell(rowid, 'USER_NO');
					
					$("#ok_user_no").val(user_no);
					$("#ok_user_name").val(user_name + " " + jikguk + " (" + user_no + ")");
					$("#userSelect").hide();
			    },
				loadComplete: function(data) {
			    },
			    gridComplete : function() {
			    }
			}).filterToolbar({
				  autosearch: true,
				  stringResult: true,
				  searchOnEnter: true,
				  defaultSearch: "cn"
			});	
			 
			$("#userGridPager_left").css("width", "10px");
			$("#userGridPager_right").css("display", "none");
		}
		else {
			$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/user/selectTeamMember", datatype:"json"}).trigger("reloadGrid");
		}
	});
	
	$("#btnUserCancel").on("click", function(e) {
		$("#userSelect").hide();
	});

	$("#btnUserSelect").on("click", function(e) {

		var rowid = $("#userGrid").getGridParam("selrow");
		var user_name = $("#userGrid").getCell(rowid, 'USER_NAME'); 
		var jikguk = $("#userGrid").getCell(rowid, 'JIKGUK'); 
		var user_no = $("#userGrid").getCell(rowid, 'USER_NO');
		
		$("#ok_user_no").val(user_no);
		$("#ok_user_name").val(user_name + " " + jikguk + " (" + user_no + ")");
		$("#userSelect").hide();
	});
	
	// btnUserSelect btnUserCancel 
	$("#btnExceptionRegist").on("click", function(e) {

		var exception = "N";
		var exceptionList = new Array(); 
	    $('[name=gridChk]').each(function(i, element){
		    if (element.checked) {
			    var rowID = $(element).data("rowid");
			    var status = $("#targetGrid").jqGrid('getCell', rowID, 'STATUS');
			    if ((status == "E") || (status == "W")) {
			    	exception = "Y";
				}
			    exceptionList.push(element.value);
		    }
	    });
	    
	    if (exception == "Y") {
	    	alert("기 예외 등록된 항목이 선택 되었습니다.");
	    	return;
	    }
	    
	    if (exceptionList.length == 0) {
		    alert("예외 처리 항목을 선택하세요.");
		    return;
		}
		
		var today = getToday();
		$("#reg_user_name").val("${memberInfo.USER_NAME}");
		$("#regdate").val(today.substring(0,4) + "-" + today.substring(4,6) + "-" + today.substring(6,8));
		$("#exceptionReasonPopup").show();
		$("#reason").focus();
	});

	$("#btnDeletionRegist").on("click", function(e) {
		var deletionList = new Array(); 
	    $('[name=gridChk]').each(function(i, element){
		    if (element.checked) {
			    var rowID = $(element).data("rowid");
			    var status = $("#targetGrid").jqGrid('getCell', rowID, 'DEL_STATUS');
			    if (status == "W") {
				    alert("기 삭제등록된 항목이 선택 되었습니다.");
				    return;
				}
			    deletionList.push(element.value);
		    }
	    });

		var postData = {deletionList : deletionList};
		$.ajax({
			type: "POST",
			url: "/exception/registDeletion",
			async : false,
			data : postData,
		    success: function (result) {
			    if (result.resultCode != "0") {
			    	alert("삭제처리 등록을 실패 하였습니다.");
			    	return;
				}
				var postData = {target_id : $("#hostSelect").val()};
				$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/exception/selectFindSubpath", postData : postData, datatype:"json",treedatatype : 'json' }).trigger("reloadGrid");
				alert("삭제처리를 등록 하였습니다.");
		    },
		    error: function (request, status, error) {
		    	alert("삭제처리 등록을 실패 하였습니다.");
		        console.log("ERROR : ", error);
		    }
		});
	});
	
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
	
	var postData = {target_id : $("#hostSelect").val()};
	var gridWidth = $("#targetGrid").parent().width();
	$("#targetGrid").jqGrid({
		url: "<%=request.getContextPath()%>/exception/selectFindSubpath",
		postData : postData,
		datatype: "json",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['','경 로','호스트','주민번호','외국인번호','여권번호','운전번호','계좌번호','카드번호','합계','예외등록상태','삭제등록상태','LEVEL','ID','PID'],
		colModel: [      
			{ index: 'CHK', 		name: 'CHK',		width: 30,  align: 'center', editable: true, edittype: 'checkbox', classes: 'pointer',
				editoptions: { value: "1:0" }, formatoptions: { disabled: false }, formatter: createCheckbox, sortable: false},
			{ index: 'SHORTNAME', 	name: 'SHORTNAME',	width: 550, align: 'left', },
			{ index: 'OWNER',		name: 'OWNER',		width: 200, align: 'center'},
			{ index: 'TYPE1',		name: 'TYPE1', 		width: 90,  align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}},
			{ index: 'TYPE2',		name: 'TYPE2', 		width: 90,  align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}},
			{ index: 'TYPE3',		name: 'TYPE3', 		width: 90,  align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}},
			{ index: 'TYPE4',		name: 'TYPE4', 		width: 90,  align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}},
			{ index: 'TYPE5',		name: 'TYPE5', 		width: 90,  align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}},
			{ index: 'TYPE6',		name: 'TYPE6', 		width: 90,  align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}},
			{ index: 'TYPE',		name: 'TYPE', 		width: 100, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}},
			{ index: 'STATUS',		name: 'STATUS', 	width: 100, align: 'center', formatter:'select', editoptions:{value:{'E':'승인완료','D':'반려','W':'승인대기'}}},
			{ index: 'DEL_STATUS',	name: 'DEL_STATUS', width: 100, align: 'center', formatter:'select', editoptions:{value:{'':'미등록','W':'등록'}}},
			{ index: 'ID', 			name: 'ID', 		width: 100, hidden:true},
			{ index: 'PID', 		name: 'PID', 		width: 100, hidden:true},
			{ index: 'LEVEL',		name: 'LEVEL', 		width: 100, align: 'center', hidden:true}
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
		treeGrid:true,
		treeGridModel :"adjacency",
        ExpandColumn :"SHORTNAME",
        ExpandColClick: true,
        //caption: "Tree Grid Example",
        treeReader :{
			level_field :"LEVEL",
			parent_id_field :"PID",
			leaf_field : "LEAF",
			expand_field : "EXPAND"
		},
		jsonReader : {
			id : "ID"
		},
		onCellSelect: function(rowid,icol,cellcontent,e) {

			$("#taskWindow").hide();
			if (icol != 1) return;
			
	  		e.stopPropagation();
	  		var isLeaf = $(this).jqGrid('getCell', rowid, 'LEAF');

			if (isLeaf == "true") {
				var id = $(this).jqGrid('getCell', rowid, 'ID');
				var postData = {id : id};
				$.ajax({
					type: "POST",
					url: "/exception/getMatchObjects",
					async : true,
					data : postData,
				    success: function (resultMap) {
					    if (resultMap.resultCode != "0") {
					    	alert("Fail : " + resultMap.resultMessage);
						}

					    var totalCnt = 0;
					    var bodyContents = "";
					    var path = resultMap.resultData.path.split("#");
					    bodyContents += path[path.length -1] + "</br>";
						//bodyContents += resultMap.resultData.path.replace("file://","") + "</br>";
						var metas = resultMap.resultData.metas;
						metas.sort(function(a, b) { // 오름차순
						    return a.label < b.label ? -1 : a.label > b.label ? 1 : 0;
						});

						for (var i = 0; i < metas.length; i++) {
							var meta = metas[i];
							
							if (meta.is_aggregate == true) {
								var tmp = Number(meta.value);
								totalCnt = totalCnt + tmp;
	 							bodyContents += meta.label + " : " + meta.value.format() + "</br>";
							}
							else {
	 							bodyContents += meta.label + " : " + meta.value + "</br>";
							}
						}

						bodyContents += "</br>";
						if (!isNull(resultMap.resultData.omitted)) {
							var omitted = resultMap.resultData.omitted[0];
							bodyContents += omitted.length.format() + " bytes omitted</br>";
						}

						var chunks = resultMap.resultData.chunks;
						for (var i = 0; i < chunks.length; i++) {
							var chunk = chunks[i];
							bodyContents += chunk.content.split("\n").join("</br>") + "</br>";
						}
						$("#bodyContents").html(bodyContents);
						/*
						신용카드 : Type1 - like 아래 이외의 기타...
						주민등록번호 : Type2 - like South Korean RRN
						외국인등록번호 : Type3 - like South Korean Foreigner Number
						여권번호 : Type4 - like South Korean Passport
						운전면허 번호 : Type5 - like South Korean Driver License Number
						전화/휴대폰 : Type6 - like South Korean Phone Number
						사업자등록번호 : Type7 - like South Korean Taxpayer Identification Number
						법인등록번호 : Type8 - like South Korean Corporation Registration Number
						계좌번호 : Type9 - like Account Number
						*/
					    var matchData = "National ID (" + resultMap.resultData.matches.length + ")</br>";
						var matchs = resultMap.resultData.matches;						
						var matchType = ["주민등록번호","외국인등록번호","여권번호","운전면허 번호","전화/휴대폰","사업자등록번호","법인등록번호","계좌번호","신용카드"];
						var matchCount = [0,0,0,0,0,0,0,0,0];
						var matchContents = ["","","","","","","","",""];
						
						for (var i = 0; i < matchs.length; i++) {
							var matchIndex = -1;
							var data_type = matchs[i].data_type;
							if (data_type.indexOf("South Korean RRN") > -1) matchIndex = 0;
							else if (data_type.indexOf("South Korean Foreigner Number") > -1) matchIndex = 1;
							else if (data_type.indexOf("South Korean Passport") > -1) matchIndex = 2;
							else if (data_type.indexOf("South Korean Driver License Number") > -1) matchIndex = 3;
							else if (data_type.indexOf("South Korean Phone Number") > -1) matchIndex = 4;
							else if (data_type.indexOf("South Korean Taxpayer Identification Number") > -1) matchIndex = 5;
							else if (data_type.indexOf("South Korean Corporation Registration Number") > -1) matchIndex = 6;
							else if (data_type.indexOf("Account Number") > -1) matchIndex = 7;
							else  matchIndex = 8;

							matchCount[matchIndex] = matchCount[matchIndex] + 1; 
							matchContents[matchIndex] = matchContents[matchIndex] + matchs[i].content + "</br>";

							// 1000건이 넘어가면 속도가 느려져서 일단 막음
							// Recon은 Over 형태로 표기
							if (i > 999) break;
						}

						if (totalCnt == 1) $("#matchCount").html(totalCnt.format() + " Match");
						else $("#matchCount").html(totalCnt.format() + " Matches");
						
						var matchData = "<ul>";
						for (var i = 0; i < matchType.length; i++) {
							if (matchCount[i] == 0) continue;
							matchData += "<li class='matchTypeList'><a href='javascript:void(0)'><img style='margin-right: 3px; margin-bottom: 3px;' src='${pageContext.request.contextPath}/resources/assets/images/arrow_deactive.png'>";
							if (matchs.length > 1000)
								matchData += matchType[i] + "(" + matchCount[i].format() + "+)" + "</a>";
							else 
								matchData += matchType[i] + "(" + matchCount[i].format() + ")" + "</a>";
								
							matchData += "<ul style='padding: 0px 3px 3px 3px; display:none'><li style='margin-left: 20px;'>" + matchContents[i] + "</li></ul></li>";
						} 

						if (totalCnt > 1000) {
							matchData += "<li style='padding-top: 3px;'><img style='vertical-align: middle;padding-left: 5px;' src='${pageContext.request.contextPath}/resources/assets/images/alert.png'>";
							matchData += "<span style='padding-left: 12px !important;'>+" + (totalCnt - 1000).format() +" more</span></li>";
						}
						matchData += "</ul>"
							
						$("#matchData").html(matchData);
						$(".matchTypeList>a").click(function() {
							if ($(this).next('ul').is(':visible')) {
								$(this).children("img").attr("src", '${pageContext.request.contextPath}/resources/assets/images/arrow_deactive.png');
								$(this).next('ul').hide();
							} else {
								$(this).children("img").attr("src", '${pageContext.request.contextPath}/resources/assets/images/arrow_active.png');
								$(this).next('ul').show();
							}
						});

						$("#taskWindow").show();
				    },
				    error: function (request, status, error) {
						alert("Recon Server에 접속할 수 없습니다.");
				    }
				});
			}
			else {
				$("#taskWindow").hide();
			}
	  	},
		loadComplete: function(data) {
	    }
	});

});

</script>

</body>
</html>
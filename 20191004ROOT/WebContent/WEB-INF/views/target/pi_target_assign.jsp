<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>

 
		<!-- 업무타이틀(location)
		<div class="banner">
			<div class="container">
				<h2 class="ir">업무명 및 현재위치</h2>
				<div class="title_area">
					<h3>타겟 관리</h3>
					<p class="location">타겟 관리 > 타겟 담당자 관리</p>
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
						<p class="location">타겟관리 > 타겟담당자 관리</p>
					</div>
					<div class="left_area2">
						<h3>서버 리스트</h3>
						<div class="left_box2 minH" style="overflow: hidden; max-height: 732px;height: 732px;">
							<div class="search_area bold">
								<input type="text" id="txt_host" value="" style="width: 300px" placeholder="호스트 이름을 입력하세요.">
								<button type="button" id="btn_search" style="right: 5px;">검색</button>
							</div>
		   					<table id="targetGrid"></table>
		   					<div id="targetGridPager"></div>
						</div>
					</div>

					<div class="grid_top" style="margin-left: 350px;">
						<table style="width: 100%;">
							<tr>
								<td><h3>서버 담당자</h3></td>
								<td class="btn_area" style="text-align: right; padding: 0px; width: 29vw;">
									<button type="button" id="btnUpload" style="margin: 0px; padding: 0 30px;">업로드</button>
									<button type="button" id="btnDownloadExel" style="margin: 0px; padding: 0 30px;">다운로드</button>
									<button type="button" id="btnRegistTargetUser" style="margin: 0px; padding: 0 30px;"> 담당자등록 </button>
									<input class=""  type="file" name="uploadFile" id="uploadFile" onchange="uploadSave();" style="display:none;">
								</td>
							</tr>
						</table> 
						<div class="left_box2 minW_2" style="overflow: hidden; max-height: 732px;height: 732px;">
		   					<table id="userGrid"></table>
		   					<div id="userGridPager"></div>
		   				</div>
	   				</div>
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->

	<%@ include file="../../include/footer.jsp"%>
	
	
<script type="text/javascript">

var oGrid = $("#userGrid");

function createRadio(cellvalue, options, rowObject) {
	var value = options['rowId'];
    var str = '<input type="radio" name="gridRadio" value="' + value + '">';
    return str;
}

function createCheckbox(cellvalue, options, rowObject) {
	var rowID = options['rowId'];
	var checkboxID = "gridChk" + rowID;
	
	if (rowObject['CHK'] == "1")
		return "<input type='checkbox' id='" + checkboxID + "' value='" + rowID + "' onchange='onGridChkboxChange( event )' checked>"; 
	else 
		return "<input type='checkbox' id='" + checkboxID + "' value='" + rowID + "' onchange='onGridChkboxChange( event )'>";
}

function onGridChkboxChange(e) {
	var e = e || window.event;
	var target = e.target || e.srcElement;

	if (target.checked) {
		$("#userGrid").jqGrid('setCell', target.value, 'CHK', "1");
		$("#userGrid").jqGrid('setCell', target.value, 'CHKBOX', "1");
	}
	else { 
		$("#userGrid").jqGrid('setCell', target.value, 'CHK', "0");
		$("#userGrid").jqGrid('setCell', target.value, 'CHKBOX', "0");
	}
}

$(document).ready(function () {

	var gridWidth = $("#targetGrid").parent().width();
	var gridHeight = 592; //$("#targetGrid").parent().height();
	$("#targetGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['','호스트 이름','아이피','TARGET_ID'],
		colModel: [      
			{ index:'CHK', 			name: 'CHK', 		width:30, 	align: 'center',	editable:true, 	edittype:'radio', 	formatter:createRadio},
			{ index: 'AGENT_NAME', 	name: 'AGENT_NAME', width: 150},
			{ index: 'AGENT_CONNECTED_IP', 	name: 'AGENT_CONNECTED_IP', width: 100, align: 'center' },
			{ index: 'TARGET_ID', 	name: 'TARGET_ID', 	width: 500, hidden : true }
		],
		loadonce: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: gridHeight,
	   	autowidth: false,
		shrinkToFit: false,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 75, // 행번호 열의 너비	
		rowNum:25,
	   	rowList:[25,50,100],			
		pager: "#targetGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {
			$(".clearsearchclass").click();
			$('input:radio[name=gridRadio]:input[value=' + rowid + ']').prop("checked", true);
			
	  		var postData = {target : $(this).jqGrid('getCell', rowid, 'TARGET_ID')};
			$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectTargetUser", postData : postData, datatype:"json" }).trigger("reloadGrid");
	  	},
		loadComplete: function(data) {
			$("input[name=gridRadio]").change(function() {
				$("#targetGrid").setSelection($(this).val());
			});
			$(this).setSelection(1);
	    },
	    gridComplete : function() {
	    }
	});

	var gridWidth = $("#userGrid").parent().width();
	var gridHeight = 632;
	$("#userGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['','담당자','직위','사원번호','부서명','CHK','CHKOLD'],
		colModel: [
			{ index: 'CHKBOX', 		name: 'CHKBOX',		width: 120,  align: 'center', editable: true, edittype: 'checkbox', 
				editoptions: { value: '1:0' }, formatoptions: { disabled: false }, formatter: createCheckbox, stype: 'select',
				searchoptions: { sopt: ['eq'], value: ':전체;1:선택;0:미선택' }, exportcol:false
			},
			{ index: 'USER_NAME', 	name: 'USER_NAME', 	width: 200, editable: true },
			{ index: 'JIKGUK', 		name: 'JIKGUK', 	width: 200 },
			{ index: 'USER_NO', 	name: 'USER_NO', 	width: 200 },
			{ index: 'TEAM_NAME', 	name: 'TEAM_NAME', 	width: 200 },
			{ index: 'CHK', 		name: 'CHK', 		width: 200, hidden : true },
			{ index: 'CHKOLD', 		name: 'CHKOLD', 	width: 200, hidden : true }
		],
		id: "USER_NO",
		loadonce:true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: gridHeight - 45,
		loadonce: true, // this is just for the demo
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 75, // 행번호 열의 너비	
		rowNum:25,
	   	rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		pager: "#userGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
	  	},
	  	afterEditCell: function(rowid, cellname, value, iRow, iCol){
            //I use cellname, but possibly you need to apply it for each checkbox       
			if (cellname == 'CHKBOX'){
			    $("#userGrid").saveCell(iRow,iCol);
			}   
		},
	  	afterSaveCell : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
	  	afterSaveRow : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
		loadComplete: function(data) {
			//console.log(data);
	    },
	    gridComplete : function() {
	    }
	}).filterToolbar({
		  autosearch: true,
		  stringResult: true,
		  searchOnEnter: true,
		  defaultSearch: "cn"
	});

	$("#targetGridPager_left").css("width", "10px");
	$("#targetGridPager_right").css("display", "none");
	// 버튼 Action 설정
	$("#btnRegistTargetUser").click(function() {

		// 선택된 사용자 저장
		var idx = 0;		
		var userList = [];
		var userData = $("#userGrid").jqGrid('getGridParam', 'data');

		for (var i = 0; i < userData.length; i++) {
			var chk = userData[i].CHK;
			var chkold = userData[i].CHKOLD;
			// 담당자로 선택되거나 해제 확인
			if (chk != chkold) {
				var userAssign = {};
				userAssign.userNo 		= userData[i].USER_NO;
				userAssign.chk 			= userData[i].CHK;
				userList[idx++] = userAssign;	
			}
		}

		if (isNull(userList)) {
			alert("변경된 정보가 없습니다.");
			return;
		}
		// 선택된 TargetID 저장
		var rowid = $("#targetGrid").getGridParam("selrow");
		var target = $("#targetGrid").jqGrid('getCell', rowid, 'TARGET_ID');
		var targetName = $("#targetGrid").jqGrid('getCell', rowid, 'AGENT_NAME');
		var postData = {
				target : target,
				userList : JSON.stringify(userList)
		};

		var message = "Server-" + targetName + "의 담당자를 지정하시겠습니까?";
		if (confirm(message)) {
			$.ajax({
				type: "POST",
				url: "/target/registTargetUser",
				async : false,
				data : postData,
			    success: function (resultMap) {
			        if (resultMap.resultCode != 0) {
				        alert("FAIL : " + resultMap.resultMessage);
			        	console.log(resultMap);
			        	return;
				    }
				    // chk와 chkold 바까 줌.				    
					var userData = $("#userGrid").jqGrid('getGridParam', 'data');
			
					for (var i = 0; i < userData.length; i++) {
						$("#userGrid").jqGrid('setCell', userData[i]._id_, 'CHKOLD', userData[i].CHK);
					}
					
			        alert(targetName + "의 담당자가 지정되었습니다.");
			    },
			    error: function (request, status, error) {
					alert("Server Error : " + error);
			        console.log("ERROR : ", error);
			    }
			});
		}
    });

	$('#btn_search').click(function() {
		var postData = {host : $("#txt_host").val()};
		$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/target/pi_target_list", postData : postData, datatype:"json" }).trigger("reloadGrid");
	});

	$('#btn_search').click();
	
	$("#btnDownloadExel").click(function(){
		downLoadExcel();
	});

    $("#btnUpload").click(function() {
    	event.preventDefault();
    	$('#uploadFile').click();
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

// 그리드 상에 체크박스 체크된거 어떻게 다운로드 받을지 결정해야함 
// 설계서상에는 서버리스트도 나오게 해달라고 요구함
// 서버이름, 담당자,직위, 사원번호, 부서명 등

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
        fileName : "서버_담당자_리스트_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        returnAsString : false
    })
}

var uploadSave = function() { 
	// IE는 input file에 빈컨 넣어도 탄다.
	if ($('input[type=file]').val() == "") {
		return;
	}

	var formData = new FormData();
	formData.append('file', $("input[name=uploadFile]")[0].files[0]);

	$("#btnUpload").prop("disabled", true);
	$("#jqgrid").jqGrid("clearGridData", true);
	
	$.ajax({
	    type: "POST",
	    enctype: 'multipart/form-data',
	    url: "<%=request.getContextPath()%>/target/targetManagerUpload",
	    data: formData,
	    processData: false,
	    contentType: false,
	    cache: false,
	    timeout: 600000,
	    success: function (message) {	
	        $("#btnUpload").prop("disabled", false);
	        console.log(message);
			if (message.resultCode != 0) {
				alert(message.resultMessage);
			}
			else {
			}
	    },
	    error: function (e) {
	    	alert("업로드 에러 입니다.</br>관리자에게 문의 하세요");
	        console.log("ERROR : ", e);
	        $("#btnUpload").prop("disabled", false);
	    }
	});
	$('input[type=file]').val("");
}

</script>
	
</body>
</html>


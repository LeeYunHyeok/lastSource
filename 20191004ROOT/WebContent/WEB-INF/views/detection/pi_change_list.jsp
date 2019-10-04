<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../include/header2.jsp"%>

<!-- 검출관리 -->

<!-- section -->
<section>
	<!-- container -->
	<div class="container">
	<%@ include file="../../include/menu2.jsp"%>
		<!-- content -->
		<div class="content magin_t45">
			<div class="location_area">
				<p class="location">검출 관리 > 결재 관리 > 담당자 변경 리스트</p>
			</div>
			<div class="grid_top">
				<h3>담당자 변경 리스트 </h3>
                <div class="list_sch">
                    <div class="radio_area">
                        <input type="radio" name="rdo_requestStatus" id="rdo001" value="R" checked="checked"><label for="rdo001">요청</label>
                        <input type="radio" name="rdo_requestStatus" id="rdo002" value="C"><label for="rdo002">결재</label>
                        <button type="button" name="button" class="btn_new" id="btnSearch">Search</button>
                        <button type="button" name="button" class="btn_new" id="btnApprove">결재</button>
                    </div>
                </div>
                <table class="user_info approvalTh">
                    <caption>사용자정보</caption>
                    <tbody>
                        <tr>
                            <td style="text-align: center; background-color: #d6e4ed; width:4vw">업무구분</td>
                            <td style="width:10.5vw;">
                                <select id="selectList" name="selectList" style="width:9.7vw;">
                                    <option value="/approval/pi_search_list">정탐/오탐 리스트</option>
                                    <option value="/approval/pi_search_approval_list">정탐/오탐 결재 리스트</option>
                                    <!-- <option value="/excepter/pi_exception_list">경로 예외 리스트</option>
                                    <option value="/excepter/pi_exception_approval_list">경로 예외 결재 리스트</option> -->
                                    <option value="/change/pi_change_list" selected> 담당자 변경 리스트</option>
                                </select>
                            </td>
                            <td style="text-align: center; background-color: #d6e4ed; width:3vw;">상태</td>
                            <td style="width:5.7vw;">
                                <select id="statusList" name="statusList" style="width:4.9vw;">
                                    <option value="">전체</option>
                                    <option value="E">승인완료</option>
                                    <option value="D">반려</option>
                                    <option value="W" selected>승인대기</option>
                                </select>
                            </td>
                            <td style="text-align: center; background-color: #d6e4ed; width:4vw;">호스트</td>
                            <td style="width:9.5vw"><input type="text" style="width: 8.7vw; font-size: .85vw;" size="10" id="schOwner" placeholder="호스트명을 입력하세요"></td>
                            <td style="text-align: center; background-color: #d6e4ed; width:3vw;">이름</td>
                            <td style="width:8.9vw"><input type="text" style="width: 8vw; font-size: .85vw;" size="20" id="schFilename" placeholder="문서명을 입력하세요"></td>
                            <td style="text-align: center; background-color: #d6e4ed; width:6.5vw;">문서저장일</td>
                            <td style="width:17vw;">
                                <input type="date" id="fromDate" style="text-align: center; width:7.5vw; font-size:.6vw;" readonly="readonly" value="${fromDate}" >
                                <span style="width: 8%; margin-right: 3px;">~</span>
                                <input type="date" id="toDate" style="text-align: center; width:7.5vw; font-size:.6vw;" readonly="readonly" value="${toDate}" >
                            </td>
                        </tr>
                    </tbody>
                </table>
			</div>
			<div class="left_box2" style="overflow: hidden; max-height: 732px;height: 700px;">
  					<table id="changeGrid"></table>
  					<div id="changeGridPager"></div>
			</div>
		</div>
	</div>
	<!-- container -->
	
<!-- 팝업창 시작 결재 신청 확인 -->
<div id="approvePopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 510px;">
		<div class="popup_top">
			<h1 id="">결재 신청 확인</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 390px;">
				<!-- <h2>세부사항</h2>  -->
				<table class="popup_tbl">
					<colgroup>
						<col width="130">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th style="background-color: #f1f1f1;">결재</th>
								<td>
								<input type="radio" name="trueFalseChk" id="permit" value="" class="edt_sch" style=" border: 0px solid #cdcdcd;">승인
								<input type="radio" name="trueFalseChk" id="reject" value="" class="edt_sch" style="margin-left:120px; border: 0px solid #cdcdcd;">반려
								<input type="hidden" id="user_no" value="${memberInfo.USER_NO}">
							</td>  
						</tr>
						<tr>
							<th style="background-color: #f1f1f1;">사유</th>
						    <td style="padding:10px;">
								<textarea id="reason" class="edt_sch" style="border: 0px solid #cdcdcd; width: 100%; height: 280px; resize: none;"></textarea>
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
<!-- 팝업창 종료  -->

</section>
<!-- section -->
<%@ include file="../../include/footer2.jsp"%>
<script>

$(document).ready(function () {

    // 날짜 설정
    setSelectDate();

    $("#selectList").change(function () {
		var selected = $("#selectList").val();
		location.href=$("#selectList").val();
		selected.prop("selected","selected");
	});

    // 조회조건 담당자 inputbox Keydown Event (사용자 조회)
    $("#schOwner, #schFilename").keydown(function(e) {
        if(e.keyCode == 13) 
            fn_search();
    });

    // 검색
    $("#statusList").change(function() {
        fn_search();
    });

    // 검색
    $("#btnSearch").click(function() {
        fn_search();
    });

	var status = $('input[name="rdo_status"]:checked').val();
	var reqStatus = $('input[name="rdo_requestStatus"]:checked').val();

	if (reqStatus == "R"){
		$("#btnApprove").hide();
	} else {
		$("#btnApprove").show();
	}

	$("input:radio[name=rdo_requestStatus]").click(function() {

		var chgVal = $(this).val();

		if (chgVal == "R"){
			$("#btnApprove").hide();
		} 
		else {
			$("#btnApprove").show();
		}

		fn_search();
	});
	
	// 결재 버튼
	$("#btnApprove").click(function(e) {

		var bChange = false;
		var aChangeList = [];
		var selRows = $("#changeGrid").jqGrid('getGridParam', 'selarrrow');      //체크된 row id들을 배열로 반환
		var status;

		for (var i = 0; i < selRows.length; i++)
		{
			aChangeList.push($("#changeGrid").jqGrid('getCell', selRows[i], 'CHARGE_ID'));
			status = $("#changeGrid").jqGrid('getCell', selRows[i], 'APPROVAL_STATUS');

		    if (status == "D" || status == "E") {
		    	bChange = true;
			}
	   	}        

		if (bChange) {
	    	alert("이미 처리된 항목입니다.");
	    	return;
	    }

	    if (aChangeList.length == 0) {
		    alert("결재요청 항목을 선택하세요.");
		    return;
		}

		$("#approvePopup").show();
	});

	// 결재 요청 - 취소
	$("#btnCancel").on("click", function(e) {
		$("#reason").val('');
		$("#approvePopup").hide();
		$("input:radio[name=trueFalseChk]").prop("checked",false);
		$("input:radio[name=trueFalseChk]").val("");
	});

	// 결재 요청 - 저장
	$("#btnSave").click(function(e) {
		
		$("#reject").on("click", function(e) {
			$('input:radio[name=trueFalseChk]').val("D");
		});

		$("#permit").on("click", function(e) {
			$('input:radio[name=trueFalseChk]').val("E");
		});
		
		
		var trueFalseRadiobtnChk = $("input:radio[name=trueFalseChk]").val()
		if (! trueFalseRadiobtnChk){
			alert("처리방안을 결정하세요");
			
		} else {
			var aIdxList = [];
			var aTargetList = [];
			var aHashIdList = [];
			var aRowId = jQuery("#changeGrid").jqGrid('getGridParam', 'selarrrow');      //체크된 row id들을 배열로 반환
	
			for (var i = 0; i < aRowId.length; i++)
			{
				aIdxList.push($("#changeGrid").jqGrid('getCell', aRowId[i], 'IDX'));
				aTargetList.push($("#changeGrid").jqGrid('getCell', aRowId[i], 'TARGET_ID'));
				aHashIdList.push($("#changeGrid").jqGrid('getCell', aRowId[i], 'HASH_ID'));
		   	}
	
			var reason = $("#reason").val();
		    var apprType = $('input:radio[name=trueFalseChk]').val();
			console.log(apprType);
			
		    if (! apprType){
		    	alert("승인이나 반려를 선택하세요");
		    }
	
		    var ok_user_no = $("#user_no").val();
			var oPostDt = {};
			oPostDt["idxList"]     = aIdxList;
			oPostDt["targetList"]  = aTargetList;
			oPostDt["hashIdList"]  = aHashIdList;
			oPostDt["apprType"]    = apprType
			oPostDt["reason"]      = reason;
	
			var oJson = JSON.stringify(oPostDt);
	
			$.ajax({
				type: "POST",
				url: "${getContextPath}/change/updateChangeApproval",
				async : false,
				data : oJson,
				contentType: "application/json; charset=UTF-8",
			    success: function (result) {
	
				    if (result.resultCode != "0") {
				    	alert(result.resultCode + "처리 등록을 실패 하였습니다.");
				    	return;
					}
	
				    alert("처리를 등록 하였습니다.");
	
				    $("#changeGrid").setGridParam({
				    	url:"${getContextPath}/change/selectChangeList",
				    	postData: $("#changeGrid").getGridParam('postData'),
				    	datatype:"json"
			    	}).trigger("reloadGrid");
	
					$("#deletionRegistPopup").hide();
					$("input:radio[name=trueFalseChk]").prop("checked",false);
					$('input:radio[name=trueFalseChk]').val("");
					
					return;
			    },
			    error: function (request, status, error) {
			    	alert("처리 등록을 실패 하였습니다.");
			        console.log("ERROR : ", error);
					$("input:radio[name=trueFalseChk]").prop("checked",false);
					$('input:radio[name=trueFalseChk]').val("");
			        return;
			    }
			});
			
			$("#reason").val('');
			$("#approvePopup").hide();
			$("input:radio[name=trueFalseChk]").val("");
		}

		
	});
	
	loadJqGrid($("#changeGrid"));
});

function loadJqGrid(oGrid)
{
    // 담당자 변경 리스트
    var oPostDt = {};
    oPostDt["status"] = $("select[name='statusList']").val();
    oPostDt["request_status"]  = $('input[name="rdo_requestStatus"]:checked').val();
    oPostDt["owner"]    = $("#schOwner").val();
    oPostDt["filename"] = $("#schFilename").val();
    oPostDt["fromDate"] = $("#fromDate").val();
    oPostDt["toDate"]   = $("#toDate").val();

    oGrid.jqGrid({
        url: "${getContextPath}/change/selectChangeList",
        postData: oPostDt,
        datatype: "json",
        mtype: "POST",
        async: true,
        contentType: "application/json; charset=UTF-8",
        colNames:['','호스트','이름','기안자','결재자','신청일','결재일','상태','비고','반려 사유',"TARGET_ID","HASH_ID"],
        colModel: [
            { index: 'IDX',             name: 'IDX',                width: 30,  align: 'center', hidden:true},
            { index: 'HOST',            name: 'HOST',               width: 100, align: 'center'},
            { index: 'PATH',            name: 'PATH',               width: 200, align: 'left'},
            { index: 'REG_USER_NAME',   name: 'REG_USER_NAME',      width: 50, align: 'center'},
            { index: 'OK_USER_NAME',    name: 'OK_USER_NAME',       width: 50, align: 'center'},
            { index: 'REGDATE',         name: 'REGDATE',            width: 80, align: 'center'},   
            { index: 'OKDATE',          name: 'OKDATE',             width: 80, align: 'center'},   
            { index: 'APPROVAL_STATUS', name: 'APPROVAL_STATUS',    width: 50, align: 'center', formatter:'select', editoptions:{value:{'E':'승인완료','D':'반려','W':'승인대기'}}},
            { index: 'REASON',          name: 'REASON',             width: 100, align: 'left'},
            { index: 'RETURN_REASON',   name: 'RETURN_REASON',      width: 100, align: 'left', hidden:true},
            { index: 'TARGET_ID',       name: 'TARGET_ID',          width: 100, align: 'left', hidden:true},
            { index: 'HASH_ID',         name: 'HASH_ID',            width: 100, align: 'left', hidden:true}
            ],
        loadonce :true,
        viewrecords: true, // show the current page, data rang and total records on the toolbar
        width: oGrid.parent().width(),
        height: 600,
        multiselect : true,
        autowidth: true,
        shrinkToFit: true,
        rownumbers : false, // 행번호 표시여부
        rownumWidth : 75, // 행번호 열의 너비  
        rowNum:25,
        rowList:[25,50,100],    
        pager: "#changeGridPager",
        onCellSelect: function(rowid,icol,cellcontent,e) {
        },
//         loadComplete: function(data) {

//             // 데이터 로드 완료 시 이벤트
//             var idArry = oGrid.jqGrid('getDataIDs');            // grid의 id 값을 배열로 가져옴

//             for (var i = 0; i < idArry.length; i += 1){
//                 var ret =  oGrid.getRowData(idArry[i]);         // 해당 id의 row 데이터를 가져옴

//                 // 해당 row의 특정 컬럼 값이 1이 아니면 multiselect checkbox disabled 처리
//                 if (ret.APPROVAL_STATUS != ''){ 
//                    // 해당 row의 checkbox disabled 처리 "jqg_list_" 이 부분은 grid에서 자동 생성
//                    $("#jqg_changeGrid_"+idArry[i]).attr("disabled", true);
//                    $("#jqg_changeGrid_"+idArry[i]).prop('checked', false);
//                 }
//             }
//         },
//         beforeSelectRow: function(rowid, e) {  
//             var cbsdis = $("tr#"+rowid+".jqgrow > td > input.cbox:disabled", oGrid[0]);
//             if (cbsdis.length === 0) {  
//                 return true;    // allow select the row   
//             } else {
//                 return false;   // not allow select the row 
//             }
//         },   
//         onSelectAll: function(aRowids, status) {
//             if (status) {
//                 var cbs = $("tr.jqgrow > td > input.cbox:disabled", oGrid[0]);
//                 cbs.parent().parent().removeAttr("aria-selected");
// //                cbs.parent().parent().removeAttr("checked");
//                 cbs.parent().parent().attr("class", "jqgrow ui-row-ltr ui-widget-content");
// //                cbs.removeAttr("checked");
//                 cbs.prop('checked', false);
//             }
//         }
    });
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
    oPostDt["status"] = $("select[name='statusList']").val();
    oPostDt["request_status"]  = $('input[name="rdo_requestStatus"]:checked').val();
    oPostDt["owner"]    = $("#schOwner").val();
    oPostDt["filename"] = $("#schFilename").val();
    oPostDt["fromDate"] = $("#fromDate").val();
    oPostDt["toDate"]   = $("#toDate").val();

    $("#changeGrid").clearGridData();
    $("#changeGrid").setGridParam({
        url: "${getContextPath}/change/selectChangeList",
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
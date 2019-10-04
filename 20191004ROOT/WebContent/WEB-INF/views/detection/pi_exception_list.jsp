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
				<p class="location">검출 관리 > 결재 관리 > 경로 예외 리스트</p>
			</div>
			<div class="grid_top">
				<h3>경로 예외 리스트</h3>
                <div class="list_sch">
                    <div class="sch_area">
                        <button type="button" name="button" class="btn_new" id="btnSearch">Search</button>
                        <button type="button" name="button" class="btn_new" id="btnApprovalRequest">결재 요청</button>
                    </div>
                </div>
                <table class="user_info">
                    <caption>사용자정보</caption>
                    <tbody>
                        <tr>
                            <td style="text-align: center; background-color: #eeeeee; width:100px">업무구분</td>
                            <td style="width:180px;">
                                <select id="selectList" name="selectList" style="width:160px;">
                                    <option value="/approval/pi_search_list">정탐/오탐 리스트</option>
                                    <option value="/approval/pi_search_approval_list">정탐/오탐 결재 리스트</option>
                                    <option value="/excepter/pi_exception_list" selected>경로 예외 리스트</option>
                                    <option value="/excepter/pi_exception_approval_list">경로 예외 결재 리스트</option>
                                    <option value="/change/pi_change_list"> 담당자 변경 리스트</option>
                                </select>
                            </td>
                            <td style="text-align: center; background-color: #eeeeee; width:100px">상태</td>
                            <td>
                                <select id="statusList" name="statusList" style="width:100px;">
                                    <option value="">전체</option>
                                    <option value="E">승인완료</option>
                                    <option value="D">반려</option>
                                    <option value="W">승인대기</option>
                                    <option value="NR" selected>미요청</option>
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
			<div class="left_box2" style="overflow: hidden; max-height: 732px;height: 700px;">
				<table id="exceptionGrid"></table>
				<div id="exceptionGridPager"></div>
			</div>
		</div>
	</div>
	<!-- container -->

<!-- 팝업창 시작 경로 예외 신청 내역-->
<div id="insertPathExcepPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 510px;">
		<div class="popup_top">
			<h1 id="groupName"></h1>
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
							<th style="background-color: #f1f1f1;">이름</th>
							<td>
								<table style="border: 0px solid #cdcdcd; width: 380px; height: 240px; margin-top: 5px; margin-bottom: 5px; resize: none;" >
								<tbody>
									<tr id="excepPath">
									</tr>
								</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<th style="background-color: #f1f1f1;">사유</th>
								<td><input type="text" name="trueFalseChk" id="trueFalseChk" value="" class="edt_sch" style=" border: 0px solid #cdcdcd;" readonly>
							</td>  
						</tr>
						<tr>
							<th style="background-color: #f1f1f1;">등록서버</th>
								<td><input type="text" name="regisServer" id="regisServer" value="" class="edt_sch" style=" border: 0px solid #cdcdcd;" readonly>
							</td>  
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="btnCheck">확인</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 종료  -->

<!-- 팝업창 시작 : 경로예외 결재요청 -->
<div id="exceptionApprovalPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 510px;">
		<div class="popup_top">
			<h1 id="approvalRegis">결재 등록</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 390px;">
				<!-- <h2>세부사항</h2>  -->
				<table class="popup_tbl">
					<colgroup>
						<col width="130">
						<col width="*">
						<col width="130">
					</colgroup>
					<tbody>
						<tr>
							<th style="background-color: #f1f1f1;">요청자</th>
							<td colspan="2"><input type="text" id="reg_user_name" value="" class="edt_sch" style="border: 0px solid #cdcdcd;" readonly></td>
						</tr>
						<tr>
							<th style="background-color: #f1f1f1;">결재자</th>
							<td>
								<input type="text" id="ok_user_name" value="" class="edt_sch" style="width:100%; border: 0px solid #cdcdcd;" readonly>
							</td>
							<td class="btn_area" style="padding: 0px 0px 0px 20px; text-align: left;">
								<button type="button" id="btnUserSelectPopup" style="margin-bottom: 0px; background: #1898D2; width: 100px;">결재자 지정</button>
								<input type="text" id="ok_user_no" value="" class="edt_sch" style="border: 0px solid #cdcdcd; display:none;">
							</td>
						</tr>
						<tr>
							<th style="background-color: #f1f1f1;">요청일자</th>
							<td colspan="2"><input type="text" id="regdate" value="" class="edt_sch" style="border: 0px solid #cdcdcd;" readonly></td>
						</tr>
						<tr>
							<th style="background-color: #f1f1f1;">의견</th>
							<td colspan="2">
								<textarea id="reason" class="edt_sch" placeholder="" style="border: 0px solid #cdcdcd; width: 380px; height: 200px; margin-top: 5px; margin-bottom: 5px; resize: none;"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="btnApprovalSave" value="W">저장</button>
				<button type="button" id="btnApprovalCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 종료 -->

<!-- 팝업창 시작 담당자 지정 -->
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

</section>
<!-- section -->
<%@ include file="../../include/footer2.jsp"%>
<script>

$(document).ready(function () {

    // 날짜 설정
    setSelectDate();

	$("#selectList").change(function () {
		location.href = $("#selectList").val();
	});

	var boss_user_name = "${teamManager.USER_NAME}"; 
	var boss_jikguk = "${teamManager.JIKGUK}"; 
	var boss_user_no = "${teamManager.USER_NO}";

	$("#ok_user_no").val(boss_user_no);
	$("#ok_user_name").val(boss_user_name + " " + boss_jikguk + " (" + boss_user_no + ")");

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

    // 결재 요청 버튼
    $("#btnApprovalRequest").click(function() {
        reqApproval();
    });

	// 결재 요청 - 담당자 선택
	$("#btnUserSelectPopup").click(function (e) {
        $("#userSelect").show();
		searchAppUserSelect();
	});

	// 결재 요청 - 담당자 선택 취소
	$("#btnUserCancel").on("click", function(e) {
		$("#userSelect").hide();
	});

	$("#btnUserSelect").on("click", function(e) {

        var nRowid  = $("#userGrid").getGridParam("selrow");
        var sUserNm = $("#userGrid").getCell(nRowid, 'USER_NAME'); 
        var sJikguk = $("#userGrid").getCell(nRowid, 'JIKGUK'); 
        var sUserNo = $("#userGrid").getCell(nRowid, 'USER_NO');

        $("#ok_user_no").val(sUserNo);
        $("#ok_user_name").val(sUserNm + " " + sJikguk + " (" + sUserNo + ")");
        $("#userSelect").hide();
	});
	
	// 결재 요청 - 저장
	$("#btnApprovalSave").on("click", function(e) {
		saveApproval();
	});
	
	$("#btnApprovalCancel").on("click", function(e) {
		$("#exceptionApprovalPopup").hide();
		$("#reason").val("");
	});

	$("#btnCheck").on("click", function(e) {
		$("#insertPathExcepPopup").hide();
		var tr = $("#excepPath").children();
		tr.remove();
	});

	loadJqGrid($("#exceptionGrid"));
});

// 경로 예외 리스트 그리드 조회
function loadJqGrid(oGrid)
{
    // 경로예외 리스트 그리드
    var oPostDt = {};
    oPostDt["status"]   = $("select[name='statusList']").val();
    oPostDt["owner"]    = $("#schOwner").val();
    oPostDt["filename"] = $("#schFilename").val();
    oPostDt["fromDate"] = $("#fromDate").val();
    oPostDt["toDate"]   = $("#toDate").val();

    oGrid.jqGrid({
        url: "${getContextPath}/excepter/selectExceptionList",
        postData: oPostDt,
        datatype: "json",
        mtype: "POST",
        async: true,
        contentType: "application/json; charset=UTF-8",
        colNames:['', '호스트','문서명','문서 저장일','문서 기안일','상태','비고', 'USER_NO','OK_USER_NO', 'FLAG_NAME', 'CHARGE_ID', 'LEVEL'],
        colModel: [    
            { index: 'IDX',                 name: 'IDX',                width: 1, hidden:true},
            { index: 'OWNER',               name: 'OWNER',              width: 80, align: 'center'},
            { index: 'FILENAME',            name: 'FILENAME',           width: 180, align: 'left'},  
            { index: 'REGDATE',             name: 'REGDATE',            width: 100, align: 'center'}, 
            { index: 'OKDATE',              name: 'OKDATE',             width: 100, align: 'center'},
            { index: 'APPROVAL_STATUS',     name: 'APPROVAL_STATUS',    width: 50,  align: 'center', formatter:'select', editoptions:{value:{'E':'승인완료','D':'반려','W':'승인대기'}}},
            { index: 'NOTE',                name: 'NOTE',               width: 150,  align: 'center'},
            { index: 'USER_NO',             name: 'USER_NO',            width: 1,  hidden:true},
            { index: 'OK_USER_NO',          name: 'OK_USER_NO',         width: 1,  hidden:true},
            { index: 'FLAG_NAME',           name: 'FLAG_NAME',          width: 1, hidden:true},
            { index: 'CHARGE_ID',           name: 'CHARGE_ID',          width: 1, hidden:true},
            { index: 'LEVEL',               name: 'LEVEL',              width: 100, align: 'center', hidden:true}
        ],
        id: "exceptionGrid",
        loadonce :true,
        viewrecords: true, // show the current page, data rang and total records on the toolbar
        width: oGrid.parent().width(),
        height: 600,
        autowidth: true,
        multiselect:true,
        shrinkToFit: true,
        rownumbers : false, // 행번호 표시여부
        rownumWidth : 75, // 행번호 열의 너비  
        rowNum:25,
        rowList:[25,50,100],    
        pager: "#exceptionGridPager",
        ondblClickRow: function(nRowid, icol, cellcontent, e) {

            // 테이블에서 path_ex_group_name 가져와서 넣어줘야함
            var chid = oGrid.getCell(nRowid, 'IDX');
            var oPostDt = {};
            oPostDt["path_ex_group_id"] = chid;

            $.ajax({
                type: "POST",
                url: "${getContextPath}/excepter/selectExeptionPath",
                async: true,
                data: JSON.stringify(oPostDt),
                contentType: 'application/json; charset=UTF-8',
                success: function (searchList) {

                    var arr = [];
                    var getPathex = [];

                    if (searchList.length > 0) {
                        $.each(searchList, function (i, s) {

                            arr.push(s);
                            getPathex.push(arr[i].path_ex);
                            $("#excepPath").append("<tr style='border:none;'>" + "<th style='padding:0px; background: transparent;'>" + getPathex[i] + "</th>" + "</tr>");
                        });
                    }

                    return;
                },
                error: function (request, status, error) {
                    alert("실패 하였습니다.");
                }
            });

            var detailName = oGrid.getCell(nRowid, 'FILENAME');

            $("#groupName").html(detailName);
            $("#trueFalseChk").val(oGrid.getCell(nRowid, 'FLAG_NAME'));
            $("#insertPathExcepPopup").show();
        },
//         loadComplete: function(data) {

//             // 데이터 로드 완료 시 이벤트
//             var idArry = oGrid.jqGrid('getDataIDs');            // grid의 id 값을 배열로 가져옴

//             for (var i = 0; i < idArry.length; i += 1){
//                 var ret =  oGrid.getRowData(idArry[i]);         // 해당 id의 row 데이터를 가져옴

//                 // 해당 row의 특정 컬럼 값이 1이 아니면 multiselect checkbox disabled 처리
//                 if (ret.APPROVAL_STATUS != ''){ 
//                    // 해당 row의 checkbox disabled 처리 "jqg_list_" 이 부분은 grid에서 자동 생성
//                    $("#jqg_exceptionGrid_"+idArry[i]).attr("disabled", true);
//                    $("#jqg_exceptionGrid_"+idArry[i]).prop('checked', false);
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

// 경로 예외 리스트 결재 요청 팝업 호출
function reqApproval()
{
    var bDeletion = false;
    var aDeletion = [];
    var aSelRows = $("#exceptionGrid").getGridParam('selarrrow');      //체크된 row id들을 배열로 반환

    for (var i = 0; i < aSelRows.length; i += 1)
    {
        aDeletion.push($("#exceptionGrid").getRowData(aSelRows[i]));
        var status = $("#exceptionGrid").getCell(aSelRows[i], 'APPROVAL_STATUS');

        // 결재요청이 이루어진 경우 변경불가
        if (!isNull(status)) {
            bDeletion = true;
        }
    }

    if (bDeletion) {
        alert("이미 처리된 항목이 있습니다.");
        return;
    }

    if (aDeletion.length == 0) {
        alert("결재요청 항목을 선택하세요.");
        return;
    }

    var oToday = getToday();
    $("#reg_user_name").val("${memberInfo.USER_NAME}");
    $("#regdate").val(oToday.substring(0,4) + "-" + oToday.substring(4,6) + "-" + oToday.substring(6,8));
    $("#exceptionApprovalPopup").show();
    $("#reason").focus();    
}

// 경로 예외 리스트 결재 요청 내용 저장
function saveApproval()
{
    var oGrid = $("#exceptionGrid"); 
	var aIdxList = [];
	var aExcepScope = [];
	var aSelRow = oGrid.getGridParam('selarrrow');      //체크된 row id들을 배열로 반환

	for (var i = 0; i < aSelRow.length; i += 1)
	{
	    aIdxList.push(oGrid.getCell(aSelRow[i], 'IDX'));
	    aExcepScope.push(oGrid.getCell(aSelRow[i], 'OWNER'));
	}

	var sApprType = $('#btnApprovalSave').val();
	var oDate = new Date(); 
    var sToday = getFormatDate(oDate).replace(/[^0-9]/g, "");
    var sDocuSeq;

	$.ajax({
        type: "POST",
        url: "${getContextPath}/excepter/selectDocuNum",
        async : false,
        data : { "today": sToday },
        datatype: "json",
        success: function (result) {
            sDocuSeq = ""+result.SEQ;
        }
	});

	var oPostDt = {};
    oPostDt["ok_user_no"] = $("#ok_user_no").val();
	oPostDt["doc_seq"]    = sDocuSeq;
    oPostDt["idxList"]    = aIdxList;
	oPostDt["apprType"]   = sApprType;
	oPostDt["comment"]    = $("#reason").val();
    oPostDt["today"]      = sToday;

	$.ajax({

        type: "POST",
        url: "${getContextPath}/excepter/registPathExceptionCharge",
        async : false,
        data : JSON.stringify(oPostDt),
        contentType: 'application/json; charset=UTF-8',

	    success: function (result) {
	        if (result.resultCode != "0") {
	            alert(result.resultCode + "처리 등록을 실패 하였습니다.");
	            return;
	        }

	        alert("처리를 등록 하였습니다.");
	
	        var oPostDt = { USER_NO : '${memberInfo.USER_NO}'};

	        oGrid.clearGridData();
	        oGrid.setGridParam({
	        	url:"${getContextPath}/excepter/selectExceptionList",
	        	postData: oGrid.getGridParam('postData'), 
	        	datatype:"json"
        	}).trigger("reloadGrid");

	        $("#deletionRegistPopup").hide();
	        $("#reason").val("");
	        return;
	    },
	    error: function (request, status, error) {
	        alert("처리 등록을 실패 하였습니다.");
	        return;
	    }
	});
	
	$("#exceptionApprovalPopup").hide();
	$("#reason").val("");
}

//담당자 조회
function searchAppUserSelect()
{
	if ($("#userGrid").width() == 0) {
	
	    $("#userGrid").jqGrid({
	        url: "${getContextPath}/approval/selectTeamMember",
	        datatype: "json",
	        mtype: "POST",
	        ajaxGridOptions: {
	            type  : "POST",
	            async : true
	        },
	        colModel: [
	        	{label: '사원번호', index: 'USER_NO',   name: 'USER_NO',   width: 180, align: 'center', hidden: true },
                {label: '부서',    index: 'TEAM_NAME', name: 'TEAM_NAME', width: 180, align: 'center' },
                {label: '결재자',  index: 'USER_NAME', name: 'USER_NAME', width: 180, align: 'center' },
                {label: '직책',    index: 'JIKGUK',    name: 'JIKGUK',    width: 180, align: 'center' }               
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
	        onSelectRow : function(nRowid,celname,value,iRow,iCol) {    
	        },
	        afterEditCell: function(nRowid, cellname, value, iRow, iCol){
	        },
	        afterSaveCell : function(nRowid,name,val,iRow,ICol){
	        },
	        afterSaveRow : function(nRowid,name,val,iRow,ICol){
	        },
	        ondblClickRow: function(nRowid,iRow,iCol) {
	
	            var sUserNm = $(this).getCell(nRowid, 'USER_NAME'); 
	            var sJikguk = $(this).getCell(nRowid, 'JIKGUK'); 
	            var sUserNo = $(this).getCell(nRowid, 'USER_NO');
	
	            $("#ok_user_no").val(sUserNo);
	            $("#ok_user_name").val(sUserNm + " " + sJikguk + " (" + sUserNo + ")");
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
	    $("#userGrid").setGridParam({
	        url:"${getContextPath}/approval/selectTeamMember", 
	        datatype:"json"
	    }).trigger("reloadGrid");
	}
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
    oPostDt["status"]   = $("select[name='statusList']").val();
    oPostDt["owner"]    = $("#schOwner").val();
    oPostDt["filename"] = $("#schFilename").val();
    oPostDt["fromDate"] = $("#fromDate").val();
    oPostDt["toDate"]   = $("#toDate").val();

	$("#exceptionGrid").clearGridData();
	$("#exceptionGrid").setGridParam({
		url: "${getContextPath}/excepter/selectExceptionList",
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
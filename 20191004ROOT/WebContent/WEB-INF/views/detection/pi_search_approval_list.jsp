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
				<p class="location">검출 관리 > 결재 관리 > 정탐/오탐 결재 리스트</p>
			</div>
			<div class="grid_top">
				<h3 class="approvalListMenu">정탐/오탐 결재 리스트</h3>
	            <div class="list_sch">
	            <c:if test="${memberInfo.USER_GRADE != '0'}">
	                <div class="sch_area">
	                    <button type="button" name="button" class="btn_new" id="btnSearch">Search</button>
                        <button type="button" name="button" class="btn_new" id="btnApproveAll">일괄 결재</button>
	                    <button type="button" name="button" class="btn_new" id="btnApprove">결재</button>
	                </div>
	            </c:if>
	            </div>
                <table class="user_info approvalTh">
                    <caption>사용자정보</caption>
                    <tbody>
                        <tr>
                            <td style="text-align: center; background-color: #d6e4ed; width:4vw">업무구분</td>
                            <td style="width:10.5vw;">
                                <select id="selectList" name="selectList" style="width:9.7vw;">
                                    <option value="/approval/pi_search_list">정탐/오탐 리스트</option>
                                    <option value="/approval/pi_search_approval_list" selected>정탐/오탐 결재 리스트</option>
                                    <!-- <option value="/excepter/pi_exception_list">경로 예외 리스트</option>
                                    <option value="/excepter/pi_exception_approval_list">경로 예외 결재 리스트</option> -->
                                    <option value="/change/pi_change_list"> 담당자 변경 리스트</option>
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
                            <td style="text-align: center; background-color: #d6e4ed; width:4vw;">문서명</td>
                            <td style="width:8.9vw"><input type="text" style="width: 8vw; font-size: .85vw;" size="20" id="schPath" placeholder="문서명을 입력하세요"></td>
                            <td style="text-align: center; background-color: #d6e4ed; width:4vw">기안자</td>
                            <td style="width:9.7vw"><input type="text" style="width: 8.9vw; font-size: .85vw;" size="10" id="schUserNm" placeholder="기안자명을 입력하세요"></td>
                            <td style="text-align: center; background-color: #d6e4ed; width:5vw">문서기안일</td>
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
  					<table id="processApproveGrid"></table>
  					<div id="processApproveGridPager"></div>
			</div>
		</div>
	</div>
	

<!-- 팝업창 시작 결재 신청 확인 -->
<div id="selecetProcessPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 510px;">
		<div class="popup_top">
			<h1 id="">결재 신청 확인</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 390px;">
				<!-- <h2>세부사항</h2>  -->
				<table class="popup_tbl" style="table-layout:fixed;">
					<colgroup>
						<col width="130">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th style="background-color: #f9f9f9;">이름</th>
							<td style="padding:5px;">
                                <textarea id="excepPath" name="excepPath" style="border: 0px solid #cdcdcd; width: 100%; height: 230px; resize: none;" readonly="true"></textarea>
							</td>
						</tr>
						<tr>
							<th style="background-color: #f9f9f9;">결재</th>
								<td>
								<input type="radio" name="trueFalseChk" id="permit" value="E" class="edt_sch" style=" border: 0px solid #cdcdcd;">승인
								<input type="radio" name="trueFalseChk" id="reject" value="D" class="edt_sch" style="margin-left:100px; border: 0px solid #cdcdcd;">반려
								<input type="hidden" id="selectedDate" value="">
							</td>  
						</tr>
						<tr>
							<th style="background-color: #f9f9f9;">사유</th>
								<td style="padding:5px;"><textarea id="reason" class="edt_sch" style="border: 0px solid #cdcdcd; width: 100%; height: 50px; margin-top: 5px; margin-bottom: 5px; resize: none;"></textarea>
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

<!-- 팝업창 시작 정탐/오탐 신청 내역-->
<div id="insertPathPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 510px;">
		<div class="popup_top">
			<h1 id="groupName"></h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 390px;">
				<!-- <h2>세부사항</h2>  -->
				<table class="popup_tbl" style="table-layout:fixed;">
					<colgroup>
						<col width="130">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th style="background-color: #f9f9f9;">이름</th>
							<td style="padding:5px;">
                                <textarea id="processPath" name="processPath" style="border: 0px solid #cdcdcd; width: 100%; height: 330px; resize: none;" readonly="true"></textarea>
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

<!-- container -->
</section>
<!-- section -->
<%@ include file="../../include/footer2.jsp"%>
<script>
var bApprovalAll = false;
var oApprovalAll = {};

$(document).ready(function () {

	// 날짜 설정
    setSelectDate();

	$("#selectList").change(function () {
		location.href=$("#selectList").val();
	});

    // 조회조건 담당자 inputbox Keydown Event (사용자 조회)
    $("#schPath, #schUserNm").keydown(function(e) {
        if(e.keyCode == 13) 
            fn_search();
    });

    // 검색
    $("#btnSearch").click(function() {
        fn_search();
    });

    // 검색
    $("#statusList").change(function() {
        fn_search();
    });

    // 
	$("#btnCheck").click(function(e) {
		$("#insertPathPopup").hide();
		$("#processPath").val();
	});

	// 일괄 결재 버튼
	$("#btnApproveAll").click(function(e) {
	    reqApprovalAll();
	});

	// 결재 버튼
	$("#btnApprove").click(function(e) {
		reqApproval();
	});

	// 결재 취소
	$("#btnCancel").click(function(e) {
        bApprovalAll = false;
        oApprovalAll = {};
        $("#excepPath").val('');
        $("#reason").val('');
        $("#selecetProcessPopup").hide();
	});
	
// 결재 - 저장
	$("#btnSave").click(function(e) {
		
		var radioChk = $("input:radio[name=trueFalseChk]:checked").val();
		
		if (! radioChk) {
			alert("결재 방안을 선택하세요");
		} else {
			if (bApprovalAll) {
			    saveApprovalAll();
			} 
			else {
				saveApproval();
			}
	        bApprovalAll = false;
	        oApprovalAll = {};
	        $("#excepPath").val('');
	        $("#reason").val('');
		    $("#selecetProcessPopup").hide();
		}
	});

	loadJqGrid($("#processApproveGrid"));
});

//정탐/오탐 결재 리스트 그리드 조회
function loadJqGrid(oGrid)
{
    // 정탐/오탐 결재 리스트 그리드
    var oPostDt = {};
    oPostDt["target_id"] = $("#hostSelect").val();
    oPostDt["status"]    = $("select[name='statusList']").val();
    oPostDt["user_nm"]   = $("#schUserNm").val();
    oPostDt["path"]      = $("#schPath").val();
    oPostDt["fromDate"]  = $("#fromDate").val();
    oPostDt["toDate"]    = $("#toDate").val();

    oGrid.jqGrid({
        url: "${getContextPath}/approval/searchApprovalListData",
        postData: oPostDt,
        datatype: "json",
        mtype: "POST",
        async: true,
        contentType: "application/json; charset=UTF-8",
        colModel: [    
            {label: '',          index: 'CHK',             name: 'CHK',             width: 30,  align: 'center', hidden:true},
            {label: '문서명',     index: 'PATH',            name: 'PATH',            width: 200, align: 'left'},
            {label: '기안자',     index: 'USER_NAME',       name: 'USER_NAME',       width: 60,  align: 'center'},
            {label: '결재자',     index: 'OK_USER_NAME',    name: 'OK_USER_NAME',    width: 60,  align: 'center'},
            {label: '문서기안일',  index: 'REGDATE',         name: 'REGDATE',         width: 100, align: 'center'},   
            {label: '결재일',     index: 'OKDATE',          name: 'OKDATE',          width: 100, align: 'center'},   
            {label: '상태',       index: 'APPROVAL_STATUS', name: 'APPROVAL_STATUS', width: 50,  align: 'center', formatter:'select', editoptions:{value:{'E':'승인완료','D':'반려','W':'승인대기'}}},
            {label: '비고',       index: 'REASON',          name: 'REASON',          width: 100, align: 'left'},
            {label: 'CHARGE_ID', index: 'CHARGE_ID',       name: 'CHARGE_ID',       width: 10,  hidden:true}
        ],
        loadonce: true,
        viewrecords: true,                  // show the current page, data rang and total records on the toolbar
        width: oGrid.parent().width(),
        height: 600,
        multiselect: true,
        autowidth: true,
        shrinkToFit: true,
        rownumbers: false,                  // 행번호 표시여부
        rownumWidth: 75,                    // 행번호 열의 너비  
        rowNum: 25,
        rowList: [50,250,1000],
        pager: "#processApproveGridPager",
        ondblClickRow: function(rowid, icol, cellcontent, e) {
			
        	// 팝업 호출 전 data clear
        	$("#processPath").val("");
        	
        	// 테이블에서 path_ex_group_name 가져와서 넣어줘야함
            var oPostDt = {};
            oPostDt["CHARGE_ID_LIST"] = oGrid.getCell(rowid, 'CHARGE_ID');

            var oJson = JSON.stringify(oPostDt);

            $.ajax({
                url: "${getContextPath}/approval/selectProcessGroupPath",
                type: "POST",
                async : true,
                data : oJson,
                contentType: 'application/json; charset=UTF-8',
                success: function (searchList) {

                    if (searchList.length > 0) {
                    	var sChargeId = undefined;
                    	var sText = "";
                        $.each(searchList, function (i, s) {

                            if (sChargeId != s.CHARGE_ID) {
                            	sText += "\r\n- " + s.data_processing_name + "\r\n";
                            }

                            sText += s.PATH + "\r\n";
                            sChargeId = s.CHARGE_ID;
                        });
                        sText = sText.replace(/^\/r\/n/g, "");
                        $("#processPath").val(sText);
                    }
                    return;
                },
                error: function (request, status, error) {
                    alert("실패 하였습니다.");
                }
            });
            
            var detailName = oGrid.getCell(rowid, 'PATH');
            console.log(detailName);
            $("#groupName").html(detailName);
            $("#insertPathPopup").show();
        },
//         onCellSelect: function(rowid, icol, cellcontent, e) {
//             if (status) {
//                 var cbs = $("tr.jqgrow > td > input.cbox:disabled", oGrid[0]);
//                 cbs.removeAttr("checked");
                
//                 oGrid[0].p.selarrrow = oGrid.find("tr.jqgrow:has(td > input.cbox:checked)").map(function() { return this.id; }).get();
//             }
//         },
//         loadComplete: function(data) {
//             var idArry = oGrid.jqGrid('getDataIDs'); //grid의 id 값을 배열로 가져옴
                                        
//             for(var i=0 ; i < idArry.length; i++){
//                 var ret =  oGrid.getRowData(idArry[i]); // 해당 id의 row 데이터를 가져옴

//                 if(ret.APPROVAL_STATUS != 'W'){ //해당 row의 특정 컬럼 값이 1이 아니면 multiselect checkbox disabled 처리
//                    //해당 row의 checkbox disabled 처리 "jqg_list_" 이 부분은 grid에서 자동 생성
//                    $("#jqg_processApproveGrid_"+idArry[i]).attr("disabled", true); 
//                 }
//             }
//         },
//         beforeSelectRow: function (rowid, e) {
//             var $myGrid = $(this),
//                 i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),
//                 cm = $myGrid.jqGrid('getGridParam', 'colModel');
//             return (cm[i].name === 'cb');
//         }
    });
}

//일괄 결재
function reqApprovalAll()
{
	$.ajax({
	    type: "POST",
	    url: "${getContextPath}/approval/searchApprovalAllListData",
	    async : true,
	    success: function (searchList) {
	
	        if (searchList.length > 0) {
	            var sGroupId = undefined;
	            var sText = "";
	            $.each(searchList, function (i, s) {
	
	                if (sGroupId != s.GROUP_ID) {
	                    sText += "\r\n- (" + s.CHARGE_NAME + ") " + s.data_processing_name + "\r\n";
	                }
	
	                sText += s.PATH + "\r\n";
	                sGroupId = s.GROUP_ID;
	            });
	            sText = sText.replace(/^\/r\/n/g, "");
	            $("#excepPath").val(sText);
	        }
	
	        bApprovalAll = true;
	        oApprovalAll = searchList;

	        if (oApprovalAll.length <= 0) {
	            alert("처리할 결재가 존재 하지 않습니다.");
	            return;
	        }

	        $("#selecetProcessPopup").show();
	        return;
	    },
	    error: function (request, status, error) {
	        alert("실패 하였습니다.");
	    }
	});
}

function saveApprovalAll()
{
    var aChargeId = [];
    for (var i = 0; i < oApprovalAll.length; i += 1)
    {
        if (aChargeId.indexOf(oApprovalAll[i]["CHARGE_ID"]) < 0) 
            aChargeId.push(oApprovalAll[i]["CHARGE_ID"]);
    }

    var sReason  = $("#reason").val();
    var apprType = $("input:radio[name=trueFalseChk]:checked").val();

    if (!apprType) {
        alert("사유를 선택하세요.");
        return false;
    }

    var oPostDt = {};
    oPostDt["chargeIdList"] = aChargeId.join(",");
    oPostDt["reason"]   = sReason
    oPostDt["apprType"] = apprType;

    var oJson = JSON.stringify(oPostDt);

    $.ajax({
        url: "${getContextPath}/approval/updateProcessApproval",
        type: "POST",
        async : false,
        data : oJson,
        contentType: 'application/json; charset=UTF-8',
        success: function (result) {

            if (result.resultCode != "0") {
                alert(result.resultCode + "("+result.resultMessage+"} 처리 등록을 실패 하였습니다.");
                return;
            }

            alert("처리를 등록 하였습니다.");

            $("#processApproveGrid").setGridParam({
                url: "${getContextPath}/approval/searchApprovalListData",
                postData: $("#processApproveGrid").getGridParam('postData'), 
                datatype: "json"
            }).trigger("reloadGrid");

            $("#deletionRegistPopup").hide();
            $("input:radio[name=trueFalseChk]").prop("checked", false);

            return;
        },
        error: function (request, status, error) {
            alert("처리 등록을 실패 하였습니다.");
            $("input:radio[name=trueFalseChk]").prop("checked", false);
            return;
        }
    });

    bApprovalAll = false;
    oApprovalAll = {};
    $("#excepPath").val('');
}

// 결재 리스트 조회
function reqApproval()
{
    var sStatus = "";
    var bException = false;
    var aChargeId = [];

    var aSelRow = $("#processApproveGrid").getGridParam('selarrrow');                           // 체크된 row id들을 배열로 반환

    for (var i = 0; i < aSelRow.length; i += 1)
    {
    	aChargeId.push($("#processApproveGrid").getCell(aSelRow[i], 'CHARGE_ID'));
        sStatus = $("#processApproveGrid").getCell(aSelRow[i], 'APPROVAL_STATUS');

        if ((sStatus == "D") || (sStatus == "E")) {
        	bException = true;
        }
    }

    if (bException) {
        alert("이미 처리된 항목이 존재합니다.");
        return;
    }

    if (aChargeId.length == 0) {
        alert("결재요청 항목을 선택하세요.");
        return;
    }

    var oPostDt = {};
    oPostDt["CHARGE_ID_LIST"] = aChargeId.join(",");
    var oJson = JSON.stringify(oPostDt);

    $.ajax({
        url: "${getContextPath}/approval/selectProcessGroupPath",
    	type: "POST",
        async : true,
        data : oJson,
        contentType: 'application/json; charset=UTF-8',
        success: function (searchList) {

            if (searchList.length > 0) {
                var sChargeId = undefined;
                var sText = "";
                $.each(searchList, function (i, s) {

                    if (sChargeId != s.CHARGE_ID) {
                        sText += "\r\n- " + s.data_processing_name + "\r\n";
                    }

                    sText += s.PATH + "\r\n";
                    sChargeId = s.CHARGE_ID;
                });
                sText = sText.replace(/^\/r\/n/g, "");
                $("#excepPath").val(sText);
            }
            return;
        },
        error: function (request, status, error) {
            alert("실패 하였습니다.");
        }
    });

    $("#selecetProcessPopup").show();
}

// 결재 저장
function saveApproval() 
{
    var sStatus = "";
    var bException = false;
    var aChargeId = [];

    var aSelRow = $("#processApproveGrid").getGridParam('selarrrow');      //체크된 row id들을 배열로 반환

    for (var i = 0; i < aSelRow.length; i += 1)
    {
        aChargeId.push($("#processApproveGrid").getCell(aSelRow[i], 'CHARGE_ID'));
        sStatus = $("#processApproveGrid").getCell(aSelRow[i], 'APPROVAL_STATUS');

        if ((sStatus == "D") || (sStatus == "E")) {
        	bException = true;
        }
    }

    if (bException) {
        alert("이미 처리된 항목이 존재합니다.");
        return;
    }
    if (aChargeId.length == 0) {
        alert("결재요청 항목을 선택하세요.");
        return;
    }

    var sReason  = $("#reason").val();
    var apprType = $("input:radio[name=trueFalseChk]:checked").val();

    if (!apprType) {
        alert("사유를 선택하세요.");
        return false;
    }

    var oPostDt = {};
    oPostDt["chargeIdList"] = aChargeId.join(",");
    oPostDt["reason"]   = sReason
    oPostDt["apprType"] = apprType;

    var oJson = JSON.stringify(oPostDt);

    $.ajax({
        url: "${getContextPath}/approval/updateProcessApproval",
        type: "POST",
        async : false,
        data : oJson,
        contentType: 'application/json; charset=UTF-8',
        success: function (result) {

        	if (result.resultCode != "0") {
                alert(result.resultCode + "("+result.resultMessage+"} 처리 등록을 실패 하였습니다.");
                return;
            }

            alert("처리를 등록 하였습니다.");

            $("#processApproveGrid").setGridParam({
                url: "${getContextPath}/approval/searchApprovalListData",
                postData: $("#processApproveGrid").getGridParam('postData'), 
                datatype: "json"
            }).trigger("reloadGrid");

            $("#deletionRegistPopup").hide();
            $("input:radio[name=trueFalseChk]").prop("checked", false);

            return;
        },
        error: function (request, status, error) {
            alert("처리 등록을 실패 하였습니다.");
            $("input:radio[name=trueFalseChk]").prop("checked", false);
            return;
        }
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
    oPostDt["target_id"] = $("#hostSelect").val();
    oPostDt["status"]    = $("select[name='statusList']").val();
    oPostDt["user_nm"]   = $("#schUserNm").val();
    oPostDt["path"]      = $("#schPath").val();
    oPostDt["fromDate"]  = $("#fromDate").val();
    oPostDt["toDate"]    = $("#toDate").val();

	$("#processApproveGrid").clearGridData();
	$("#processApproveGrid").setGridParam({
	    url: "${getContextPath}/approval/searchApprovalListData",
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
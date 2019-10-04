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
				<p class="location">검출 관리 > 결재 관리 > 경로 예외 결재 리스트</p>
			</div>
			<div class="grid_top">
				<h3>경로 예외 결재 리스트</h3>
	            <div class="list_sch">
	            <c:if test="${memberInfo.USER_GRADE != '0'}">
	                <div class="sch_area">
                        <button type="button" name="button" class="btn_new" id="btnSearch">Search</button>
	                    <button type="button" name="button" class="btn_new" id="btnApproveAll">일괄 결재</button>
	                    <button type="button" name="button" class="btn_new" id="btnApprove">결재</button>
	                </div>
	            </c:if>
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
                                    <option value="/excepter/pi_exception_list">경로 예외 리스트</option>
                                    <option value="/excepter/pi_exception_approval_list" selected>경로 예외 결재 리스트</option>
                                    <option value="/change/pi_change_list"> 담당자 변경 리스트</option>
                                </select>
                            </td>
                            <td style="text-align: center; background-color: #eeeeee; width:100px">상태</td>
                            <td>
                                <select id="statusList" name="statusList" style="width:100px;">
                                    <option value="">전체</option>
                                    <option value="E">승인완료</option>
                                    <option value="D">반려</option>
                                    <option value="W" selected>승인대기</option>
                                </select>
                            </td>
                            <td style="text-align: center; background-color: #eeeeee; width:100px">문서명</td>
                            <td><input type="text" style="width: 100%;" size="20" id="schPath" placeholder="문서명을 입력하세요"></td>
                            <td style="text-align: center; background-color: #eeeeee; width:100px">기안자</td>
                            <td><input type="text" style="width: 100%;" size="10" id="schUserNm" placeholder="기안자명을 입력하세요"></td>
                            <td style="text-align: center; background-color: #eeeeee; width:100px">문서기안일</td>
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
  					<table id="excepApproveGrid"></table>
  					<div id="excepApproveGridPager"></div>
			</div>
		</div>
	</div>
	
<!-- 팝업창 시작 결재 신청 확인 -->
<div id="selecetExcepPopup" class="popup_layer" style="display:none">
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
							<th style="background-color: #f9f9f9;">리스트</th>
							<td  style="padding:5px;">
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
                            <th style="background-color: #f9f9f9;">리스트</th>
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
        $("#processPath").val("");
    });

	// 일괄 결재 버튼
	$("#btnApproveAll").click(function(e) {
		reqApprovalAll();
	});

	// 결재 버튼
	$("#btnApprove").click(function(e) {
		reqApproval();
	});

	$("#btnCancel").click(function(e) {
        bApprovalAll = false;
        oApprovalAll = {};
        $("#excepPath").val("");
        $("#reason").val('');
        $("#selecetExcepPopup").hide();
	});

	// 결재 - 저장
	$("#btnSave").click(function(e) {
        if (bApprovalAll) {
            saveApprovalAll();
        } 
        else {
            saveApproval();
        }
        bApprovalAll = false;
        oApprovalAll = {};
        $("#excepPath").val("");
        $("#reason").val('');
		$("#selecetExcepPopup").hide();
	});

	loadJqGrid($("#excepApproveGrid"));
});

function loadJqGrid(oGrid)
{
    // 정탐/오탐 결재 리스트 그리드
    var oPostDt = {};
    oPostDt["status"]    = $("select[name='statusList']").val();
    oPostDt["user_nm"]   = $("#schUserNm").val();
    oPostDt["path"]      = $("#schPath").val();
    oPostDt["fromDate"]  = $("#fromDate").val();
    oPostDt["toDate"]    = $("#toDate").val();

    oGrid.jqGrid({
        url: "${getContextPath}/excepter/exceptionApprovalListData",
        postData: oPostDt,
        datatype: "json",
        mtype: "POST",
        ajaxGridOptions : {
            type: "POST",
            async: true
        },
        colNames:['IDX','문서명','기안자','결재자','문서기안일','결재일','상태','비고', 'CHARGE_ID'],
        colModel: [    
            { index: 'IDX',          name: 'IDX',          width: 1,   hidden:true},
            { index: 'NAME',         name: 'NAME',         width: 180, align: 'left'},
            { index: 'USER_NAME',    name: 'USER_NAME',    width: 80,  align: 'center'},
            { index: 'OK_USER_NAME', name: 'OK_USER_NAME', width: 80,  align: 'center'},
            { index: 'REGDATE',      name: 'REGDATE',      width: 100, align: 'center'},   
            { index: 'OKDATE',       name: 'OKDATE',       width: 100, align: 'center'},   
            { index: 'STATUS',       name: 'STATUS',       width: 50,  align: 'center', formatter:'select', editoptions:{value:{'E':'승인완료','D':'반려','W':'승인대기'}}},
            { index: 'REASON',       name: 'REASON',       width: 100, align: 'left'},
            { index: 'CHARGE_ID',    name: 'CHARGE_ID',    width: 10,  hidden:true}
        ],
        loadonce :true,
        viewrecords: true,      // show the current page, data rang and total records on the toolbar
        width: oGrid.parent().width(),
        height: 600,
        multiselect : true,
        autowidth: true,
        shrinkToFit: true,
        rownumbers: false,      // 행번호 표시여부
        rownumWidth: 75,        // 행번호 열의 너비  
        rowNum:25,
        rowList:[25,50,100],    
        pager: "#excepApproveGridPager",
        ondblClickRow: function(rowid, icol, cellcontent, e) {

            // 테이블에서 path_ex_group_name 가져와서 넣어줘야함
            var oPostDt = {};
            oPostDt["CHARGE_ID_LIST"] = oGrid.getCell(rowid, 'CHARGE_ID');

            var oJson = JSON.stringify(oPostDt);

            $.ajax({
            	url: "${getContextPath}/excepter/selectExceptionGroupPath",
                type: "POST",
                async : true,
                data : oJson,
                contentType: 'application/json; charset=UTF-8',
                success: function (searchList) {

                	$("#processPath").val("");
                    if (searchList.length > 0) {
                        var sChargeId = undefined;
                        var sText = "";
                        $.each(searchList, function (i, s) {

                            if (sChargeId != s.group_id) {
                                sText += "\r\n- " + s.path_ex_scope + "\r\n";
                            }

                            sText += s.path_ex + "\r\n";
                            sChargeId = s.group_id;
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
            
            var detailName = oGrid.getCell(rowid, 'NAME');
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
                
//                 if(ret.STATUS != 'W'){ //해당 row의 특정 컬럼 값이 1이 아니면 multiselect checkbox disabled 처리
//                    //해당 row의 checkbox disabled 처리 "jqg_list_" 이 부분은 grid에서 자동 생성
//                    $("#jqg_excepApproveGrid_"+idArry[i]).attr("disabled", true); 
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
	    url: "${getContextPath}/excepter/exceptionApprovalAllListData",
	    async : true,
	    success: function (searchList) {
	
	        if (searchList.length > 0) {
	            var sGroupId = undefined;
	            var sText = "";
	            $.each(searchList, function (i, s) {
	
	                if (sGroupId != s.group_id) {
	                    sText += "\r\n- " + s.path_ex_scope + "\r\n";
	                }
	
	                sText += s.path_ex + "\r\n";
	                sGroupId = s.group_id;
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

	        $("#selecetExcepPopup").show();
	        return;
	    },
	    error: function (request, status, error) {
	        alert("실패 하였습니다.");
	    }
	});
}

// 일괄 결재 저장
function saveApprovalAll()
{
	var oGrid = $("#excepApproveGrid");
    var aChargeId = [];

    if (oApprovalAll.length <= 0) {
    	alert("처리할 결재가 존재 하지 않습니다.");
    	return;
    }

    for (var i = 0; i < oApprovalAll.length; i += 1)
    {
        if (aChargeId.indexOf(oApprovalAll[i]["charge_id"]) < 0) 
            aChargeId.push(oApprovalAll[i]["charge_id"]);
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
        url: "${getContextPath}/excepter/updateExcepApproval",
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

            oGrid.setGridParam({
            	url: "${getContextPath}/excepter/exceptionApprovalListData",
                postData: oGrid.getGridParam('postData'), 
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
    $("#excepPath").val();
}

//결재 리스트 조회
function reqApproval()
{
	var oGrid = $("#excepApproveGrid")
    var sStatus = "";
    var bException = false;
    var aChargeId = [];

    var aSelRow = oGrid.getGridParam('selarrrow');                           // 체크된 row id들을 배열로 반환

    for (var i = 0; i < aSelRow.length; i += 1)
    {
        aChargeId.push(oGrid.getCell(aSelRow[i], 'CHARGE_ID'));
        sStatus = oGrid.getCell(aSelRow[i], 'STATUS');

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
        url: "${getContextPath}/excepter/selectExceptionGroupPath",
        type: "POST",
        async : true,
        data : oJson,
        contentType: 'application/json; charset=UTF-8',
        success: function (searchList) {

            if (searchList.length > 0) {
                var sChargeId = undefined;
                var sText = "";
                $.each(searchList, function (i, s) {

                    if (sChargeId != s.group_id) {
                        sText += "\r\n- " + s.path_ex_scope + "\r\n";
                    }

                    sText += s.path_ex + "\r\n";
                    sChargeId = s.group_id;
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

    $("#selecetExcepPopup").show();
}

//결재 저장
function saveApproval() 
{
	var oGrid = $("#excepApproveGrid");
    var sStatus = "";
    var bException = false;
    var aChargeId = [];

    var aSelRow = oGrid.getGridParam('selarrrow');      //체크된 row id들을 배열로 반환

    for (var i = 0; i < aSelRow.length; i += 1)
    {
        aChargeId.push(oGrid.getCell(aSelRow[i], 'CHARGE_ID'));
        sStatus = oGrid.getCell(aSelRow[i], 'STATUS');

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
        url: "${getContextPath}/excepter/updateExcepApproval",
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

            oGrid.setGridParam({
            	url: "${getContextPath}/excepter/exceptionApprovalListData",
            	postData: oGrid.getGridParam('postData'), 
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
    oPostDt["status"]    = $("select[name='statusList']").val();
    oPostDt["user_nm"]   = $("#schUserNm").val();
    oPostDt["path"]      = $("#schPath").val();
    oPostDt["fromDate"]  = $("#fromDate").val();
    oPostDt["toDate"]    = $("#toDate").val();
    
    $("#excepApproveGrid").clearGridData();
    $("#excepApproveGrid").setGridParam({
        url: "${getContextPath}/excepter/exceptionApprovalListData",
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
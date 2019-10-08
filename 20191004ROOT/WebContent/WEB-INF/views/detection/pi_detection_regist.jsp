<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="nowDate" class="java.util.Date" />
<%@ include file="../../include/header2.jsp"%>

<style>
.myclass td {
	font-weight : bold !important;
	color: silver !important;
}
div.matchData { 
	margin:5px; 
	padding:5px; 
	background-color: white; 
	width: 550px; 
	height: 110px; 
	overflow: auto; 
	text-align:justify; 
}
</style>


<!-- 검출관리 -->

<!-- section -->
<section>
    <!-- container -->
    <div class="container">
    <%@ include file="../../include/menu2.jsp"%>
        <!-- content -->
        <div class="content magin_t45">
            <div class="location_area">
                <p class="location">검출 관리 > 검출 리스트</p>
            </div>

            <div class="grid_top">
                <h3 class="detectionListMenu">검출 리스트</h3>
                <table class="user_info">
                    <caption>검출 리스트</caption>
                    <tbody>
                        <tr>
                            <td style="text-align: center; background-color: #d6e4ed; width:100px">Host</td>
                            <td style="width:350px;">
                                <select id="hostSelect" name="hostSelect" style="width: 100%;">
                                    <c:forEach items="${targetList}" var="targetList">
                                    <option value="${targetList.TARGET_ID}"<c:if test="${targetList.TARGET_ID == target_id}">selected</c:if>>${targetList.AGENT_NAME} - ${targetList.AGENT_CONNECTED_IP}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td style="text-align: center; background-color: #d6e4ed; width:100px">경로</td>
                            <td style="width:300px;">
                                <input type="text" id="searchLocation" value="" class="edt_sch" style="width: 100%;">
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div class="list_sch">
                    <div class="sch_area">
                        <button type="button" name="button" class="btn_new" id="btnDeletionRegist">처리</button>
                        <button type="button" name="button" class="btn_new" id="btnChangePath">담당자 변경</button>
                        <!-- <button type="button" name="button" class="btn_new" id="btnExceptionRegist">경로예외</button> -->
						<button type="button" name="button" class="btn_new" id="btnSearch">검색</button>                        
                        <!-- <button type="button" name="button" class="btn_new" id="btnReport">리포트</button> -->
                    </div>
                </div>
            </div>
            <div class="left_box2 minW" style="overflow: hidden; max-height: 732px;height: 700px;">
                    <table id="targetGrid"></table>
            </div>
        </div>
    </div>
    <!-- container -->
</section>
<!-- section -->

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

<!-- 팝업창 시작 : 경로 예외 -->
<div id="exceptionReasonPopup" class="popup_layer" style="display:none">
    <div class="popup_box" style="height: 510px;">
        <div class="popup_top">
            <h1 id="title_exception"></h1>
        </div>
        <div class="popup_content">
            <div class="content-box" style="height: 390px;">
                <table class="popup_tbl" >
                <colgroup>
                        <col width="130">
                        <col width="*">
                        <col width="130">
                    <tbody>
                        <tr>
                            <th style="background-color: #f1f1f1;">오탐 종류</th>
                            <td colspan="2">
                                <input type="radio" class="edt_sch" name="reason" value=11 style="border: 0px solid #cdcdcd;">로그  
                                <input type="radio" class="edt_sch" name="reason" value=12 style="margin-left:12%; border: 0px solid #cdcdcd;">설치파일 
                                <input type="radio" class="edt_sch" name="reason" value=13 style="margin-left:12%; border: 0px solid #cdcdcd;">텍스트
                                <input type="radio" class="edt_sch" name="reason" value=14 style="margin-left:12%; border: 0px solid #cdcdcd;">과탐
                            </td>
                        </tr>
                        <tr>
                            <th style="background-color: #f1f1f1;">적용대상 서버</th>
                            <td>
                                <input type="hidden" id="selectedTargetId" value="">
                                <input type="radio" class="edt_sch" name="serverChk" id="allserver" value="all" style="border: 0px solid #cdcdcd;"> 전체서버
                                <input type="radio" class="edt_sch" name="serverChk" id="oneserver" value="" style="margin-left:12%; border: 0px solid #cdcdcd;"> 특정서버
                            </td>
                            <td class="btn_area" style="padding: 0px 0px 0px 20px; text-align: left;">
                                <button type="button" id="btnServerSelectPopup" style="margin-bottom: 0px; background: #1898D2; width: 100px;">찾기</button>
                            </td>
                        </tr>
                        <tr>
                            <th style="background-color: #f1f1f1;">예외처리 경로</th>
                            <td colspan="2">
                                <input type="text" id="inputExcepPath" onkeyup="var e=event||window.event; fnLocationAdd(this, e);" style="width:100%;">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="padding:5px;">
                                <div style="width:100%; height:200px; overflow:auto; layout:fixed;">
                                    <table id="excepPath" style="text-align:center; table-layout:fixed; width:100%;">
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
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

<!-- 팝업창 시작 : 처리 -->
<div id="deletionRegistPopup" class="popup_layer" style="display:none">
    <div class="popup_box" style="width: 1200px; height: 600px; left: 37%; top: 47%;">
        <div class="popup_top">  
            <h1 id="title_process"></h1>
        </div>
        <div class="popup_content"> 
            <div class="content-box" style="height: 500px;">
                <!-- <h2>세부사항</h2>  -->
                <table class="popup_tbl">
                    <colgroup>
                        <col width="130">
                        <col width="*">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th style="background-color: #f1f1f1; text-align: center;">검출경로</th>
                            <td style="padding:5px;">
                                <div id="path_exception_div" style="width:100%; height:400px; overflow:auto; layout:fixed;">
                                <table id="path_exception" style="text-align:center; width:100%;">
                                    <tbody>
                                    </tbody>
                                </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th style="background-color: #f1f1f1; text-align: center;">사유</th>
                            <td>
                                <label class="answerLabel"><input type="radio" class="answerRadio" name="trueFalseChk" id="selectReasonTrue" value="" class="edt_sch" style="position:relative; border: 0px solid #cdcdcd; width:40px; height:50px; margin-right:20px;"></label>
                                <label class="wrongLabel"><input type="radio" class="wrongRadio" name="trueFalseChk" id="selectReasonFalse" value="" class="edt_sch" style="position:relative; border: 0px solid #cdcdcd; width:40px; height:50px;"></label>
                                <input type="hidden" id="selectedDate" value="">
                                <input type="hidden" id="group_id" value="">
                            </td>  
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="popup_btn">
            <div class="btn_area">
                <button type="button" id="btnDeletionSave">저장</button>
                <button type="button" id="btnDeletionCancel">취소</button>
            </div>
        </div>
    </div>
</div>
<!-- 팝업창 종료 -->

<!-- 팝업창 시작 정탐-->
<div id="resultTrue" class="popup_layer" style="display:none;">
    <div class="popup_box" style=" width: 350px; margin-left: -180px; height: 340px; top: 60%;">
        <div class="popup_top">
            <h1>정탐조치</h1>
        </div>
        <div class="popup_content" style="height: 280px;">
            <div class="content-box" style="height: 220px;">
                <input type="radio" name="processing_flag" value=1 class="edt_sch" style="border: 0px solid #cdcdcd;">&nbsp;삭제 - 삭제할 대상일 경우<br/>
                <input type="radio" name="processing_flag" value=2 class="edt_sch" style="border: 0px solid #cdcdcd;">&nbsp;암호화 - 암호화 대상인 경우<br/>
                <input type="radio" name="processing_flag" value=3 class="edt_sch" style="border: 0px solid #cdcdcd;">&nbsp;마스킹 - 마스킹 대상인 경우<br/>
                <input type="radio" name="processing_flag" value=4 class="edt_sch" style="border: 0px solid #cdcdcd;">&nbsp;기타&nbsp;
                <input type="text" name="" value="" class="hasDatepicker" ><br/>
                조치예정일 : <input type="date" id="selectDate" value="${befDate}" style="text-align: center; margin-top: 10px;" readonly="readonly">
            </div>
        </div>
        <div class="popup_btn">
            <div class="btn_area">
                <button type="button" id="btnResultTrueSave">확인</button>
                <button type="button" id="btnResultTrueCancel">취소</button>
            </div>
        </div>
    </div>
</div>
<!-- 팝업창 종료 -->
	
<!-- 팝업창 시작 오탐-->
<div id="resultFalse" class="popup_layer" style="display:none;">
    <div class="popup_box" style=" width: 350px; margin-left: -180px; height: 340px; top: 60%;">
        <div class="popup_top">
            <h1>오탐조치</h1>
        </div>
        <div class="popup_content" style="height: 280px;">
            <div class="content-box" style="height: 220px;">
                <input type="radio" name="processing_flag" value=5 class="edt_sch" style="border: 0px solid #cdcdcd;">&nbsp;예외처리 - 앞으로 결과를 보여주지 않음<br/>
                <!-- <input type="radio" name="processing_flag" value=5 class="edt_sch" style="border: 0px solid #cdcdcd;" disabled><font color="grey">&nbsp;예외처리</font><br/> -->
                <input type="radio" name="processing_flag" value=6 class="edt_sch" style="border: 0px solid #cdcdcd;">&nbsp;오탐수용 - 결과는 보이나 오탐수용 표시<br/>
                <input type="radio" name="processing_flag" value=7 class="edt_sch" style="border: 0px solid #cdcdcd;">&nbsp;기타&nbsp;
                <input type="text" name="" value="" class="hasDatepicker" ><br/>
            </div>
        </div>
        <div class="popup_btn">
            <div class="btn_area">
                <button type="button" id="btnResultFalseSave">확인</button>
                <button type="button" id="btnResultFalseCancel">취소</button>
            </div>
        </div>
    </div>
</div>
<!-- 팝업창 종료 -->

<!-- 팝업창 시작 : 경로변경 -->
<div id="changePathPopup" class="popup_layer" style="display:none">
    <div class="popup_box" style="width: 1200px; height: 600px; left: 37%; top: 47%;">
        <div class="popup_top">
            <h1 id="title_change"></h1>
        </div>
        <div class="popup_content">
            <div class="content-box" style="height: 500px;">
                <!-- <h2>세부사항</h2>  -->
                <table class="popup_tbl">
                    <colgroup>
                        <col width="130">
                        <col width="*">
                        <col width="130">
                    </colgroup> 
                    <tbody>
                        <tr>
                            <th style="background-color: #f1f1f1;">담당자</th>
                            <td>
                                <input type="hidden" id="change_type" value="">
                                <input type="text" id="user_name" value="" class="edt_sch" style="width: 300px; border: 0px solid #cdcdcd;" readonly>
                                <input type="text" id="ok_user_no" value="" class="edt_sch" style="border: 0px solid #cdcdcd; display:none;" readonly>
                            </td>
                            <td class="btn_area" style="padding: 0px 0px 0px 20px; text-align: left;">
                                <button type="button" id="btnUserSelectPopup" style="margin-bottom: 0px; background: #1898D2; width: 100px;">담당자 지정</button>
                            </td>
                        </tr>
                        <tr id="changePathTr1">
                            <th style="background-color: #f1f1f1;">서버선택</th>
                            <td>
                                <input type="radio" class="edt_sch" name="changeServerChk" id="selectedAllServer" value="all" style="border: 0px solid #cdcdcd;"> 전체서버
                                <input type="radio" class="edt_sch" name="changeServerChk" id="selectedOneServer" value="" style="margin-left:17%; border: 0px solid #cdcdcd;"> 특정서버
                            </td>
                            <td class="btn_area" style="padding: 0px 0px 0px 20px; text-align: left;">
                                <button type="button" id="btnSelectServerPopup" style="margin-bottom: 0px; background: #1898D2; width: 100px;">찾기</button>
                            </td>
                        </tr>
                        <tr>
                            <th style="background-color: #f1f1f1;">선택서버</th>
                            <td colspan="2">
                                <span class="edt_sch" id="selectedServer"></span>
                            </td>
                        </tr>
                        <tr id="changePathTr3">
                            <th style="background-color: #f1f1f1;">변경 경로</th>
                            <td colspan="2">
                                <input type="text" id="inputChangePath" onkeyup="var e=event||window.event; fnChangeLocationAdd(this, e);" style="width: 99%;">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="padding:5px;">
                                <div id="path_change_div" style="width:100%; height:265px; overflow:auto; layout:fixed;">
                                <table id="path_change" style="text-align:left; width:100%;">
                                    <!-- <tbody> 
                                    </tbody> -->
                                </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="popup_btn">
            <div class="btn_area">
                <button type="button" id="btnChangeSave">저장</button>
                <button type="button" id="btnChangeCancel">취소</button>
            </div>
        </div>
    </div>
</div>
<!-- 팝업창 종료 -->

<!-- 팝업창 시작 담당자 지정 -->
<div id="userSelect" class="popup_layer" style="display:none;">
    <div class="popup_box" style="height: 200px;">
        <div class="popup_top">
            <h1>담당자 지정</h1>
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

<!-- 팝업창 시작 : 레포트 -->
<div id="reportPopup" class="popup_layer" style="display:none">
    <div class="popup_box" style="height: 300px !important; margin: -250px 0 0 -130px; width: 320px;">
        <div class="popup_top">
            <h1>리포트 양식 선택</h1>
        </div>
        <div class="popup_content">
            <div class="content-box" style="height: 190px;">
                <div class="bold">
                    <div class="radio_area">
                        <input type="radio" name="rdo_status" id="rdo001" value="E" checked="checked"><label for="rdo001">감사용</label>
                        <input type="radio" name="rdo_status" id="rdo002" value="D"><label for="rdo002">보고용</label>
                        <input type="radio" name="rdo_status" id="rdo003" value="W"><label for="rdo003">업무담당자용</label>
                    </div>
                </div>
            </div>
        </div>
        <div class="popup_btn">
            <div class="btn_area">
                <button type="button" id="btnReportSave">완료</button>
                <button type="button" id="btnReportCancel">취소</button>
            </div>
        </div>
    </div>
</div>

<!-- 팝업창 시작 : 서버 선택 -->
<div id="serverSelect" class="popup_layer" style="display:none;">
    <div class="popup_box" style="height: 510px; width: 350px; margin-left: -180px;">
        <div class="popup_top">
            <h1>서버 선택</h1>
        </div>
        <div class="popup_content">
            <div class="content-box" style="height: 390px;">
                <table id="popupTargetGrid"></table>
                <div id="popupTargetGridPager"></div>
            </div>
        </div>
        <div class="popup_btn">
            <div class="btn_area">
                <button type="button" id="btnHostSelect">선택</button>
                <button type="button" id="btnHostCancel">취소</button>
            </div>
        </div>
    </div>
</div>
<!-- 팝업창 종료 -->

<!-- 팝업창 시작 : 공지 사항 -->
<!-- <div id="noticePopup" class="popup_layer" style="display:none;">
    <div class="popup_box" style="height: 510px; width: 500px; margin-left: -180px;">
        <div class="popup_top">
            <h1>공지 사항</h1>
        </div>
        <div class="popup_content">
            <div class="content-box" style="height: 390px;">
            	fdsfdsfdsfds
            </div>
        </div>
        <div class="popup_btn">
            <div class="btn_area">
                <button type="button" id="btnOK">확인</button>
            </div>
        </div>
    </div>
</div> -->
<!-- 팝업창 종료 -->

<%@ include file="../../include/footer2.jsp"%>

<script type="text/javascript"> 

// 공지사항 팝업 실행
/* $("#noticePopup").show(); */

// 경로예외 예외 처리 Row 추가
function fnLocationAdd(element, e) 
{
    if (e.keyCode != 13) return;
    if (isNull($(element).val())) return;;

    var excepPath = $(element).val();
    var sTag = "";

    sTag += "<tr style='border:none;'>";
    sTag += "    <th style='padding:2px; background: transparent; overflow:hidden; text-align:left;'>" + excepPath + "</th>";
    sTag += "    <td style='padding:0px; background: transparent; height:23px; width:30px;'>";
    sTag += "        <input type='button' value='X' name='button' style='color:#ba1919; border:0 none; background-color:transparent; cursor:pointer; float:center; height:23px;' onclick='fnLocationRemove(this);'>";
    sTag += "    </td>";
    sTag += "</tr>";

    $("#excepPath").append(sTag);
    $(element).val("");
}

// 경로예외 예외 처리 추가된 Row 삭제
function fnLocationRemove(element) 
{
    var excepPathRmv = $(element).parent("td").parent("tr")[0];
    $(excepPathRmv).remove();
}

// 경로변경 예외 처리 Row 추가
function fnChangeLocationAdd(element, e) 
{
    if (e.keyCode != 13) return;
    if (isNull($(element).val())) return;;

    var changePath = $(element).val();
    var sTag = "";

    sTag += "<tr style='border:none;'>";
    sTag += "    <th style='padding:2px; background: transparent; overflow:hidden; text-align:left;'>" + changePath + "</th>"
    sTag += "    <td style='padding:0px; background: transparent; height:23px; width:30px;'>";
    sTag += "        <input type='button' value='X' name='button' style='color:#ba1919; border:0 none; background-color:transparent; cursor:pointer; float:center; height:23px;' onclick='fnLocationRemove(this);'>";
    sTag += "    </td>";
    sTag += "</tr>";

    $("#path_change").append(sTag);
    $(element).val("");
}

// 경로변경 예외 처리 추가된 Row 삭제
function fnChangeLocationRemove(element)
{
    var changePath = $(element).parent("td").parent("tr")[0];
    $(changePath).remove();
}

// 경로 검색
function fnSearchFindSubpath() 
{
    var oPostDt = {};
    oPostDt["target_id"] = $("#hostSelect").val();
    oPostDt["location"]  = $("#searchLocation").val();

    $("#targetGrid").setGridParam({
        url: "${getContextPath}/detection/selectFindSubpath", 
        postData: oPostDt, 
        datatype: "json",
        treedatatype: 'json'
    }).trigger("reloadGrid");
}

// 경로 예외 팝업창 호출
function fnHideExceptionReason()
{
    $("#exceptionReasonPopup").hide();
    var tr = $("#excepPath").children();
    tr.remove();
    $("input:radio[name=serverChk]").prop("checked", false)
    $("input:radio[name=reason]").prop("checked",false);
    target_id = [];
}

// 처리 - 정탐 조치 예정일 날짜 설정
function fnSetActionscheduleDt()
{
    $("#selectDate").datepicker({
        changeYear : true,
        changeMonth : true,
        dateFormat: 'yy-mm-dd',
        defaultDate: +7,
        minDate: 0,
        onSelect: function(dateText) {
            
            if (dateText == null){
                alert("날짜를 선택하세요!");
            } else {
                var getDate = $("#selectDate").datepicker({ dateFormat: 'yy-mm-dd' }).val();
                console.log(getDate);
                $("#selectedDate").val(getDate);
            }
        }
    });

    var scheduledDate = new Date();
    scheduledDate.setDate(scheduledDate.getDate() + 7);
    $("#selectDate").datepicker().datepicker("setDate", scheduledDate);

    var getDate = $("#selectDate").datepicker({ dateFormat: 'yy-mm-dd' }).val();
    $("#selectedDate").val(getDate);
}

// 검출리스트 - 경로 예외 팝업 오픈
function fnOpenExceptionRegist()
{
    $.ajax({
        type: "POST",
        url: "${getContextPath}/detection/selectExceptionDocuNum",
        async : false,
        datatype: "json",
        success: function (result) {
            $('#title_exception').html("경로예외_" + <fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /> + "_" + "${memberInfo.USER_NO}" + "_" + result.SEQ);
        }
    });

    $("#exceptionReasonPopup").show();
    $("#inputExcepPath").focus();
}

// 검출 리스트 - 경로변경 팝업 오픈
function fnOpenChangePath()
{
    var bChange     = false;
    var aChangeList = [];
    var aNameList   = [];
    var aHashIdList = [];
    var sRowID, sStatus;
    var sTargetNm = sTargetId = "";

    $('[name=gridChk]').each(function(index, item){

        if (item.checked) {
            sRowID = $(item).data("rowid");
            sStatus = $("#targetGrid").getCell(sRowID, 'STATUS');

            if ((sStatus == "E") || (sStatus == "W")) {
                bChange = true;
            }

            aChangeList.push(item.value);
            aNameList.push($("#targetGrid").getCell(sRowID, 'SHORTNAME'));
            aHashIdList.push($("#targetGrid").getCell(sRowID, 'ID'));
            sTargetId = $("#targetGrid").getCell(sRowID, 'PID');
            sTargetNm = $("#targetGrid").getCell(sRowID, 'HOST');
        }
    });

    //$("#deletionRegistPopup #path_change").val(aNameList);
    var sTag = "";
    $("#changePathPopup #path_change").html("");
    for (var i = 0; i < aNameList.length; i += 1) 
    {
        sTag  = "<tr style='border:none;' id='"+aHashIdList[i]+"'>";
        sTag += "    <th style='padding:2px; background: transparent; overflow:hidden; text-align:left;'>" + aNameList[i] + "</th>";
        sTag += "    <td style='padding:0px; background: transparent; height:23px; width:30px;'>";
        sTag += "        <input type='button' value='X' name='button' style='color:#ba1919; border:0 none; background-color:transparent; cursor:pointer; float:center; height:23px;' onclick='fnLocationRemove(this);'>";
        sTag += "    </td>";
        sTag += "</tr>";

        $("#changePathPopup #path_change").append(sTag);
    }

    if (bChange) {
        alert("기 변경 등록된 항목이 선택 되었습니다.");
        return;
    }
	
	$('#title_change').html("담당자 변경_" + <fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /> + "_" + "${memberInfo.USER_NO}");

    // 검출리스트에서 체크한것이 없으면
    if (aChangeList.length == 0) {

        $("#change_type").val("add");

        $("#changePathTr1").show();
        $("#changePathTr3").show();
        $("#path_change_div").css("height", "265");

        $("#inputChangePath").focus();
        $("#selectedServer").text('');
        $("#selectedTargetId").val('');
    }
    else {
        $("#change_type").val("select");

        $("#changePathTr1").hide();
        $("#changePathTr3").hide();
        $("#path_change_div").css("height", "244");

        $("#selectedTargetId").val(sTargetId);
        $("#selectedOneServer").val(sTargetNm)

        //$("#selectedServer").text(sTargetNm + "{" + sTargetId + ")");
        $("#selectedServer").text(sTargetNm);
        $("#selectedOneServer").prop("checked", true)
    }

    $("#changePathPopup").show();
}

//검출 리스트 - 경로변경 저장 
function fnSaveChange() 
{
    var aHashId = [];
    var aPathChangeEx = [];
    //var tbody = $("#path_change").children();
    //var tr = tbody.children();
    var tbody = $("#changePathPopup #path_change");
    var tr = tbody.children();

    $(tr).each(function(index, item){
        var sItemTxt = (tr.eq(index).text()+"").trim();
        if (!isNull(sItemTxt)) {
            aPathChangeEx.push(sItemTxt);
            aHashId.push(item.id);
        }
    });

    if (aPathChangeEx.length <= 0) {
        alert("변경 경로를 입력하세요");
        jQuery("#path_change").focus();
        return false;
    }

    var confirmer = $("#ok_user_no").val();

    if ( ! confirmer ) {
        alert("결재자를 선택하세요.");
        return false;
    }
    
    var aTargetId = [];
    var aPathExScope = [];
    
    // 전체서버 선택하면 모든 target id 들어가야함
    var selectedServer = $("input:radio[name=changeServerChk]:checked").val();

    if (selectedServer == "all") {
    
        $.ajax({
            url:"${getContextPath}/target/selectUserTargetList",
            type : "POST",          
            datatype: "json",
            async : false,
            success: function (data) {
                var arr = [];
                if (data.length > 0) {
                    $.each(data, function (i, s) {
                        arr.push(s);
                        aTargetId.push(arr[i].TARGET_ID);
                        aPathExScope.push(arr[i].AGENT_NAME);
                    });
                }
            }
        });
    } 
    else {
        aTargetId.push($("#selectedTargetId").val());
        aPathExScope.push(selectedServer);
    }

    if (!selectedServer) {
        alert("경로변경을 적용할 서버를 선택하세요.");
        $("input:radio[name=changeServerChk]").prop("checked",false);
        jQuery('input[name="changeServerChk"]').focus();
        return false;
    }
    
    if (aPathChangeEx.length > aHashId.length) {
        for (var a = 1; a = (aPathChangeEx.length - aHashId.length); a++) {
            aHashId.push("");
        }
    }

    var oPostDt = {};
    oPostDt["change_type"] = $("#change_type").val()
    oPostDt["target_id"]   = aTargetId;
    oPostDt["hash_id"]     = aHashId;
    oPostDt["path"]        = aPathChangeEx;
    oPostDt["ok_user_no"]  = $("#ok_user_no").val();

    var oJson = JSON.stringify(oPostDt);
    
    $.ajax({
        type: "POST",
        url: "${getContextPath}/detection/registChange",
        async : false,
        data : oJson,
        contentType: 'application/json; charset=UTF-8',
        success: function (result) {
    
            if (result.resultCode != "0") {
                alert("변경 처리 등록을 실패 하였습니다.");
                return;
            }
    
            $("#targetGrid").setGridParam({
                url:"${getContextPath}/detection/selectFindSubpath",
                postData: $("#targetGrid").getGridParam('postData'),
                datatype:"json",
                treedatatype : 'json'
            }).trigger("reloadGrid");
    
            alert("변경 처리를 등록 하였습니다.");
        },
        error: function (request, status, error) {
            alert("변경 처리 등록을 실패 하였습니다.");
        }
    });
    
    $("#changePathPopup").hide();
    var tr = $("#path_change").children();
    tr.remove();
    
    $("input:radio[name=changeServerChk]").prop("checked", false)
    $("input:radio[name=changeServerChk]").val("");
    $("#user_name").val("");
}

// 검출 리스트 - 처리 팝업 오픈
function fnOpenDeletionRegist()
{
    $.ajax({
        type: "POST",
        url: "${getContextPath}/detection/selectProcessDocuNum",
        async: false,
        datatype: "json",
        success: function (result) {
            $('#title_process').html("처리_" + <fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /> + "_" + "${memberInfo.USER_NO}" + "_" + result.SEQ);
        }
    });

    var aDeletionList = [];
    var aNameList = [];
    var sRowID;

    $('[name=gridChk]').each(function(i, item){
    	if (item.checked) {
            var sRowID = $(item).data("rowid");
            aDeletionList.push(item.value);

            aNameList.push($("#targetGrid").getCell(sRowID, 'SHORTNAME'));
        }
    });

    if (aDeletionList.length == 0) {
        alert("처리 항목을 선택하세요.");
        return;
    }

    //$("#deletionRegistPopup #path_exception").val(aNameList);
    var tr = $("#path_exception").children();
    tr.remove();

    for (var i = 0; i < aNameList.length; i += 1) 
    {
        sTag  = "<tr style='border:none;'>";
        sTag += "    <th style='padding:2px; background: transparent; overflow:hidden; text-align:left;'>" + aNameList[i] + "</th>";
        sTag += "</tr>";

        $("#deletionRegistPopup #path_exception").append(sTag);
    }

    $("#deletionRegistPopup").show();
}

// 검출리스트 - 처리 저장
function fnSaveDeletion()
{
    var aDeletionList = [];

    $('[name=gridChk]').each(function(i, item){
        if (item.checked) {
            aDeletionList.push(item.value);
        }
    });

    if (aDeletionList.length == 0) {
        alert("처리 항목을 선택하세요.");
        return;
    }

    var next_date_remedi = $("#selectedDate").val();
    var sFlag = $("input:radio[name=trueFalseChk]").val();
    if(!sFlag) {
    	alert("사유를 선택하십시오");
    	return false;
    }
    var sProcessFlag;

    switch(sFlag) {
        case "1": sProcessFlag = '정탐(삭제)'; break;
        case "2": sProcessFlag = '정탐(암호화)'; break;
        case "3": sProcessFlag = '정탐(마스킹)'; break;
        case "4": sProcessFlag = '정탐(기타)'; break;
        case "5": sProcessFlag = '오탐(예외처리)'; break;
        case "6": sProcessFlag = '오탐(오탐수용)'; break;
        case "7": sProcessFlag = '오탐(기타)'; break;
    }

    var sChargeId;

    $('#title_process').html("처리_" + <fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /> + "_" + "${memberInfo.USER_NO}" + "_");
    var sChargeNm = sProcessFlag + document.getElementById('title_process').innerHTML;
    var oPostDt = {};
    oPostDt["deletionList"]             = aDeletionList;
    oPostDt["processing_flag"]          = sFlag;
    oPostDt["data_processing_name"]     = sChargeNm;
    oPostDt["next_date_remedi"]         = next_date_remedi;

    var oJson = JSON.stringify(oPostDt);

    $.ajax({
        type: "POST",
        url: "${getContextPath}/detection/registProcess",
        async : false,
        data : oJson,
        contentType: 'application/json; charset=UTF-8',
        success: function (result) {

            if (result.resultCode != "0") {
                alert(result.resultCode + "처리 등록을 실패 하였습니다.");
                return;
            }

            $("#targetGrid").setGridParam({
                url: "${getContextPath}/detection/selectFindSubpath",
                postData: $("#targetGrid").getGridParam('postData'),
                datatype: "json",
                treedatatype: 'json'
            }).trigger("reloadGrid");

            alert("처리를 등록 하였습니다.");

            $("#deletionRegistPopup").hide();
            $("input:radio[name=trueFalseChk]").prop("checked",false);
            $("input:radio[name=processing_flag]").prop("checked",false);
            return;
        },
        error: function (request, status, error) {
            alert("처리 등록을 실패 하였습니다.");

            $("input:radio[name=trueFalseChk]").prop("checked",false);
            $("input:radio[name=processing_flag]").prop("checked",false);
            return;
        }
    });

    $("input:radio[name=trueFalseChk]").prop("checked",false);
    $("input:radio[name=processing_flag]").prop("checked",false);
    $("#deletionRegistPopup").hide();
}

// 검출 리스트 - 경로예외 저장
function fnSaveExceptionRegist()
{
    var aPathEx = [];
    var tbody = $("#excepPath").children();
    var tr = tbody.children();

    $(tr).each(function(index, item){
        var sItemTxt = $(item).text().trim();
        if (!isNull(sItemTxt))
            aPathEx.push(sItemTxt);
    });

    if (aPathEx.length <= 0) {
        alert("예외처리 경로를 입력하세요");
        jQuery("#excepPath").focus();
        return false;
    }

    var selectedRadio = $("input:radio[name=reason]:checked").val();

    if (!selectedRadio) {
        alert("사유를 선택하세요.");
        jQuery('input[name="reason"]').focus();
        return false;
    }

    var sPathExFlag = selectedRadio.toString();

    var aTargetId = [];
    var aTargetId2 = [];
    var aPathExScope = [];
    var aExScope = [];

    // 전체서버 선택하면 모든 target id 들어가야함
    var selectedServer = $("input:radio[name=serverChk]:checked").val();

    if (selectedServer == "all") {

        $.ajax({
            url: "${getContextPath}/target/selectUserTargetList",
            type: "POST",          
            datatype: "json",
            async: false,
            success: function (data) {
                var arr = [];
                if (data.length > 0) {
                    $.each(data, function (i, s) {
                        arr.push(s);
                        aTargetId2.push(arr[i].TARGET_ID);
                        aExScope.push(arr[i].AGENT_NAME);
                    });
                }
            }
        });

        aTargetId = aTargetId2;
        aPathExScope = aExScope;
    } 
    else {
        aTargetId.push($("#selectedTargetId").val());
        aPathExScope.push(selectedServer);
    }

    if (!selectedServer) {
        alert("적용범위를 선택하세요.");
        $("input:radio[name=serverChk]").prop("checked",false);
        jQuery('input[name="serverChk"]').focus();
        return false;
    }

    var sChargeId;

    $('#title_exception').html("경로예외_" + <fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /> + "_" + "${memberInfo.USER_NO}" + "_");
    var sChargeNm = document.getElementById('title_exception').innerHTML;

    var oPostDt = {};
    oPostDt["path_ex"] = aPathEx;
    oPostDt["path_ex_flag"] = sPathExFlag;
    oPostDt["path_ex_group_name"] = sChargeNm;
    oPostDt["ok_user_no"] = $("#ok_user_no").val();
    oPostDt["path_ex_scope"] = aPathExScope;
    oPostDt["target_id"] = aTargetId;

    var oJson = JSON.stringify(oPostDt);

    $.ajax({

        type: "POST",
        url: "${getContextPath}/detection/registPathException",
        async: false,
        data: oJson,
        contentType: 'application/json; charset=UTF-8',
        success: function (result) {
            if (result.resultCode != "0") {
                alert("예외처리 등록을 실패 하였습니다.");
                return;
            }

            $("#targetGrid").setGridParam({
                url: "${getContextPath}/detection/selectFindSubpath", 
                postData: $("#targetGrid").getGridParam('postData'),
                datatype: "json",
                treedatatype: 'json'
            }).trigger("reloadGrid");

            alert("예외처리를 등록 하였습니다.");
            $("#exceptionReasonPopup").hide();
        },
        error: function (request, status, error) {
            alert("예외처리 등록을 실패 하였습니다.");

            var tr = $("#excepPath").children();
            tr.remove();

            $("input:radio[name=reason]").prop("checked",false);
            $("input:radio[name=serverChk]").prop("checked",false);
            $("#selectedTargetId").val("");
            $("input:radio[name=serverChk]").val("");

            aTargetId = [];
        }
    });

    $("#resultTrue").hide();
    var tr = $("#excepPath").children();
    tr.remove();

    $("input:radio[name=reason]").prop("checked",false);
    $("input:radio[name=serverChk]").prop("checked",false);
    $("#selectedTargetId").val("");
    $("input:radio[name=serverChk]").val("");

    aTargetId = [];
}

// 검출 리스트 그리드 CheckBox 생성
function createCheckbox(cellvalue, options, rowObject) 
{
    var value = rowObject['ID'];
    var str = "<input type=\"checkbox\" name=\"gridChk\" value="+ rowObject['ID'] +" data-rowid=" + options['rowId'] + ">";

    if (rowObject['LEVEL'] == "1") return str;
    else return "";
}

function loadTargetGrid(oGrid)
{
    // 검출 리스트 그리드 호출
    var oPostDt = {};
    oPostDt["target_id"] = $("#hostSelect").val();
    oPostDt["location"]  = $("#searchLocation").val();

    oGrid.jqGrid({
        url: "${getContextPath}/detection/selectFindSubpath",
        // pi_exeption approval_status 예외등록상태임  ??
        // pi_deletion DEL_STATUS 삭제등록상태            ??
        postData : oPostDt,
        datatype: "json",
        mtype : "POST",
        ajaxGridOptions : {
            type    : "POST",
            async   : true
        },
        colNames:['','경 로','호스트','소유자','주민</br>번호','외국인번호','여권번호','운전번호','계좌번호','카드번호','합계','처리상태','처리상태코드','처리분류코드','처리분류코드명','(하위포함)결재상태','(하위포함)결재분류','LEVEL','ID','PID'],
        colModel: [
            { index: 'CHK',             name: 'CHK',            width: 35,  align: 'center', editable: true, edittype: 'checkbox', classes: 'pointer',
                editoptions: { value: "1:0" }, formatoptions: { disabled: false }, formatter: createCheckbox, sortable: false},
            { index: 'SHORTNAME',       name: 'SHORTNAME',      width: 550, align: 'left', sortable: false},
            { index: 'HOST',            name: 'HOST',           width: 170, align: 'center', sortable: false},
            { index: 'OWNER',           name: 'OWNER',          width: 170, align: 'center', sortable: false},
            { index: 'TYPE1',           name: 'TYPE1',          width: 70,  align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: false},
            { index: 'TYPE2',           name: 'TYPE2',          width: 70,  align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: false},
            { index: 'TYPE3',           name: 'TYPE3',          width: 70,  align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: false},
            { index: 'TYPE4',           name: 'TYPE4',          width: 70,  align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: false},
            { index: 'TYPE5',           name: 'TYPE5',          width: 70,  align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: false},
            { index: 'TYPE6',           name: 'TYPE6',          width: 70,  align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: false},
            { index: 'TYPE',            name: 'TYPE',           width: 70,  align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: false},
            //{ index: 'DEL_STATUS',    name: 'DEL_STATUS',     width: 100, align: 'center', formatter:'select', editoptions:{value:{'N':'처리 대기','W':'처리 등록','E':'처리 완료', 'D':'처리 반려'}}, sortable: false},
            { index: 'APPROVAL_STATUS_PRINT_NAME',  name: 'APPROVAL_STATUS_PRINT_NAME', width: 100, align: 'left', sortable: false},
            { index: 'APPROVAL_STATUS',             name: 'APPROVAL_STATUS',            width: 1, hidden:true},   // {'N':'처리 대기','W':'처리 등록','E':'처리 완료', 'D':'처리 반려'}
            { index: 'PROCESSING_FLAG',             name: 'PROCESSING_FLAG',            width: 1, hidden:true},   // 1            2           3       4           5           6           7
            { index: 'PROCESSING_FLAG_NAME',        name: 'PROCESSING_FLAG_NAME',       width: 1, hidden:true},   // 정탐(삭제), 정탐(암호화), 정탐(마스킹), 정탐(기타), 오탐(예외처리), 오탐(오탐수용), 오탐(기타)
            { index: 'LINK_APPROVAL_STATUS',        name: 'LINK_APPROVAL_STATUS',       width: 1, hidden:true},   // 하위정보의 결재상태까지 표시(정/오탐)
            { index: 'LINK_PROCESSING_FLAG',        name: 'LINK_PROCESSING_FLAG',       width: 1, hidden:true},   // 하위정보의 결재분류까지 표기(정/오탐)
            { index: 'ID',              name: 'ID',             width: 1, hidden:true, key:true},
            { index: 'PID',             name: 'PID',            width: 1, hidden:true},
            { index: 'LEVEL',           name: 'LEVEL',          width: 1, align: 'center', hidden:true}
        ],
        loadonce :true,
        viewrecords: true,    // show the current page, data rang and total records on the toolbar
        
        width: oGrid.parent().width(),
        height: 621,
        loadonce: true,       // this is just for the demo
        shrinkToFit: true,
        rownumbers : false,   // 행번호 표시여부
        rownumWidth : 75,     // 행번호 열의 너비  
        rowNum:1000000,
        // multiselect:true,
        // rowList:[10,20,30],          
        // pager: "#targetGridPager",
        // enable tree grid
        treeGrid:true,
        treeGridModel :"adjacency",
        ExpandColumn :"SHORTNAME", // 해당 컬럼에 tree 처리
        ExpandColClick: true,
        //caption: "Tree Grid Example",
        treeReader :{
            level_field :"LEVEL",
            parent_id_field :"PID", // 부모 ID값
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
            var isLeaf = $(this).getCell(rowid, 'LEAF');

            if (isLeaf == "true") {
                var id = $(this).getCell(rowid, 'ID');
                var oPostDt = {id : id};
                $.ajax({
                    type: "POST",
                    url: "/exception/getMatchObjects",
                    async : true,
                    data : oPostDt,
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
            // 데이터 로드 완료 시 이벤트
            var ids = $('#targetGrid').getDataIDs();
            if (ids.length > 0) {
                for(var i=0 ; i<ids.length ; i++){
                    var rowid = ids[i];
                    var dtObj = $('#targetGrid').getRowData(rowid);
                    if (dtObj.APPROVAL_STATUS != '' || dtObj.PROCESSING_FLAG != '') {
                        //$('#targetGrid').jqGrid('setRowData', rowid, false, {background:'#C0C0C0'});      // background color
                        $('#targetGrid').setRowData(rowid,  false, 'myclass');      // font color
                        $("#"+rowid).find(':checkbox').attr('disabled', true);
                        $("#"+rowid).find(':checkbox').attr('style', 'visibility:hidden');
                    }
                }
            }
        }
    });
}

$(document).ready(function () {

    // 처리 - 정탐 조치 예정일 날짜 설정
    fnSetActionscheduleDt();

    $("#userGridPager_left").css("width", "10px");
    $("#userGridPager_right").css("display", "none");

    $("#taskWindowClose").click(function(e){
        $("#taskWindow").hide();
    });
    
    // 조회
    $("#btnSearch").click(function(e){
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

    // 조회
    $("#searchLocation").keyup(function(e){
        if (e.keyCode == 13) {
            fnSearchFindSubpath();
        }
    });

    // 호스트 선택시 파일 검색해서 가져옴
    $("#hostSelect").change(function(e){
        $("#targetGrid").clearGridData();
        $("#searchLocation").val("");

        fnSearchFindSubpath();
    });

    // 검출리스트 - 경로 예외 팝업 오픈
    $("#btnExceptionRegist").click(function(e) {
        fnOpenExceptionRegist();
    });

    // 특정서버 라디오버튼 선택 후 '찾기'버튼 활성화
    $("#btnServerSelectPopup").prop("disabled", true);
    $("#oneserver").click(function(e) {
        $("#btnServerSelectPopup").prop("disabled", false);
    });

    // 검출리스트 - 경로예외 - 서버선택  팝업
    $("#btnServerSelectPopup").click(function(e) {
        $("#serverSelect").show();

        $("#popupTargetGrid").jqGrid({
            url:"${getContextPath}/target/selectUserTargetList",
            datatype: "local",
            mtype : "POST",
            ajaxGridOptions : {
                type    : "POST",
                async   : true
            },
            colNames:['호스트 이름', 'TARGET_ID'
            ],
            colModel: [      
                { index: 'AGENT_NAME', name: 'AGENT_NAME', width: 150 },
                { index: 'TARGET_ID',   name: 'TARGET_ID',  width: 1, hidden : true }
            ],
            loadonce: true,          // this is just for the demo
            viewrecords: true,       // show the current page, data rang and total records on the toolbar
            height: 295,
            autowidth: true,
            shrinkToFit: true,
            rownumbers : true,       // 행번호 표시여부
            rownumWidth : 35,        // 행번호 열의 너비   
            rowNum:25,
            rowList:[25,50,100],
        });

        $("#popupTargetGrid").click(function() {
            var list = $("#popupTargetGrid").getGridParam("selrow");
            var row = $("#popupTargetGrid").getRowData(list);
            var rowAgentName = row['AGENT_NAME']
            var rowTargetId = row['TARGET_ID']

            console.log("row AGENT_NAME : " + rowAgentName);
            console.log("row TARGET_ID : " + rowTargetId);

            $("#selectedTargetId").val(rowTargetId);
            $("input:radio[name=serverChk]").val(rowAgentName);
        })

        $("#popupTargetGrid_left").css("width", "10px");
        $("#popupTargetGrid_right").css("display", "none");

        if ($("#popupTargetGrid").width() != 0) {
            $("#popupTargetGrid").setGridParam({
                url: "${getContextPath}/target/selectUserTargetList", 
                datatype: "json"
            }).trigger("reloadGrid");
        }

        $("#btnHostSelect").on("click", function(e) {
            var check = $("input:radio[name=serverChk]").val();

            if (!check) {
                alert("서버를 선택하세요.");
                return false;
            }

            $("#serverSelect").hide();
        });

        // 검출리스트 - 경로예외 - 서버선택  팝업 - 취소
        $("#btnHostCancel").click(function(e) {
            $("input:radio[name=serverChk]:checked").val("");
            $("input:radio[name=serverChk]").prop("checked", false);
            $("#btnServerSelectPopup").prop("disabled", true);
            $("#serverSelect").hide();
            $("#selectedTargetId").val('');
        });
    });

    $("#allserver").click(function(e) {
        $("#allserver").val('all');
        $("#oneserver").val('');
    })

    // 검출리스트 - 경로예외 - 저장
    $("#btnSave").on("click", function(e) {
        fnSaveExceptionRegist();
    });
    
    // 검출리스트 - 경로예외 - 취소버튼
    $("#btnCancel").on("click", function(e) {
        fnHideExceptionReason();
    });

/*------------------------------- 검출 리스트 처리 관련 -------------------------------*/

    // 검출 리스트 - 처리 버튼
    $("#btnDeletionRegist").on("click", function(e) {
        fnOpenDeletionRegist();
    });
    
    // 검출리스트 - 처리 - 정탐/오탐 팝업
    $("#selectReasonTrue").click(function(){
        $("#resultTrue").show();
    
    });

    $("#selectReasonFalse").click(function(){
        $("#resultFalse").show();
    });

    // 검출리스트 - 처리 - 정탐 팝업 - 확인버튼
    $("#btnResultTrueSave").on("click", function(e) {
        var checkedradio = $("input:radio[name=processing_flag]:checked").val();
        var selectedDate = $("#selectedDate").val();

        if ( ! checkedradio ) {
            alert("사유를 선택하세요.");
            jQuery('input[name="processing_flag"]').focus();
            return false;
        }

        $("input:radio[name=trueFalseChk]").val(checkedradio);
        $("input:radio[name=processing_flag]").prop("checked",false);
        $("#resultTrue").hide();
        return;
    });

    // 검출리스트 - 처리 - 오탐 팝업 - 확인버튼
    $("#btnResultFalseSave").on("click", function(e) {
        var checkedradio = $("input:radio[name=processing_flag]:checked").val();
        
        if ( ! checkedradio ) {
            alert("사유를 선택하세요.");
            jQuery('input[name="processing_flag"]').focus();
            return false;
        }
        
        $("input:radio[name=trueFalseChk]").val(checkedradio);
        $("input:radio[name=processing_flag]").prop("checked",false);
        $("#resultFalse").hide();
        return;
    });
    
    
    // 검출리스트 - 처리 - 오탐 팝업 - 취소 버튼
    $("#btnResultFalseCancel").on("click", function(e) {
        $("input:radio[name=trueFalseChk]").prop("checked",false);
        $("input:radio[name=processing_flag]").prop("checked",false);
        $("#resultFalse").hide();
    });
    
    // 검출리스트 - 처리 - 정탐 팝업 - 취소 버튼
    $("#btnResultTrueCancel").on("click", function(e) {
        $("input:radio[name=trueFalseChk]").prop("checked",false);
        $("input:radio[name=processing_flag]").prop("checked",false);
        $("#resultTrue").hide();
    });

    // 검출 리스트 - 처리 - 저장
    $("#btnDeletionSave").on("click", function(e) {
        fnSaveDeletion();
    });

    // 검출리스트 - 처리 - 취소 버튼
    $("#btnDeletionCancel").on("click", function(e) {
        $("input:radio[name=trueFalseChk]").prop("checked",false);
        $("input:radio[name=processing_flag]").prop("checked",false);
        $("#deletionRegistPopup").hide();
    });

/*------------------------------- 검출 리스트 경로변경 관련 -------------------------------*/

    // 검출리스트 - 경로변경 
    $("#btnChangePath").click(function(e) {
        fnOpenChangePath();
    });

    // 검출리스트 - 경로변경 - 취소
    $("#btnChangeCancel").click(function(e) {
        $("#changePathPopup").hide();
        var tr = $("#path_change").children();
        tr.remove();

        $("input:radio[name=changeServerChk]").prop("checked", false)
        $("input:radio[name=changeServerChk]").val("");
        $("#user_name").val("");
    });

    // 검출리스트 - 경로변경 - 담당자 선택
    $("#btnUserSelectPopup").click(function(e) {

        if (isNull($("#selectedTargetId").val())) {
            alert("적용할 서버를 선택하여 주십시요.");
            return;
        }

        $("#userSelect").show();

        if ($("#userGrid").width() == 0) {
            $("#userGrid").jqGrid({
                url: "${getContextPath}/detection/selectTeamMember",
                datatype: "json",
                data: JSON.stringify({ type: "change" }),
                contentType: 'application/json; charset=UTF-8',

                mtype : "POST",
                ajaxGridOptions : {
                    type    : "POST",
                    async   : true
                },
                colNames:['부서','담당자','직책', '사번'],
                colModel: [
                	{ index: 'TEAM_NAME',   name: 'TEAM_NAME',  width: 180, align: 'center' },
                	{ index: 'USER_NAME',   name: 'USER_NAME',  width: 180, align: 'center' },
                    { index: 'JIKGUK',      name: 'JIKGUK',     width: 180, align: 'center' },
                    { index: 'USER_NO',     name: 'USER_NO',    width: 180, align: 'center', hidden: true }
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
                    $("#user_name").val(user_name + " " + jikguk);
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
                url:"${getContextPath}/detection/selectTeamMember", 
                datatype:"json"
            }).trigger("reloadGrid");
        }
    });
    
    // 결재 요청 - 담당자 선택 취소
    $("#btnUserCancel").on("click", function(e) {
        $("#ok_user_no").val('');
        $("#userSelect").hide();
    });

    // 결재 요청 - 담당자 선택 - 선택
    $("#btnUserSelect").on("click", function(e) {

        var rowid = $("#userGrid").getGridParam("selrow");
        var user_name = $("#userGrid").getCell(rowid, 'USER_NAME'); 
        var jikguk = $("#userGrid").getCell(rowid, 'JIKGUK'); 
        var user_no = $("#userGrid").getCell(rowid, 'USER_NO');

        $("#ok_user_no").val(user_no);
        $("#user_name").val(user_name + " " + jikguk + " (" + user_no + ")");
        $("#userSelect").hide();

        console.log($("#ok_user_no").val());
    });
    
    // 검출리스트 - 경로변경 - 서버선택  팝업
    $("#btnSelectServerPopup").on("click", function(e) {
        $("#serverSelect").show();

        $("#popupTargetGrid").jqGrid({
            url:"${getContextPath}/target/selectUserTargetList",
            datatype: "local",
            mtype : "POST",
            ajaxGridOptions : {
                type    : "POST",
                async   : true
            },
            colNames:['호스트 이름', 'TARGET_ID'
            ],
            colModel: [      
                { index: 'AGENT_NAME', name: 'AGENT_NAME', width: 150 },
                { index: 'TARGET_ID',   name: 'TARGET_ID',  width: 1, hidden : true }
            ],
            loadonce: true, // this is just for the demo
            viewrecords: true, // show the current page, data rang and total records on the toolbar
            height: 295,
            autowidth: true,
            shrinkToFit: true,
            rownumbers : true, // 행번호 표시여부
            rownumWidth : 35, // 행번호 열의 너비  
            rowNum:25,
            rowList:[25,50,100]
        });
        
        $("#popupTargetGrid").click(function() {
            var list = $("#popupTargetGrid").getGridParam("selrow");
            var row = $("#popupTargetGrid").getRowData(list);
            var rowAgentName = row['AGENT_NAME']
            var rowTargetId = row['TARGET_ID']

            $("#selectedTargetId").val(rowTargetId);
            $("input:radio[name=changeServerChk]").val(rowAgentName);
            $("#selectedServer").text(rowAgentName);

            console.log("row AGENT_NAME : " + rowAgentName);
            console.log("row TARGET_ID : " + rowTargetId);
        })
        
        $("#popupTargetGrid_left").css("width", "10px");
        $("#popupTargetGrid_right").css("display", "none");

        if ($("#popupTargetGrid").width() != 0) {
            $("#popupTargetGrid").setGridParam({
                url:"${getContextPath}/target/selectUserTargetList", 
                datatype:"json"
            }).trigger("reloadGrid");
        }

        $("#btnHostSelect").click(function(e) {
            var check = $("input:radio[name=changeServerChk]").val();

            if (!check) {
                alert("서버를 선택하세요.");
                return false;
            }

            $("#serverSelect").hide();
        })
    });

    // 검출리스트 - 경로변경 - 서버선택  팝업 - 취소
    $("#btnSelectServerPopup").prop("disabled", true);
    $("#btnHostCancel").click(function(e) {
        $("input:radio[name=changeServerChk]:checked").val("");
        $("input:radio[name=changeServerChk]").prop("checked", false);
        $("#btnSelectServerPopup").prop("disabled", true);
        $("#serverSelect").hide();
        $("#selectedServer").text('');
    });

    $("#selectedOneServer").click(function(e) {
        $("#selectedOneServer").val('');
        $("#selectedServer").text('');
        $("#btnSelectServerPopup").prop("disabled", false);
    })
    
    $("#selectedAllServer").click(function(e) {
        $("#selectedAllServer").val('all');
        $("#selectedServer").text('전체서버(ALL)');
        $("#selectedTargetId").val('all');
        $("#selectedOneServer").val('');
        $("#btnSelectServerPopup").prop("disabled", true);

        console.log($("input:radio[name=changeServerChk]:checked").val())
    })

    // 검출리스트 - 경로변경 - 저장
    $("#btnChangeSave").click(function(e) {
        fnSaveChange();
    });

    // 레포트 팝업 관련
    $("#btnReport").on("click", function(){
        $("#reportPopup").show();
    });

    $("#btnReportCancel").on("click", function(e) {
        $("#reportPopup").hide();
    });
    
 	// 공지사항 팝업 관련
    /* $("#btnOK").click(function(e) {
    	$("#noticePopup").hide();
    }); */

    loadTargetGrid($("#targetGrid"));
});
</script>

</body>
</html>
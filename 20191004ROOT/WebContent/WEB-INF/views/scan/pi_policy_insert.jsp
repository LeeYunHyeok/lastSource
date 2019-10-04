<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>


		<!-- section -->
		<section>
			<!-- container -->
			<div class="container">
			<%@ include file="../../include/menu.jsp"%>

				<!-- content -->
				<div class="content magin_t45">
					<div class="location_area">
						<p class="location">스캔관리 > 재검색 스캔</p>
					</div>
					<div class="grid_top">
						<h3>재검색 정책</h3>
						<div class="step">
							<ul>
								<li id="li-step2" class="on" style="width: 50%;"><span>1</span>개인정보 유형 선택 </li>
								<li id="li-step3" class="on" style="width: 50%;"><span>1</span>스케쥴 입력 </li>
							</ul>
							<div class="clear"></div>
						</div>
					</div>
					
					<!-- Step2 -->
					<div id="stepContents2" class="step_content" style="display: none; border-top: 1px solid #aca49c; padding-top: 0px;">
						<div class="step_content_cell fl_l padd_r" style="height: 540px; max-height: 70%; overflow-y: auto; width: 50%;">
							<table class="list_tbl2" style="border-top: 0px solid #aca49c; ">
								<caption>개인정보 유형</caption>
								<colgroup>
									<col width="*">
									<col width="35%">
									<col width="100px">
								</colgroup>
								<thead>
									<tr>
										<th>개인정보 유형 이름</th>
										<th>버전</th>
										<th>내용</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${datatypeList}" var="item" varStatus="status">
									<tr>
										<c:if test="${fn:length(item.DATATYPE_ID) == 1}">
										<td class="ta_l">
                                            <c:choose>
                                                <c:when test="${item.CHECKED eq '1'}">
                                                    <input type="checkbox" id="chkDatatype_${item.KEY}" name="chkDatatype" data-version="1" value="${item.DATATYPE_ID[0].DATATYPE_ID}" class="chk_lock" checked><label for="${item.KEY}">${item.DATATYPE_LABEL}</label>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="checkbox" id="chkDatatype_${item.KEY}" name="chkDatatype" data-version="1" value="${item.DATATYPE_ID[0].DATATYPE_ID}" class="chk_lock"><label for="${item.KEY}">${item.DATATYPE_LABEL}</label>
                                                </c:otherwise>
                                            </c:choose>
										</td>
										<td>v${item.VERSION}</td>
										</c:if>
										<c:if test="${fn:length(item.DATATYPE_ID) > 1}">
										<td class="ta_l">
                                            <c:choose>
                                                <c:when test="${item.CHECKED eq '1'}">
                                                    <input type="checkbox" id="chkDatatype_${item.KEY}" name="chkDatatype" data-version="0" value="${item.KEY}" class="chk_lock" checked><label for="${item.KEY}">${item.DATATYPE_LABEL}</label>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="checkbox" id="chkDatatype_${item.KEY}" name="chkDatatype" data-version="0" value="${item.KEY}" class="chk_lock"><label for="${item.KEY}">${item.DATATYPE_LABEL}</label>
                                                </c:otherwise>
                                            </c:choose>
										</td>
										<td>
											<select class="version" name="selDatatype_${item.KEY}" id="selDatatype_${item.KEY}">
											<c:forEach items="${item.DATATYPE_ID}" var="dataTypeItem" varStatus="status">
												<option value="${dataTypeItem.DATATYPE_ID}">v${dataTypeItem.VERSION}</option>
										   </c:forEach>
											</select>
										</td>
										</c:if>
										<td>
										<c:if test="${fn:length(item.DATATYPE_ID) == 1}"> 
											<button type="button" name="button" data-version="1" data-datatypename="${item.DATATYPE_LABEL}" value="${item.DATATYPE_ID[0].DATATYPE_ID}" onclick="fnViewDatatypeDetail(this);">보기</button>
										</c:if> 
										<c:if test="${fn:length(item.DATATYPE_ID) > 1}"> 
											<button type="button" name="button" data-version="0" data-datatypename="${item.DATATYPE_LABEL}" value="${item.KEY}" onclick="fnViewDatatypeDetail(this);">보기</button>
										</c:if> 
										</td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="step_content_cell fl_l padd_r" style="height: 540px; max-height: 70%; overflow-y: auto; width: 50%; float: right;">
							<table class="step_tbl" style="border-top: 0px solid #aca49c;">
								<colgroup>
									<col width="200px">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th>정책 이름</th>
										<td><input type="text" name="policyName" id="policyName" value="" style="width: 500px;"></td>
									</tr>
									<tr>
										<th>정책 버전</th>
										<td><input type="text" name="policyVer" id="policyVer" value="" style="width: 300px;">　
										<input type="checkbox" name="defaultPolicy" id="defaultPolicy" value="now"><label for="defaultPolicy" class="magin_r1">기본 정책 설정</label>
										</td>
									</tr>
									<tr>
										<th>정책 설명</th>
										<td><input type="text" name="policyComment" id="policyComment" value="" style="width: 500px;"></td>
									</tr>
									<tr>
										<th>스케쥴 이름</th>
										<td><input type="text" name="scanLabel" id="scanLabel" value="" style="width: 500px;"></td>
									</tr>
									<tr>
										<th>스케쥴 시작</th>
										<td>
											<div class="in_content">
												<input type="radio" name="rdoStart" id="rdoStart1" value="now" checked><label for="rdoStart1" class="magin_r1">바로시작</label>
											</div>
										</td>
									</tr>
									<tr>
										<th>스케쥴 정지 시간</th>
										<td>
											<div class="in_content">
												<p>스캐줄 정지</p> 
												<input type="checkbox" id="chkPause" name="" value="" class="chk_lock" checked>
												<br />
												<p>시간</p>
												From <input type="text" name="pauseStartTime" id="pauseStartTime" value="08:00" style="text-align: center; width: 100px;">
												<!-- <input type="time" name="" value="" class="magin_r1">  -->  
												&nbsp; &nbsp; &nbsp;To <input type="text" name="pauseEndTime" id="pauseEndTime" value="20:00" style="text-align: center; width: 100px;"> 
												<br />
												<p>요일</p>
												<input type="checkbox" name="rdoDay" id="rdoDay1" value="1"><label for="rdoDay1" style=" padding-right: 10px;">일</label>
												<input type="checkbox" name="rdoDay" id="rdoDay2" value="2" checked><label for="rdoDay2" style=" padding-right: 10px;">월</label>
												<input type="checkbox" name="rdoDay" id="rdoDay3" value="4" checked><label for="rdoDay3" style=" padding-right: 10px;">화</label>
												<input type="checkbox" name="rdoDay" id="rdoDay4" value="8" checked><label for="rdoDay4" style=" padding-right: 10px;">수</label>
												<input type="checkbox" name="rdoDay" id="rdoDay5" value="16" checked><label for="rdoDay5" style=" padding-right: 10px;">목</label>
												<input type="checkbox" name="rdoDay" id="rdoDay6" value="32" checked><label for="rdoDay6" style=" padding-right: 10px;">금</label>
												<input type="checkbox" name="rdoDay" id="rdoDay7" value="64"><label for="rdoDay7" style=" padding-right: 10px;">토</label>
											</div>
										</td>
									</tr>
									<tr>
										<th>CPU 우선 순위</th>
										<td>
											<input type="radio" name="rdoPriority" id="PriorityHigh" value="low" checked><label for="PriorityHigh" class="magin_r1">낮음</label>
											<input type="radio" name="rdoPriority" id="PriorityLow" value="normal"><label for="PriorityLow" class="magin_r1">보통</label>
										</td>
									</tr>
									<tr>
										<th>데이터 사용제한</th>
										<td>
											<input type="checkbox" id="chkThroughput" name="chkThroughput" value="" class="chk_lock">
											<input type="text" id="throughput" value="" class="width10" disabled> MB
										</td>
									</tr>
									<tr>
										<th>메모리 사용제한</th>
										<td>
											<input type="checkbox" id="chkMemory" name="chkMemory" value="" class="chk_lock">
											<input type="text" id="memory" value="" class="width10" disabled> MB
										</td>
									</tr>
									<tr>
										<th>스캔 로그 생성</th>
										<td>
											<input type="checkbox" name="chkTrace" id="chkTrace" value="" checked><label for="chkTrace">생성</label>
										</td>
									</tr>
									<tr>
										<th>스케쥴 임계 시간 설정</th>
										<td>
											<select class="version" name="limitDay" id="limitDay"></select>　일 이내
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div id="btn_area2" class="btn_area2 magin_t1">
						<button type="button" id="btnStepSave">저장</button>
						<button type="button" id="btnCancel3">취소</button>
					</div>
					<!-- Step2 END -->
				</div>
					
			</div>

			<!-- container -->
		</section>
		<!-- section -->
		
<!-- 개인정보 유형보기 모달 --> 
<div id="viewWindow" class="ui-widget-content" style="position:absolute; left: 800px; top: 250px; touch-action: none; 
		border: 1px solid #1F3546; max-width: 500px; z-index: 999; display:none">
	<div class="popup_top" style="cursor: grab;">
		<h1 id="dataTypeName">개인정보 유형이름 v100</h1>
	</div>	
	<div class="popup_content">
		<div class="content-box" style="height: 450px; overflow: hidden;">
			<div class="tab">
			  <button class="tablinks active" onclick="changeTab(event, 'personal')">개인정보 유형</button>
			  <button class="tablinks" onclick="changeTab(event, 'filter')">필터</button>
			  <button class="tablinks" onclick="changeTab(event, 'pattern')">사용자정의 패턴</button>
			  <button class="tablinks" onclick="changeTab(event, 'advanced')">고급기능</button>
			</div>
			
			<div id="personal" class="tabcontent" style="overflow-y: auto;">
			  <p>London is the capital city of England.</p>
			</div>
			
			<div id="filter" class="tabcontent" style="display :none; overflow-y: auto;">
				<table class="user_info" style="">
					<caption>filter 유형</caption>
					<colgroup>
						<col width="50%">
						<col width="50%">
					</colgroup>
					<tbody  id="filterList">
						<tr style="height: 50px;"><th style="text-align: center;">필터유형</th><th style="text-align: center;">내용</th></tr>
					</tbody>
				</table>
			</div>
			
			<div id="pattern" class="tabcontent" style="display :none; overflow-y: auto;">			  
				<table class="user_info" style="">
					<caption>pattern 유형</caption>
					<colgroup>
						<col width="50%">
						<col width="50%">
					</colgroup>
					<tbody  id="patternList">
						<tr style="height: 50px;"><th style="text-align: center;">커스텀 이름</th><th style="text-align: center;">내용</th></tr>
					</tbody>
				</table>
			</div>
			
			<div id="advanced" class="tabcontent" style="display :none; overflow-y: auto;">		  
				<table class="user_info" style="">
					<caption>pattern 유형</caption>
					<colgroup>
						<col width="50%">
						<col width="50%">
					</colgroup>
					<tbody  id="advancedList">
						<tr style="height: 50px;"><th style="text-align: center;">기능</th><th style="text-align: center;">On / Off</th></tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="popup_btn">
		<div class="btn_area" style="border: 1px solid #efefef;">
			<button type="button" id="viewWindowClose" style="background: #1898D2;">확인</button>
		</div>
	</div>
</div>
	
		<!-- footer -->
	<%@ include file="../../include/footer.jsp"%>
		<!-- footer -->

<script type="text/javascript">
var limitDay = [];

for (var i = 1; i < 31; i++) {
	limitDay[i] = "<option value=" + i + ">" + i + "</option>";
}

var aTypeList = "${datatypeList}";
console.log(aTypeList);

$("#limitDay").append(limitDay);

function changeTab(evt, cityName) {
	// Declare all variables
	var i, tabcontent, tablinks;
	
	// Get all elements with class="tabcontent" and hide them
	tabcontent = document.getElementsByClassName("tabcontent");
	for (i = 0; i < tabcontent.length; i++) {
	  tabcontent[i].style.display = "none";
	}
	
	// Get all elements with class="tablinks" and remove the class "active"
	tablinks = document.getElementsByClassName("tablinks");
	for (i = 0; i < tablinks.length; i++) {
	  tablinks[i].className = tablinks[i].className.replace(" active", "");
	}
	
	// Show the current tab, and add an "active" class to the link that opened the tab
	document.getElementById(cityName).style.display = "block";
	evt.currentTarget.className += " active";
}
	
function fnViewDatatypeDetail(element) {
	// dataTypeName

	
	// Datatype의 상세를 보여주기
	var versionType = $(element).data("version");
	var dataTypeName = $(element).data("datatypename");
    var id = $(element).val();
    var datatypeId = id;
    if (versionType == "1") {
    	datatypeId = id;
    	dataTypeName = dataTypeName + " v1";
    }
    else { 
    	var objName = "selDatatype_" + id;
    	datatypeId = $("#" + objName).val();
    	dataTypeName = dataTypeName + " " + $("#" + objName + " option:selected").text();
	}

    $("#dataTypeName").text(dataTypeName);
    
    var postData = {datatypeId : datatypeId};
	$.ajax({
		type: "POST",
		url: "/scan/getProfileDetail",
		async : false,
		data : postData,
	    success: function (resultMap) {
	        if (resultMap.resultCode != 0) {
		        alert("개인정보유형 상세조회에 실패하였습니다.");
	        	return;
		    }

			console.log(resultMap.resultData);

			var builtins = resultMap.resultData.builtins;
			var filters = resultMap.resultData.filters;
			var expressions = resultMap.resultData.custom_expressions;

			var advancedOCR = resultMap.resultData.ocr;
			var advancedVOICE = resultMap.resultData.voice;
			var advancedEBCDIC = resultMap.resultData.ebcdic;
			var advancedSUPPRESS = resultMap.resultData.suppress;
			var advancedCAPTURE = resultMap.resultData.capture;

			// 개인정보유형
			if (!isNull(builtins)) {
				var personal = ["주민등록번호",	"외국인등록번호","운전면허면호","여권번호","사업자등록번호","법인등록번호","계좌번호","신용카드","한국핸드폰번호","이메일주소"];
				var personalItem = ["N","N","N","N","N","N","N","N","N","N"];
				var personalBank = new Array();
				var personalCard = new Array();
				for (var i = 0; i < builtins.length; i++) {
					
					if (builtins[i] == "BANK_SOUTH_KOREA_BANK_ACCOUNT_NH") {personalBank.push("농협은행"); personalItem[6] = "Y";}
					if (builtins[i] == "BANK_SOUTH_KOREA_BANK_ACCOUNT_KB") {personalBank.push("국민은행"); personalItem[6] = "Y";}
					if (builtins[i] == "BANK_SOUTH_KOREA_BANK_ACCOUNT_KEB_HANA") {personalBank.push("KEB하나은행"); personalItem[6] = "Y";}
					if (builtins[i] == "BANK_SOUTH_KOREA_BANK_ACCOUNT_SHINHAN") {personalBank.push("신한은행"); personalItem[6] = "Y";}
					if (builtins[i] == "BANK_SOUTH_KOREA_BANK_ACCOUNT_GWANGJU") {personalBank.push("광주은행"); personalItem[6] = "Y";}
					if (builtins[i] == "BANK_SOUTH_KOREA_BANK_ACCOUNT_JEJU") {personalBank.push("제주은행"); personalItem[6] = "Y";}
					if (builtins[i] == "BANK_SOUTH_KOREA_BANK_ACCOUNT_JEONBUK") {personalBank.push("전북은행"); personalItem[6] = "Y";}
					
					if (builtins[i] == "CHD_AMERICANEXPRESS") {personalCard.push("American Express"); personalItem[7] = "Y";}
					if (builtins[i] == "CHD_DINERSCLUB") {personalCard.push("Diners Club"); personalItem[7] = "Y";}
					if (builtins[i] == "CHD_DISCOVER")	{personalCard.push("Discover"); personalItem[7] = "Y";}
					if (builtins[i] == "CHD_JCB")		{personalCard.push("JCB"); personalItem[7] = "Y";}
					if (builtins[i] == "CHD_MASTERCARD") {personalCard.push("Mastercard"); personalItem[7] = "Y";}
					if (builtins[i] == "CHD_VISA")	{personalCard.push("Visa"); personalItem[7] = "Y";}
					if (builtins[i] == "CHD_CUP") {personalCard.push("China Union Pay"); personalItem[7] = "Y";}
					if (builtins[i] == "CHD_MAESTRO")	{personalCard.push("Maestro"); personalItem[7] = "Y";}
					if (builtins[i] == "CHD_LASER")	{personalCard.push("Laser"); personalItem[7] = "Y";}
					if (builtins[i] == "CHD_TROY")	{personalCard.push("Troy"); personalItem[7] = "Y";}
					if (builtins[i] == "CHD_PRIVATE") {personalCard.push("Private Label Card"); personalItem[7] = "Y";}
					
					if (builtins[i] == "NID_SOUTH_KOREA_RRN") personalItem[0] = "Y"; //주민등록번호  1
					if (builtins[i] == "NID_SOUTH_KOREA_FRN") personalItem[1] = "Y"; //외국인등록번호 2
					if (builtins[i] == "PII_SOUTH_KOREA_DLN") personalItem[2] = "Y"; //운전면허면호 3
					if (builtins[i] == "PII_SOUTH_KOREA_PASSPORT") personalItem[3] = "Y"; //여권번호 4
					if (builtins[i] == "BANK_SOUTH_KOREA_CRN") personalItem[4] = "Y"; //사업자등록번호 5
					if (builtins[i] == "BANK_SOUTH_KOREA_TIN") personalItem[5] = "Y"; //법인등록번호 6
					if (builtins[i] == "PII_SOUTH_KOREA_PHONE") personalItem[8] = "Y"; //한국핸드폰번호 9
					if (builtins[i] == "PII_MISC_EMAIL") personalItem[9] = "Y"; //이메일주소 10
				}
			}
			
			var personalData = "<ul>";
			if (isNull(personal)) {
				$("#personal").html("정의된 개인정보 유형이 없습니다.");
			}
			else {
				for (var i = 0; i < personal.length; i++) {
	
					// 계좌번호의 경우
					if (i == 6) {
						if (isNull(personalBank)) continue;
						personalData += "<li class='personalList' style='list-style: disc;'><a href='javascript:void(0)'><img style='margin-right: 3px; margin-bottom: 3px;' src='${pageContext.request.contextPath}/resources/assets/images/arrow_deactive.png'>";
						personalData += personal[i] + "</a>";
						personalBank.join("<br />");
						personalData += "<ul style='padding: 0px 3px 3px 3px; display:none'><li style='margin-left: 20px;'>" + personalBank.join("<br />") + "</li></ul>";
						personalData += "</li>";
					}
					// 신용카드의 경우
					else if (i == 7) {
						if (isNull(personalCard)) continue;
						personalData += "<li class='personalList' style='list-style: disc;'><a href='javascript:void(0)'><img style='margin-right: 3px; margin-bottom: 3px;' src='${pageContext.request.contextPath}/resources/assets/images/arrow_deactive.png'>";
						personalData += personal[i] + "</a>";
						personalCard.join("<br />");
						personalData += "<ul style='padding: 0px 3px 3px 3px; display:none'><li style='margin-left: 20px;'>" + personalCard.join("<br />") + "</li></ul>";
						personalData += "</li>";
						
					}
					else {
						if (personalItem[i] == "Y") {
							personalData += "<li class='personalList' style='list-style: disc;'>";
							personalData += personal[i];
							personalData += "</li>";
						}
					}
				}
				personalData += "</ul>"
				$("#personal").html(personalData);
				$(".personalList>a").click(function() {
					if ($(this).next('ul').is(':visible')) {
						$(this).children("img").attr("src", '${pageContext.request.contextPath}/resources/assets/images/arrow_deactive.png');
						$(this).next('ul').hide();
					} else {
						$(this).children("img").attr("src", '${pageContext.request.contextPath}/resources/assets/images/arrow_active.png');
						$(this).next('ul').show();
					}
				});
			}
			
			var filterTR = $("#filterList").children("tr");
			$(filterTR).remove();
			var filterData = '<tr style="height: 50px;"><th style="text-align: center; border-right: 1px solid #efefef;">필터유형</th><th style="text-align: center;">내용</th></tr>';
			$("#filterList").append(filterData);
			if (!isNull(filters)) {
				for (var i = 0; i < filters.length; i++) {
					var filterData = "";
					filterData += "<tr>"
					filterData += "<td style=\"text-align: center; border-right: 1px solid #efefef\";>" + filters[i].type + "</td>";
					filterData += "<td style=\"text-align: center;\">" + filters[i].expression + "</td>";
					filterData += "</tr>"
					$("#filterList").append(filterData);
				}
			}
		
			var patternTR = $("#patternList").children("tr");
			$(patternTR).remove();
			var patternData = '<tr style="height: 50px;"><th style="text-align: center; border-right: 1px solid #efefef;">커스텀 이름</th><th style="text-align: center;">내용</th></tr>';
			$("#patternList").append(patternData);
			
			if (!isNull(expressions)) {
				for (var i = 0; i < expressions.length; i++) {
					var patternData = "";
					patternData += "<tr>"
					patternData += "<td style=\"text-align: center; border-right: 1px solid #efefef\";>" + expressions[i].label + "</td>";
					patternData += "<td style=\"text-align: center;\">" + expressions[i].expression + "</td>";
					patternData += "</tr>"
					$("#patternList").append(patternData);
				}
			}

			var advancedTR = $("#advancedList").children("tr");
			$(advancedTR).remove();
			var advancedData = '<tr style="height: 50px;"><th style="text-align: center; border-right: 1px solid #efefef;">기능</th><th style="text-align: center;">On / Off</th></tr>';
			$("#advancedList").append(advancedData);

			var advancedData = "";
			advancedData += "<tr>"
			advancedData += "<td style=\"text-align: center; border-right: 1px solid #efefef\";>OCR</td>";
			if (advancedOCR == true) advancedData += "<td style=\"text-align: center;\"><img src='${pageContext.request.contextPath}/resources/assets/images/switch-on.png'></td>";
			else advancedData += "<td style=\"text-align: center;\"><img src='${pageContext.request.contextPath}/resources/assets/images/switch-off.png'></td>"; 
			advancedData += "</tr>"
			$("#advancedList").append(advancedData);

			var advancedData = "";
			advancedData += "<tr>"
			advancedData += "<td style=\"text-align: center; border-right: 1px solid #efefef\";>VOICE</td>";
			if (advancedVOICE == true) advancedData += "<td style=\"text-align: center;\"><img src='${pageContext.request.contextPath}/resources/assets/images/switch-on.png'></td>";
			else advancedData += "<td style=\"text-align: center;\"><img src='${pageContext.request.contextPath}/resources/assets/images/switch-off.png'></td>"; 
			advancedData += "</tr>"
			$("#advancedList").append(advancedData);

			var advancedData = "";
			advancedData += "<tr>"
			advancedData += "<td style=\"text-align: center; border-right: 1px solid #efefef\";>EBCDIC</td>";
			if (advancedEBCDIC == true) advancedData += "<td style=\"text-align: center;\"><img src='${pageContext.request.contextPath}/resources/assets/images/switch-on.png'></td>";
			else advancedData += "<td style=\"text-align: center;\"><img src='${pageContext.request.contextPath}/resources/assets/images/switch-off.png'></td>"; 
			advancedData += "</tr>"
			$("#advancedList").append(advancedData);

			var advancedData = "";
			advancedData += "<tr>"
			advancedData += "<td style=\"text-align: center; border-right: 1px solid #efefef\";>test data matchs</td>";
			if (advancedSUPPRESS == true) advancedData += "<td style=\"text-align: center;\"><img src='${pageContext.request.contextPath}/resources/assets/images/switch-on.png'></td>";
			else advancedData += "<td style=\"text-align: center;\"><img src='${pageContext.request.contextPath}/resources/assets/images/switch-off.png'></td>"; 
			advancedData += "</tr>"
			$("#advancedList").append(advancedData);

			var advancedData = "";
			advancedData += "<tr>"
			advancedData += "<td style=\"text-align: center; border-right: 1px solid #efefef\";>Capture Data matches</td>";
			if (advancedCAPTURE == true) advancedData += "<td style=\"text-align: center;\"><img src='${pageContext.request.contextPath}/resources/assets/images/switch-on.png'></td>";
			else advancedData += "<td style=\"text-align: center;\"><img src='${pageContext.request.contextPath}/resources/assets/images/switch-off.png'></td>"; 
			advancedData += "</tr>"
			$("#advancedList").append(advancedData);

			$(".tablinks")[0].click();
	    	$("#viewWindow").show();
	    },
	    error: function (request, status, error) {
			alert("Server Error : " + error);
	        console.log("ERROR : ", error);
	    }
	});
}

$(document).ready(function () { 
	
	$("#stepContents2").show();	
	
  	$("#viewWindow").draggable({
 	    containment: '.content',
 	 	cancel : '.popup_content, .popup_btn'
	});
	
	$("#viewWindowClose").click(function(){
		$("#viewWindow").hide();
	});

	$("#btnCancel1, #btnCancel2, #btnCancel3").click(function(){
		window.location = "${pageContext.request.contextPath}/scan/pi_scan_rescan";
	});

	$("#startDate").datepicker({
		changeYear : true,
		changeMonth : true,
		minDate: 0, 
		dateFormat: 'yy-mm-dd'
	});

	var date = new Date();
	var timePicker_options = {
			twentyFour: true,  
			title: '시간을 선택하세요',  
			showSeconds: false,  
			secondsInterval: 1,  
			minutesInterval: 1,  
			timeSeparator: ':',
			clearable: true
		}
			
	$("#startTime").wickedpicker(timePicker_options);
	timePicker_options.now = "08:00";
	$("#pauseStartTime").wickedpicker(timePicker_options);
	timePicker_options.now = "20:00";
	$("#pauseEndTime").wickedpicker(timePicker_options);

	
	$("#chkMemory").change( function(e) {
		if(this.checked) {
			$("#memory").prop('disabled', false);
			$("#memory").val("1024");
		}
		else {
			$("#memory").prop('disabled', true);
			$("#memory").val("");
		}
	});

	$("#chkThroughput").change( function(e) {
		if(this.checked) {
			$("#throughput").prop('disabled', false);
			$("#throughput").val("50");
		}
		else {
			$("#throughput").prop('disabled', true);
			$("#throughput").val("");
		}
	});

	$("#chkPause").on("change", function(e) {
		if ($(this)[0].checked) {
			$("#pauseStartTime").attr( 'disabled', false );
			$("#pauseEndTime").attr( 'disabled', false );
			$("#rdoDay1, #rdoDay2, #rdoDay3, #rdoDay4, #rdoDay5, #rdoDay6, #rdoDay7").attr( 'disabled', false );
		}
		else {
			$("#pauseStartTime").attr( 'disabled', true );
			$("#pauseEndTime").attr( 'disabled', true );
			$("#rdoDay1, #rdoDay2, #rdoDay3, #rdoDay4, #rdoDay5, #rdoDay6, #rdoDay7").attr( 'disabled', true );
			$("#rdoDay1, #rdoDay2, #rdoDay3, #rdoDay4, #rdoDay5, #rdoDay6, #rdoDay7").attr( 'checked', false );
		}
	});	
	
	$("#btnStepSave").on("click", function(e) {
		
		var scheduleData = {};  // Scan Data Mater Json

		var policy_name = $("#policyName").val();
		if (isNull(policy_name)) {
			alert("정책 이름을 입력하세요.");
			return;
		}

		var policy_version = $("#policyVer").val();
		if (isNull(policy_version)) {
			alert("정책 버전을 입력하세요.");
			return;
		}
		
		var policyComment = $("#policyComment").val();
		if (isNull(policyComment)) {
			alert("정책 설명을 입력하세요.");
			return;
		}
		
		var scanLabel = $("#scanLabel").val();
		if (isNull(scanLabel)) {
			alert("스케쥴 이름을 입력하세요.");
			return;
		}
		
		// 기본정책설정 
		var defaultPolicy;
		if ($('input:checkbox[id="defaultPolicy"]').is(":checked")) {
			defaultPolicy = 1;
		}
		else {
			defaultPolicy = 0;
		}
		
		// profile(Datatype) 넣기
		var scheduleArr = new Array(); 
	    $('[name=chkDatatype]').each(function(i, element){
		    if (element.checked) {
			    var versionType = $(element).data("version");
			    var id = $(element).val();
			    if (versionType == "1") {
				    scheduleArr.push(id);
			    }
			    else { 
			    	var objName = "selDatatype_" + id;
			    	scheduleArr.push($("#" + objName).val());
				}
		    }
	    });

		if (scheduleArr.length == 0) {
			alert("개인정보 유형을 선택하세요.");
			return;
		}
		
		var profileArr = scheduleArr.toString();
		console.log("profileArr : " + profileArr);
		
		//Pause
		var pauseFrom;
		var pauseTo;
		var pauseDays;
		var pauseMonth;
		
		if ($('input:checkbox[id="chkPause"]').is(":checked")) {
			var pauseStartTime = $('#pauseStartTime').val();
			var pauseEndTime = $('#pauseEndTime').val();
			pauseFrom = pauseStartTime.split(":")[0] * 60 * 60 + pauseStartTime.split(":")[1] * 60; 
			pauseTo = pauseEndTime.split(":")[0] * 60 * 60 + pauseEndTime.split(":")[1] * 60;
			
			pauseDays = 0;
			$('input:checkbox[name="rdoDay"]:checked').each(function(i, element){
				pauseDays += Number(element.value);
		    });
		}
		
		// CPUs
		var cpu = $('input:radio[name="rdoPriority"]:checked').val();

		//Throughput (data)
		var data;
		if ($('input:checkbox[id="chkThroughput"]').is(":checked")) {
			data = Number($("#throughput").val());
		}
		else {
			data = 0;
		}
		//memory
		var memory;
		if ($('input:checkbox[id="chkMemory"]').is(":checked")) {
			memory = Number($("#memory").val());
		}
		else {
			memory = 0;
		}
		// 스캔 로그
		var trace = false;
		if ($('input:checkbox[id="chkTrace"]').is(":checked")) {
			trace = true;
		}
		else {
			trace = false;
		}
		
		// DMZ (임계시간 설정)
		var dmz = $("#limitDay").val();
		
		var postData = {
				policy_name : policy_name,
				policy_version : policy_version,
				comment: policyComment, 
				label : scanLabel, 
				datatype : profileArr, 
				pauseFrom : pauseFrom, 
				pauseTo : pauseTo, 
				pauseDays : pauseDays, 
				cpu : cpu,
				data : data,
				memory : memory, 
				trace : trace, 
				dmz : dmz,
				default_check : defaultPolicy
				}
			
		
		var tttt = JSON.stringify(postData);
		console.log("postData 확인 : " + tttt);
		
		
		var message = "신규 스캔 스케줄을 등록하시겠습니까?";
		if (confirm(message)) {
			$.ajax({
				type: "POST",
				url: "/scan/registPolicy",
				async : false,
				data : postData,
			    success: function (resultMap) {
			        if (resultMap.resultCode == 0) {
				        alert("신규 정책이 등록되었습니다.");
				        window.location = "${pageContext.request.contextPath}/scan/pi_scan_rescan";
			        	return;
				    } else {
				        alert("신규 스캔 스케줄이 등록이 실패 되었습니다.\n관리자에게 문의 하십시오");
				    }
			    },
			    error: function (request, status, error) {
					alert("Server Error : " + error);
			        console.log("ERROR : ", error);
			    }
			});
		}
	});

	if ("${idx}") {
		searchViewScan("${idx}");
	}
});

</script>
	<!-- wrap -->
</body>
</html>

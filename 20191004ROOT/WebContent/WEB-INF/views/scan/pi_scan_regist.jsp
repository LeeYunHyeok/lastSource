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
						<p class="location">스캔관리 > 스캔 스케쥴 등록</p>
					</div>
					<div class="grid_top">
						<h3>스캔 신규 등록</h3>
						<div class="step">
							<ul>
								<li id="li-step1" class="on"> <span>1</span> 1단계 서버 선택</li>
								<li id="li-step2"> <span>2</span> 2단계 개인정보 유형 선택 </li>
								<li id="li-step3"> <span>3</span> 3단계 스케쥴 입력 </li>
							</ul>
							<div class="clear"></div>
						</div>
					</div>
					<!-- Step1 -->
					<div id="stepContents1" class="step_content" style="border-top: 1px solid #aca49c;">
						<div class="step_content_cell width50 fl_l padd_r" style="height: 520px; max-height: 70%; overflow-y: auto;">
						
							<div class="select_location sch_left" style="height: 60px; min-height: 60px;background: #fff; border-bottom: 0px;">
								<div style="position: absolute; right: 10px; padding-top: 0px; font-size: 18px; font-weight: bold;">
								Host : <input type="text" id="searchHost" value="" class="edt_sch" style="width: 263px;">
								<button id="btnSearch" class="btn_sch" style="margin-top: 5px;">검색</button>
								</div>
							</div>
							<div class="select_location" style="overflow-y: auto; height: 460px;background: #ffffff;">
								<table class="tbl_input">
									<tbody>
										<c:set var="targetid" value =""></c:set><c:set var="targetname" value =""></c:set>
										<c:forEach items="${locationList}" var="item" varStatus="status">
											<c:if test="${item.LEVEL == '1'}">
												<c:choose>
												<c:when test="${target == ''}">
													<tr>
														<th><p id="${item.TARGET_ID}" class="sta_tit" style="cursor:pointer;">${item.NAME}</p></th>
													</tr>
													<c:set var="targetid" value ="${item.TARGET_ID}"></c:set>	
													<c:set var="targetname" value ="${item.NAME}"></c:set>	
												</c:when>
												<c:otherwise>
													<tr>
														<th style="padding-top: 10px;"><p id="${item.TARGET_ID}" class="sta_tit" style="cursor:pointer;">${item.NAME}</p></th>
													</tr>
													<c:set var="targetid" value ="${item.TARGET_ID}"></c:set>	
													<c:set var="targetname" value ="${item.NAME}"></c:set>	
												</c:otherwise>
												</c:choose>
											</c:if>
											
											<c:if test="${item.LEVEL == '2'}">
												<tr name="${targetid}" style="display:none;">
												<td style="padding-bottom: 10px;">
													<input type="checkbox" name="chkLocation" id="${targetid}_${item.LOCATION_ID}" data-targetid="${targetid}" data-targetname="${targetname}" data-locationname="${item.NAME}" data-locationid="${item.LOCATION_ID}" onchange="var e=event||window.event; fnUpdateLocation(this,e);"> 
													<label for="check1">${item.NAME} on target ${targetname}</label>
												<c:if test="${item.LEVEL == locationList[status.index+1].LEVEL}">
														</td>
												</tr>	
												</c:if>
												<c:if test="${item.LEVEL != locationList[status.index+1].LEVEL}">												
													<br>경로 :
													<input type="text" name="loc_${item.TARGET_ID}" value="" data-targetid="${targetid}" data-targetname="${targetname}" style="padding-left: 5px;" class="width85" onkeyup="var e=event||window.event; fnLocationAdd(this, e);">
													<!-- <button type="button" name="button" class="btn_location"></button>  -->
														</td>
													</tr>
												</c:if>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<div class="step_content_cell width50 fl_l display_table" style="height: 520px; padding-left: 30px;">
							<div class="select_location" style="height: 60px; min-height: 60px;background: #bbb;">
								<p id="locationTitle" class="sta_tit2">선택된 경로</p>
							</div>
							<div class="select_location" style="overflow-y: auto; height: 460px;background: #ffffff;">
								<table style="width: 100%;">
								<caption>개인정보 유형</caption>
								<colgroup>
									<col width="*">
									<col width="100px">
								</colgroup>
								<tbody  id="locationList">
								</tbody>
								</table>
							</div>
						</div>
						<div class="clear"></div>
					</div>
					<div id="btn_area1" class="btn_area2 magin_t1">
						<button type="button" id="btnStep1-2">다음</button>
						<button type="button" id="btnCancel1">취소</button>
					</div>
					<!-- Step1 END -->
					
					<!-- Step2 -->
					<div id="stepContents2" class="step_content" style="display: none; border-top: 1px solid #aca49c; padding-top: 0px;">
						<div class="step_content_cell fl_l padd_r" style="height: 540px; max-height: 70%; overflow-y: auto;">
							<table class="list_tbl2" style="border-top: 0px solid #aca49c;">
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
											<input type="checkbox" id="chkDatatype_${item.KEY}" name="chkDatatype" data-version="1" value="${item.DATATYPE_ID[0].DATATYPE_ID}" class="chk_lock"><label for="${item.KEY}">${item.DATATYPE_LABEL}</label>
										</td>
										<td>v${item.VERSION}</td>
										</c:if>
										<c:if test="${fn:length(item.DATATYPE_ID) > 1}">
										<td class="ta_l">
											<input type="checkbox" id="chkDatatype_${item.KEY}" name="chkDatatype" data-version="0" value="${item.KEY}" class="chk_lock"><label for="${item.KEY}">${item.DATATYPE_LABEL}</label>
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
					</div>
					<div id="btn_area2" class="btn_area2 magin_t1" style="display:none">
						<button type="button" id="btnStep2-1">이전</button>
						<button type="button" id="btnStep2-3">다음</button>
						<button type="button" id="btnCancel2">취소</button>
					</div>
					<!-- Step2 END -->
					
					<!-- Step3 -->
					<div id="stepContents3" class="step_content" style="display: none; border-top: 1px solid #aca49c; padding-top: 0px;">
						<div class="step_content_cell fl_l padd_r" style="height: 540px; max-height: 70%; overflow-y: auto;">
							<table class="step_tbl" style="border-top: 0px solid #aca49c;">
								<colgroup>
									<col width="200px">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th>스케쥴 이름</th>
										<td><input type="text" name="scanLabel" id="scanLabel" value="" class="width40"></td>
									</tr>
									<tr>
										<th>스케쥴 예약</th>
										<td>
											<div class="in_content">
												<input type="radio" name="rdoStart" id="rdoStart1" value="now" checked><label for="rdoStart1" class="magin_r1">바로시작</label>
												<input type="radio" name="rdoStart" id="rdoStart2" value="reserv"><label for="rdoStart2">예약</label> <br />
												<p>시작 시간</p>
												<input type="text" name="startDate" id="startDate" value="${today}" class="magin_r1" style="text-align: center; width: 120px;" readonly> 
													At <input type="text" name="startTime" id="startTime" value="" style="text-align: center; width: 100px;" readonly> <br />
												<p>스케쥴 주기</p>
												<select class="version" name="period" id="period">
													<option value="1T">한번만</option>
													<option value="1D">매일</option>
													<option value="7D">매주</option>
													<option value="14D">2주</option>
													<option value="1M">한달</option>
													<option value="6M">6개월</option>
													<option value="12M">1년</option>
												</select>
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
								</tbody>
							</table>
						</div>
					</div>
					<div id="btn_area3" class="btn_area2 magin_t1" style="display:none">
						<button type="button" id="btnStep3-2">이전</button>
						<button type="button" id="btnStepSave">저장</button>
						<button type="button" id="btnCancel3">취소</button>
					</div>
					<!-- Step3 END -->
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
	
function fnLocationAdd(element, e) {
	
	if (e.keyCode != 13) return;
	if (isNull($(element).val())) return;;

	//console.log(element);
	//console.log(e);

	var time = Date.parse(new Date());
	var targetid = $(element).data("targetid");
	var targetname = $(element).data("targetname");
	// 주의 : 임의로 등록된 Location의 경우 All local files의 LocationID(8987302884414283716)로 넣는다.	 
	var locationid = "8987302884414283716";
	var locationname = $(element).val();
	var id = targetid + "_" + locationid + "_" + time;

	var datas = "data-locationtype='userdefined' data-targetid='" + targetid + "' data-targetname='" + targetname + "' data-locationname='" + locationname + "' data-locationid='" + locationid + "'";
	var scanLocation = "<tr " + datas + " id='" + id + "'>";
	scanLocation += "<th style='text-align:left'> - All files on drive " + locationname + " on target " + targetname + "</th>";
	scanLocation += "<td>";
	scanLocation += "<button type='button' name='button' style='cursor:pointer; color:#1973ba; float:right;' onclick='fnLocationRemove(this);'>remove</button></td>";
	scanLocation += "</tr>";
 
	$("#locationList").append( scanLocation );
	$(element).val("");
}

function fnUpdateLocation(element, event) {

	var targetid = $(element).data("targetid");
	var targetname = $(element).data("targetname");
	var locationid = $(element).data("locationid");
	var locationname = $(element).data("locationname");
	var id = targetid + "_" + locationid;

	if (element.checked) {
		var datas = "data-locationtype='reserved' data-targetid='" + targetid + "' data-targetname='" + targetname + "' data-locationname='" + locationname + "' data-locationid='" + locationid + "'";
		var scanLocation = "<tr " + datas + " id='" + id + "'>";
		scanLocation += "<th style='text-align:left'> - " + locationname + " on target " + targetname + "</th>";
		scanLocation += "<td>";
		scanLocation += "<button type='button' name='button' style='cursor:pointer; color:#1973ba; float:right;' onclick='fnLocationRemove(this);'>remove</button></td>";
		scanLocation += "</tr>";
		
		//	"<p " + datas + " id='" + locationid + "'> - " + locationname + " on target " + targetname + "</p>"; 
		$("#locationList").append( scanLocation );
	}
	else {
		$('tr[id="' + id + '"]').remove();
	}
}

function fnLocationRemove(element) {

	var locationTR = $(element).parent("td").parent("tr")[0];
	$('input:checkbox[id="' + locationTR.id + '"]').prop("checked", false);	
	$(locationTR).remove();
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

function fnSearchHost(e) {

	var searchHost = $("#searchHost").val();
	if (isNull(searchHost)) {
		$(".tbl_input tr").css("display", "none");
		$.each($(".sta_tit"), function(idx, element) {
			$(element).parent().parent("tr").css( "display", "table-row");
		});
			
		return;
	}
	
	$(".tbl_input tr").css("display", "none");
	$.each($(".sta_tit"), function(idx, element) {
		var targetName = element.innerHTML;
		if (targetName.indexOf(searchHost) >= 0) {
			console.log(" ===>> " + targetName);
			$(element).parent().parent("tr").css( "display", "table-row");
		}
	});	
}

$(document).ready(function () { 
	
  	$("#viewWindow").draggable({
 	    containment: '.content',
 	 	cancel : '.popup_content, .popup_btn'
	});
	
	$("#viewWindowClose").click(function(){
		$("#viewWindow").hide();
	});

	$("#btnCancel1, #btnCancel2, #btnCancel3").click(function(){
		window.location = "${pageContext.request.contextPath}/scan/pi_scan_main";
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

	// Target Server 선택 Toggle
	$(".sta_tit").click( function(e) {
		var obj = e.target;
		var id = $(obj)[0].id;

		if ($("tr[name='" + id + "']").css( "display") == "none") {
			$("tr[name='" + id + "']").css( "display", "table-row");
		}
		else {
			$("tr[name='" + id + "']").css( "display", "none");
		}
		
	});
	
	$("#searchHost").keyup( function(e) {
		if (e.keyCode != 13) return;
		fnSearchHost(e);
	});	
	
	$("#btnSearch").click( function(e) {
		fnSearchHost(e);
	});	
	
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
	
	$("#btnStep1-2").on("click", function(e) {
		$("#btn_area1").hide();
		$("#btn_area2").show();
		$("#btn_area3").hide();
		
		$("#stepContents1").hide();		
		$("#stepContents2").show();	
		$("#stepContents3").hide();

		$("#li-step1").removeClass("on");
		$("#li-step2").addClass("on");
		$("#li-step3").removeClass("on");
	});
	
	$("#btnStep2-3").on("click", function(e) {
		$("#viewWindow").hide();
		
		$("#btn_area1").hide();
		$("#btn_area2").hide();
		$("#btn_area3").show();
		
		$("#stepContents1").hide();		
		$("#stepContents2").hide();	
		$("#stepContents3").show();

		$("#li-step1").removeClass("on");
		$("#li-step2").removeClass("on");
		$("#li-step3").addClass("on");
	});
	
	$("#btnStep3-2").on("click", function(e) {
		$("#btn_area1").hide();
		$("#btn_area2").show();
		$("#btn_area3").hide();
		
		$("#stepContents1").hide();		
		$("#stepContents2").show();	
		$("#stepContents3").hide();

		$("#li-step1").removeClass("on");
		$("#li-step2").addClass("on");
		$("#li-step3").removeClass("on");
	});
	
	$("#btnStep2-1").on("click", function(e) {
		$("#viewWindow").hide();
		
		$("#btn_area1").show();
		$("#btn_area2").hide();
		$("#btn_area3").hide();
		
		$("#stepContents1").show();		
		$("#stepContents2").hide();	
		$("#stepContents3").hide();

		$("#li-step1").addClass("on");
		$("#li-step2").removeClass("on");
		$("#li-step3").removeClass("on");
	});

	$("#btnStepSave").on("click", function(e) {

		var scheduleData = {};  // Scan Data Mater Json
		var scanLabel = $("#scanLabel").val();
		if (isNull(scanLabel)) {
			alert("스캐줄 이름을 입력하세요.");
			return;
		}
		/*
		// 레이블 넣기
		*/
		scheduleData.label = scanLabel;
		
		// 복수의 target이 들어가면 targets tag를 여러개 날린다.
		var targetsArr = new Array();
		//var locationHTML = $("#locationList").siblings();
		var locationHTML = $( "#locationList" ).children("TR");
		
		$.each(locationHTML, function(idx, element) {
			var targets_locations = {};
			targets_locations.targetid = $(element).data("targetid");
			targets_locations.locationid = $(element).data("locationid");
			targets_locations.locationname = $(element).data("locationname");
			targets_locations.locationtype = $(element).data("locationtype");
			targetsArr.push(targets_locations);
		});
		targetsArr.sort(function(a, b) { // 오름차순
		    return a.targetid < b.targetid ? -1 : a.targetid > b.targetid ? 1 : 0;
		});

		var targetArr = new Array();
		var targets = {};
		var locations = {};
		var targetid = "";
		var locationArr = new Array();
		$.each(targetsArr, function(idx, target) {

			if (idx == 0) {	// 1번째 데이터 넣기
				targetid = target.targetid;
				targets.id = target.targetid;
				locations = {};
				locations.id = target.locationid;
				// 사용자가 임의로 입력한 경로인 경우
				if (target.locationtype == "userdefined") {
					locations.subpath = target.locationname;
				}
				locationArr.push(locations);
			}
			else {
				if (targetid == target.targetid) {
					locations = {};
					locations.id = target.locationid;
					// 사용자가 임의로 입력한 경로인 경우
					if (target.locationtype == "userdefined") {
						locations.subpath = target.locationname;
					}
					locationArr.push(locations);
				}
				else {
					targets.locations = locationArr;
					targetArr.push(targets)

					targetid = target.targetid;
					targets = {};
					locations = {};
					locationArr = new Array();
					targets.id = target.targetid;
					locations.id = target.locationid;
					// 사용자가 임의로 입력한 경로인 경우
					if (target.locationtype == "userdefined") {
						locations.subpath = target.locationname;
					}
					locationArr.push(locations);
				}
			}
			if (idx == (targetsArr.length - 1)) {
				targets.locations = locationArr;
				targetArr.push(targets)
			}
		});

		/*
		// target 넣기
		*/
		if (targetArr.length == 0) {
			alert("스캔 타겟 서버를 선택하세요.");
			return;
		}
		scheduleData.targets = targetArr;
		
		// profile(Datatype) 넣기
		var profileArr = new Array(); 
	    $('[name=chkDatatype]').each(function(i, element){
		    if (element.checked) {
			    var versionType = $(element).data("version");
			    var id = $(element).val();
			    if (versionType == "1") {
				    profileArr.push(id);
			    }
			    else { 
			    	var objName = "selDatatype_" + id;
			    	profileArr.push($("#" + objName).val());
				}
		    }
	    });

		if (profileArr.length == 0) {
			alert("개인정보 유형을 선택하세요.");
			return;
		}
		scheduleData.profiles = profileArr;
		
		// 실행 주기 넣기 - 시작시간
		var startDate = "";		
		if ($('input:radio[name="rdoStart"]:checked').val() == "now") {
			var thisDateTime = getDateTime(null, "mi", 1);
			startDate = thisDateTime.substring(0,4) + "-"
					+ thisDateTime.substring(4,6) + "-" 
					+ thisDateTime.substring(6,8) + " " 
					+ thisDateTime.substring(8,10) + ":" 
					+ thisDateTime.substring(10,12); // + ":" + thisDateTime.substring(12,14); 
		}
		else {
			startDate = $("#startDate").val() + " " + $("#startTime").val(); // + ":00" ;
		}
		scheduleData.start = startDate;

		// 실행 주기 넣기 - 실행주기
		var period = $("#period").val();
		switch (period) {
		case "1T" :
			scheduleData.repeat_days = 0;
			scheduleData.repeat_months = 0;
			break;
		case "1D" :
			scheduleData.repeat_days = 1;
			scheduleData.repeat_months = 0;
			break;
		case "7D" :
			scheduleData.repeat_days = 7;
			scheduleData.repeat_months = 0;
			break;
		case "14D" :
			scheduleData.repeat_days = 14;
			scheduleData.repeat_months = 0;
			break;
		case "1M" :
			scheduleData.repeat_days = 0;
			scheduleData.repeat_months = 1;
			break;
		case "6M" :
			scheduleData.repeat_days = 0;
			scheduleData.repeat_months = 6;
			break;
		case "12M" :
			scheduleData.repeat_days = 0;
			scheduleData.repeat_months = 12;
			break;
		default :
			scheduleData.repeat_days = 0;
			scheduleData.repeat_months = 0;
			break;
		}
		
		// CPUs
		scheduleData.cpu = $('input:radio[name="rdoPriority"]:checked').val();

		//Throughput
		if ($('input:checkbox[id="chkThroughput"]').is(":checked")) {
			scheduleData.throughput = Number($("#throughput").val());
		}
		else {
			scheduleData.throughput = 0;
		}
		//memory
		if ($('input:checkbox[id="chkMemory"]').is(":checked")) {
			scheduleData.memory = Number($("#memory").val());
		}
		else {
			scheduleData.memory = 0;
		}

		//Pause
		var pause = {};
		if ($('input:checkbox[id="chkPause"]').is(":checked")) {
			var pauseStartTime = $('#pauseStartTime').val();
			var pauseEndTime = $('#pauseEndTime').val();
			pause.start = pauseStartTime.split(":")[0] * 60 * 60 + pauseStartTime.split(":")[1] * 60; 
			pause.end = pauseEndTime.split(":")[0] * 60 * 60 + pauseEndTime.split(":")[1] * 60;
			
			var pauseDays = 0;
			$('input:checkbox[name="rdoDay"]:checked').each(function(i, element){
				pauseDays += Number(element.value);
		    });
			pause.days = pauseDays
		}
		else {
			/*
			pause.start = 0; 
			pause.end = 0;
			pause.days = 127;
			*/
		}
		scheduleData.pause = pause;
		// 스캔 로그
		if ($('input:checkbox[id="chkTrace"]').is(":checked")) {
			scheduleData.trace = true;
		}
		else {
			scheduleData.trace = false;
		}
		
		scheduleData.timezone = "Default";
		scheduleData.capture = false;

		var postData = {scheduleData : JSON.stringify(scheduleData)};
		var message = "신규 스캔 스케줄을 등록하시겠습니까?";
		if (confirm(message)) {
			$.ajax({
				type: "POST",
				url: "/scan/registSchedule",
				async : false,
				data : postData,
			    success: function (resultMap) {
console.log(resultMap);
			        if (resultMap.resultCode == 201) {
				        alert("신규 스캔 스케줄이 등록되었습니다.");
				        window.location = "${pageContext.request.contextPath}/scan/pi_scan_main";
			        	return;
				    }
			        if (resultMap.resultCode == 409) {
				        alert("신규 스캔 스케줄 등록이 실패 되었습니다.\n\n스캔 스케줄명이 중복 되었습니다.");
			        	return;
				    }
			        if (resultMap.resultCode == 422) {
			        	alert("신규 스캔 스케줄 등록이 실패 되었습니다.\n\n스케줄 시작시간을 확인 하십시요.");
			        	return;
				    }
			        alert("신규 스캔 스케줄이 등록이 실패 되었습니다.\n관리자에게 문의 하십시요");
			    },
			    error: function (request, status, error) {
					alert("Server Error : " + error);
			        console.log("ERROR : ", error);
			    }
			});
		}
	});
	
});
</script>
	<!-- wrap -->
</body>
</html>

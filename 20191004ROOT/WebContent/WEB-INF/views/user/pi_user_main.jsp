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
					<h3>타겟 관리</h3>
					<p class="location">사용자 관리 > 사용자 관리</p>
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
						<p class="location">사용자 관리 > 사용자 관리</p>
					</div>
					<div class="grid_top">
						<!-- user info -->
						<div class="grid_top">
							<h3>사용자 정보</h3>
						</div>
						<table class="user_info" style="width: auto !important;">
							<caption>사용자정보</caption>
							<colgroup>
								<col width="310px">
								<col width="230px">
								<col width="380px">
								<col width="230px">
								<col width="380px">
							</colgroup>
							<tbody>
								<tr style="height: 70px;">
									<td rowspan="3" class="ta_c">
										<img src="${pageContext.request.contextPath}/resources/assets/images/user_icon.png" alt="">
										<p class="user_name">${memberInfo.USER_NAME}<em>(${memberInfo.JIKGUK})</em></p>
									</td>
									<th style="border-bottom: 2px solid #ddd;">사용자 번호</th>
									<td>${memberInfo.USER_NO}</td>
									<th class="btn_area2" style="width:8vw; padding:0 7px;">비밀번호
										<button class="margin_reset" type="button" id="btnChangePwd" style="margin-top: 2px; margin-left: 0; width:6vw; font-size:.75vw;">비밀번호변경</button>
									</th>
									<td><input type="password" id="passwd" value="${memberInfo.USER_NO}" class="edt_read" disabled></td>
								</tr>
								<tr style="height: 70px;">
									<th class="btn_area2" style="width:8vw; padding:0 7px;">접근가능IP
									<c:if test="${memberInfo.USER_GRADE == '9'}">
										<button class="margin_reset"  type="button" id="btnAccessIPChange" style="margin-top: 2px; margin-left: 0; width:6vw; font-size:.75vw;">접근정보변경</button>
									</c:if>									
									</th>
									<td id="accessIPtd" colspan="3">
									<c:choose>
									<c:when test="${memberInfo.USER_GRADE == '9'}">${accessIP}</c:when>
								    <c:otherwise>*.*.*.*</c:otherwise>
									</c:choose>
									</td>
								</tr>
							</tbody>
						</table>

						<!-- list -->
						<div class="grid_top" style="margin-top: 20px;">
							<table style="width: 100%;">
								<caption>검출 리스트</caption>
								<colgroup>
									<col width="*"/>
									<col width="250px"/>
								</colgroup>
								<tr>
									<td><h3>사용자 현황</h3></td>
									<td class="btn_area" style="text-align: right; padding: 0px;">
									<c:if test="${memberInfo.USER_GRADE == '9'}">
										<button type="button" id="btnManagerRegist" style="padding: 0 10px; margin: 0px;"> 관리자 등록 </button>
										<button type="button" id="btnAccountCreate" style="padding: 0 10px; margin: 0px;"> 사용자 등록 </button>
									</c:if>
									</td>
								</tr>
							</table>

							<div class="left_box2 minW minH_2" style="overflow: hidden; max-height: 530px; height: 530px;">
			   					<table id="userGrid"></table>
			   					<div id="userGridPager"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->
	<%@ include file="../../include/footer.jsp"%>

<!-- 팝업창 - 비밀번호 시작 -->
<div id="passwordChangePopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px;">
		<div class="popup_top">
			<h1>비밀번호 변경</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 180px;">
				<!-- <h2>세부사항</h2>  -->
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>현재비밀번호</th>
							<td><input type="password" id="oldPasswd" value="" class="edt_sch"></td>
						</tr>
						<tr>
							<th>변경비밀번호</th>
							<td><input type="password" id="newPasswd" value="" class="edt_sch"></td>
						</tr>
						<tr>
							<th>변경비밀번호확인</th>
							<td><input type="password" id="newPasswd2" value="" class="edt_sch"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="btnPasswordChangeSave">저장</button>
				<button type="button" id="btnPasswordChangeCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 - 비밀번호 종료 -->

<!-- 팝업창 - 접근가능IP 시작 -->
<c:if test="${memberInfo.USER_GRADE == '9'}">
<div id="accessIPPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px; width: 400px;">
		<div class="popup_top">
			<h1>접근가능 IP 등록</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 180px;">
				<!-- <h2>세부사항</h2>  -->
				<textarea id="accessIP" class="edt_sch" style="border: 1px solid #cdcdcd; width: 380px; height: 130px; margin-top: 5px; margin-bottom: 5px; padding: 10px; resize: none;"></textarea>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="btnAccessIPChangeSave">저장</button>
				<button type="button" id="btnAccessIPChangeCancel">취소</button>
			</div>
		</div>
	</div>
</div>
</c:if>
<!-- 팝업창 - 접근가능IP 종료 -->

<!-- 팝업창 - 계정생성 시작 -->
<div id="accountCreatePopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 487px;">
		<div class="popup_top">
			<h1>사용자 등록</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 407px;">
				<!-- <h2>세부사항</h2>  -->
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>사용자번호</th>
							<td><input type="text" id="userNo" value="" class="edt_sch" style="width: 280px; margin-top:7px; background: #f5f1ee; font-weight: bold; padding-left: 10px;">
								<button type="button" id="btnChkDuplicateUserNo" data-valid="N" data-UserNo="">중복확인</button>
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" id="password" value="" class="edt_sch" style="width: 280px; background: #f5f1ee; font-weight: bold; padding-left: 10px;"></td>
						</tr>
						<tr>
							<th>비밀번호확인</th>
							<td><input type="password" id="password2" value="" class="edt_sch" style="width: 280px; background: #f5f1ee; font-weight: bold; padding-left: 10px;"></td>
						</tr>
						<tr>
							<th>사용자명</th>
							<td><input type="text" id="userName" value="" class="edt_sch" style="width: 280px; background: #f5f1ee; font-weight: bold; padding-left: 10px;"></td>
						</tr>
						<tr>
							<th>직급</th>
							<td>
								<select id="jikweeSelect" name="jikweeSelect">
				   					<option value="" selected>선택</option>
				   					<option value="L0">사원</option>
				   					<option value="L1">대리</option>
				   					<option value="L2">차장</option>
				   					<option value="L3">부장</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>부서</th>
							<td>
								<select id="teamSelect" name="teamSelect">
									<option value="" selected>선택</option>
									<c:forEach items="${teamMap}" var="teamMap">
				   					<option value="${teamMap.INSA_CODE}">${teamMap.TEAM_NAME}</option>
									</c:forEach>
								</select>	
							</td>
						</tr>
						<tr>
							<th>계정시작일</th>
							<td><input type="date" id="fromDate" style="text-align: center;" readonly="readonly" value="${fromDate}" >
							</td>
						</tr>
						<tr>
							<th>계정만료일</th>
							<td><input type="date" id="toDate" style="text-align: center;" readonly="readonly" value="${toDate}" >
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="btnAccountSave">저장</button>
				<button type="button" id="btnAccountCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 - 계정생성 종료 -->

<script type="text/javascript">
var passwordRules = /(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{1,50}).{8,50}$/;

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
	
	$("#jikweeSelect").selectmenu({
		width: 280
	});

	$("#teamSelect").selectmenu({
		width: 280
	});
	
	$("#btnAccountCreate").on("click", function(e) {
		
    	$("#btnChkDuplicateUserNo").data("valid", "N");
    	$("#btnChkDuplicateUserNo").data("UserNo", "");

		$("#userNo").val("");
		$("#password").val("");
		$("#password2").val("");
		$("#jikweeSelect").val("");
		$("#teamSelect").val("");
		$("#userName").val("");
		
		$("#accountCreatePopup").show();
	});

	$("#btnAccountCancel").on("click", function(e) {
		$("#accountCreatePopup").hide();
	});

	$("#btnChkDuplicateUserNo").on("click", function(e) {

		var userNo 		= $("#userNo").val().trim();
		if (isNull(userNo)) {
			$("#userNo").focus();
			alert("사용자번호를 입력하십시요.");
			return;
		}

		var postData = {
			userNo : userNo
		};
		$.ajax({
			type: "POST",
			url: "/user/chkDuplicateUserNo",
			async : false,
			data : postData,
		    success: function (resultMap) {
			    console.log(resultMap);
		        if (resultMap.resultCode != 0) {
			        alert("사용자 확인 실패 : " + resultMap.resultMessage);
		        	return;
			    }
		        if (resultMap.UserMap.EXISTUSERCNT == "0") {
		        	$("#btnChkDuplicateUserNo").data("valid", "Y");
		        	$("#btnChkDuplicateUserNo").data("UserNo", userNo);

		        	alert("사용할 수 있는 사용자번호 입니다.");
				}
		        else {
		        	$("#btnChkDuplicateUserNo").data("valid", "N");
		        	alert("사용할 수 없는 사용자번호 입니다.");
				}
		    },
		    error: function (request, status, error) {
				alert("사용자 확인 실패 : " + error);
		        console.log("사용자 확인 실패 : ", error);
		    }
		});
	});

	$("#btnAccountSave").on("click", function(e) {

		var userNo 		= $("#userNo").val().trim();
		var password 	= $("#password").val().trim();
		var password2 	= $("#password2").val().trim();
		var jikwee	 	= $("#jikweeSelect").val().trim();
		var team	 	= $("#teamSelect").val().trim();
		var userName	= $("#userName").val().trim();
		var jikguk		= $("#jikweeSelect option:selected").text().trim();

		if (isNull(userNo)) {
			$("#userNo").focus();
			alert("사용자번호를 입력하십시요.");
			return;
		}

		if (isNull(password)) {
			$("#password").focus();
			alert("비밀번호를 입력하십시요");
			return;
		}

		if (isNull(password2)) {
			$("#password2").focus();
			alert("비밀번호확인을 입력하십시요");
			return;
		}
		
		if (password != password2) {
			$("#password2").focus();
			alert("비밀번호와 비밀번호확인이 일치하지 않습니다.");
			return;
		}

		if (!passwordRules.test(password)) {
			$("#password").focus();
			alert("비밀번호는 숫자/영문자/특수문자를 1개 이상, 8자 이상입력하십시요. : " + password);
			return;
		}
		
		if (isNull(userName)) {
			$("#userName").focus();
			alert("사용자명을 입력하십시요");
			return;
		}
		
		if (isNull(jikwee)) {
			$("#jikweeSelect").focus();
			alert("직급을 선택하십시요.");
			return;
		}
		
		if (isNull(team)) {
			$("#teamSelect").focus();
			alert("부서를 선택하십시요.");
			return;
		}
		
		var chkUserNoYN = $("#btnChkDuplicateUserNo").data("valid");
		if (chkUserNoYN != "Y") {
			alert("사용자번호의 중복확인을 하십시요.");
			return;
		}
		
		var confirmUserNo = $("#btnChkDuplicateUserNo").data("UserNo");
		if (userNo != confirmUserNo) {
			alert("변경입력 하신 사용자번호의 중복확인을 하십시요.");
			return;
		}

		var postData = {
			userNo 		: userNo,
			password 	: password,
			userName	: userName,
			jikwee	 	: jikwee,
			jikguk		: jikguk,
			team	 	: team
		};

		$.ajax({
			type: "POST",
			url: "/user/createUser",
			async : false,
			data : postData,
		    success: function (resultMap) {
			    console.log(resultMap);
		        if (resultMap.resultCode != 0) {$("#accountCreatePopup").hide();
			        alert("사용자 생성 실패 : " + resultMap.resultMessage);
		        	return;
			    }
	        	alert("새로운 사용자가 생성되었습니다.");
	        	$("#accountCreatePopup").hide();
		    },
		    error: function (request, status, error) {
				alert("사용자 생성 실패 : " + error);
		        console.log("사용자 생성 실패 : ", error);
		    }
		});
		
	});
	
	var gridWidth = $("#userGrid").parent().width();
	var gridHeight = 430;
	$("#userGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		
		<c:choose>
		<c:when test="${memberInfo.USER_GRADE == '9'}">
			colNames:['관리자','사용자 ID', '사용자명', '직급', '부서명', '등록일자','관리자', '관리자'],
			colModel: [         
				{ index: 'CHKBOX', 		name: 'CHKBOX',		width: 120,  align: 'center', editable: true, edittype: 'checkbox', 
					editoptions: { value: '1:0' }, formatoptions: { disabled: false }, formatter: createCheckbox, stype: 'select',
					searchoptions: { sopt: ['eq'], value: ':전체;1:선택;0:미선택' }
				},
		</c:when>
	    <c:otherwise>
			colNames:['사용자 ID', '사용자명', '직급', '부서명', '등록일자','관리자', '관리자'],
			colModel: [ 
	    </c:otherwise>
		</c:choose>
		
			{ index: 'USER_NO', 			name: 'USER_NO', 			width: 200,	align: 'center'},
			{ index: 'USER_NAME',			name: 'USER_NAME',			width: 200, align: 'center'},
			{ index: 'JIKGUK',				name: 'JIKGUK',				width: 200, align: 'center'},
			{ index: 'TEAM_NAME',			name: 'TEAM_NAME',			width: 600, align: 'center'},
			{ index: 'REGDATE',				name: 'REGDATE', 			width: 200, align: 'center'},
			{ index: 'USER_GRADE',			name: 'USER_GRADE', 		width: 200, align: 'center', hidden: true},
			{ index: 'OLD_USER_GRADE',		name: 'OLD_USER_GRADE', 	width: 200, align: 'center', hidden: true}
			
		],
		width: gridWidth,
		height: gridHeight,
		loadonce: true, // this is just for the demo
		viewrecords: true, // show the current page, data rang and total records on the toolbar
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 50, // 행번호 열의 너비	
		rowNum:30,
	   	rowList:[10,20,30],
	    search: true,			
		pager: "#userGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	  		
	  	},
	  	afterEditCell: function(rowid, cellname, value, iRow, iCol){
            //I use cellname, but possibly you need to apply it for each checkbox       
			if (cellname == 'USER_GRADE'){
			    $("#userGrid").saveCell(iRow,iCol);
			}
		},
		loadComplete: function(data) {
	    },
	    gridComplete : function() {
	    }
	});

	var postData = {
		userNo : $("#userNo").val(),
		userName : $("#userName").val(),
		fromDate : $("#date1").val(),
		toDate : $("#date2").val() 
	};
	$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/user/selectManagerList", postData : postData, datatype:"json" }).trigger("reloadGrid");

	$("#btnChangePwd").on("click", function(e) {
		$("#oldPasswd").val("");
		$("#newPasswd").val("");
		$("#newPasswd2").val("");
		
		$("#passwordChangePopup").show();
	});

	$("#btnPasswordChangeSave").on("click", function(e) {
		var oldPassword = $("#oldPasswd").val();
		var newPasswd = $("#newPasswd").val();
		var newPasswd2 =  $("#newPasswd2").val();

		if (oldPassword == "") {
			$("#oldPasswd").focus();
			alert("현재 비밀번호를 입력하십시요");
			return;
		}
		
		if (newPasswd == "") {
			$("#newPasswd").focus();
			alert("변경 비밀번호를 입력하십시요");
			return;
		}
		
		if (newPasswd2 == "") {
			$("#newPasswd2").focus();
			alert("변경 비밀번호확인을 입력하십시요");
			return;
		}
		
		if (oldPassword == newPasswd) {
			$("#newPasswd").focus();
			alert("현재 비밀번호와 변경 비밀번호를 다르게 입력하십시요.");
			return;
		}
		
		if (newPasswd != newPasswd2) {
			$("#newPasswd").focus();
			alert("변경 비밀번호와 비밀번호확인이 일치하지 않습니다.");
			return;
		}
		
		if (!passwordRules.test(newPasswd)) {
			$("#newPasswd").focus();
			alert("비밀번호는 숫자/영문자/특수문자를 1개 이상, 8자 이상입력하십시요.");
			return;
		}

		var postData = {oldPassword : oldPassword, newPasswd : newPasswd};		
		$.ajax({
			type: "POST",
			url: "/changeAuthCharacter",
			async : false,
			data : postData,
		    success: function (resultMap) {
		        if (resultMap.resultCode != 0) {
			        alert("비밀번호 변경실패 : " + resultMap.resultMessage);
		        	return;
			    }
				alert("비밀번호가 변경되었습니다.");
		      	$("#passwordChangePopup").hide();
		    },
		    error: function (request, status, error) {
				alert("비밀번호 변경실패 : " + error);
		        console.log("비밀번호 변경실패 : ", error);
		    }
		});
	});
	
	$("#btnPasswordChangeCancel").on("click", function(e) {
		$("#passwordChangePopup").hide();
	});
<c:if test="${memberInfo.USER_GRADE == '9'}">
	// 관리자 등록
	$("#btnManagerRegist").click(function() {

		// 선택된 사용자 저장
		var idx = 0;		
		var userList = [];
		var userData = $("#userGrid").jqGrid('getGridParam', 'data');

		for (var i = 0; i < userData.length; i++) {
			var chk = userData[i].USER_GRADE;
			var chkold = userData[i].OLD_USER_GRADE;
			// 담당자로 선택되거나 해제 확인
			if (chk != chkold) {
				var userAssign = {};
				userAssign.userNo 		= userData[i].USER_NO;
				userAssign.userGrade	= userData[i].USER_GRADE;
				userList[idx++] = userAssign;	
			}
		}

		if (isNull(userList)) {
			alert("변경된 정보가 없습니다.");
			return;
		}
		var postData = {
				userList : JSON.stringify(userList)
		};

		var message = "선택한 사용자를 담당자로 지정하시겠습니까?";
		if (confirm(message)) {
			$.ajax({
				type: "POST",
				url: "/user/changeManagerList",
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
						$("#userGrid").jqGrid('setCell', userData[i]._id_, 'OLD_USER_GRADE', userData[i].USER_GRADE);
					}
					
			        alert("관리자가 지정되었습니다.");
			    },
			    error: function (request, status, error) {
					alert("Server Error : " + error);
			        console.log("ERROR : ", error);
			    }
			});
		}
    });

	//접근 허용IP 관련 - textarea에 넣어주기
	$("#accessIP").val(("${accessIP}").replace(/ /gi, "").replace(/,/gi, "\n"));
	 
	$("#btnAccessIPChange").on("click", function(e) {
		// accessIPPopup
		$("#accessIPPopup").show();
	});

	$("#btnAccessIPChangeCancel").on("click", function(e) {
		$("#accessIPPopup").hide();
	});

	$("#btnAccessIPChangeSave").on("click", function(e) {

		var accessIP = $("#accessIP").val();
		if(!isNull(accessIP)) accessIP = accessIP.split("\n");

		//IP 정합성 확인
		var accessIPs = new Array();
		var expUrl = /^(1|2)?\d?\d([.](1|2)?\d?\d){3}$/;
		for (var i = 0; i < accessIP.length; i++) {
			if (isNull(accessIP[i])) continue;
			
			if (!expUrl.test(accessIP[i])) {
				alert((i + 1) + "번째 IP 주소가 오류입니다.");
				return;
			}
			accessIPs.push(accessIP[i]);
		}
		
		var postData = {accessIP : accessIPs.join(", ")};
		$.ajax({
			type: "POST",
			url: "/user/changeAccessIP",
			async : false,
			data : postData,
		    success: function (resultMap) {
		        if (resultMap.resultCode != 0) {
			        alert("접근가능 IP 변경실패 : " + resultMap.resultMessage);
		        	return;
			    }
		        $("#accessIPtd").html(accessIPs.join(", "));
				$("#accessIP").val(accessIPs.join("\n"));


				alert("접근가능 IP가 변경되었습니다.");
		      	$("#accessIPPopup").hide();
		    },
		    error: function (request, status, error) {
				alert("접근가능 IP 변경실패 : " + error);
		        console.log("접근가능 IP 변경실패 : ", error);
		    }
		});
	});

	</c:if>
});


<c:if test="${memberInfo.USER_GRADE == '9'}">
function createCheckbox(cellvalue, options, rowObject) {
	var rowID = options['rowId'];
	var checkboxID = "gridChk" + rowID;
	
	if (rowObject['USER_GRADE'] == "1")
		return "<input type='checkbox' id='" + checkboxID + "' value='" + rowID + "' onchange='onGridChkboxChange( event )' checked>"; 
	else 
		return "<input type='checkbox' id='" + checkboxID + "' value='" + rowID + "' onchange='onGridChkboxChange( event )'>";
}

function onGridChkboxChange(e) {
	var e = e || window.event;
	var target = e.target || e.srcElement;

	if (target.checked) {
		$("#userGrid").jqGrid('setCell', target.value, 'USER_GRADE', "1");
		$("#userGrid").jqGrid('setCell', target.value, 'CHKBOX', "1");
	}
	else { 
		$("#userGrid").jqGrid('setCell', target.value, 'USER_GRADE', "0");
		$("#userGrid").jqGrid('setCell', target.value, 'CHKBOX', "0");
	}
}
</c:if>

</script>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.security.SecureRandom"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta charset="utf-8">
	<title>NH농협은행 서버내 개인정보 검색 시스템</title>
	<!-- <title>NH농협중앙회 서버내 개인정보 검색 시스템</title> -->
	<!-- Publish CSS -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/reset.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/design.css" />

	<!-- Publish JS -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-3.3.1.js"></script>

	<!--[if lte IE 8]>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/ie-8.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/ie-8.css" />
	<![endif]-->
	<!--[if lte IE 9]>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/ie-9.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/ie-9.css" />
	<![endif]-->

	<!-- Application Common Functions  -->
	<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>
	
</head>

<body>
	<!-- wrap -->
	<div class="wrap_login">

		<!-- section -->
		<section>
			<!-- container -->
			<div class="container_login">
				<!-- logo -->
				<div class="login_box">
					<p class="slogan">금융의 모든 순간</p>
					<h1 style="margin-top: 20px;"><img src="${pageContext.request.contextPath}/resources/assets/images/nhnonghyup1.png" alt="NH농협은행"></h1>
					<!-- <h1 style="margin-top: 20px;"><img src="${pageContext.request.contextPath}/resources/assets/images/nhnonghyup2.png" alt="NH농협중앙회"></h1> -->
					<p class="login_info">로그인 후 이용해 주세요.</p>
					<div class="input_box"> 
						<input type="text" id="user_id" value="" placeholder="아이디를 입력하세요."><br/>
						<input type="password" id="user_pw" value="" placeholder="비밀번호를 입력하세요.">
						<input type="hidden" id="user_grade" value="">
					</div>
					<div class="id_save">
						<input type="checkbox" id="save" name="save" value="Y" checked><label for="save">아이디 저장</label>
					</div>
					<button type="button" id="loginID" class="btn_login" >아이디 로그인</button>
					<button type="button" id="loginSSO" class="btn_login">SSO 로그인</button>
					<div class="footer_copyright">
						&copy; ㈜프렌트리 All Rights Reserved.
					</div> 
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->

	</div>
	<!-- wrap -->
</body>

<script type="text/javascript">


var intervalID;
var invalidPassword = 0;

$(document).ready(function () {

	// 쿠키에 저장된 아이디 정보
	$('#user_id').val(getCookie("PiBoardUserNo"));
	// 아이디 입력시 발생하는 이벤트
	$('#user_id').keyup(function(e) {
		// 엔터 입력시 id값이 아무것도 없으면 id입력창에 포커스
		if (e.keyCode == 13) {
		    if ($('#user_id').val() == "") {
		    	$("#user_id").focus();
		    	return;
			} // 아이디 입력되어 있으면 비밀번호에 포커스
		    $("#user_pw").focus();
	    }
	});
	// 비밀번호 입력시 발생하는 이벤트
	$('#user_pw').keyup(function(e) {
		// 엔터 입력시 pw값이 아무것도 없으면 pw입력창에 포커스
		if (e.keyCode == 13) {
		    if ($('#user_pw').val() == "") {
		    	$("#user_pw").focus();
		    	return;
			} // 비밀번호 입력되어 있으면 ID로 로그인 버튼 클릭
		    $("#loginID").click();
	    }        
	});
	// 아이디로 로그인 버튼 클릭시 발생하는 이벤트
	$("#loginID").click(function(){
		// 비밀번호 오입력 횟수 5회 미만
		if (invalidPassword >= 5) return;
		// id value 비어 있을 경우, 포커스 되며 경고창 나옴
		if (isNull($("#user_id").val())) {
			$("#user_id").focus();
			alert("ID를 입력하세요");
			return;
		}
		// pw value 비어 있을 경우, 포커스 되며 경고창 나옴
		if (isNull($("#user_pw").val())) {
			$("#user_pw").focus();
			alert("비밀번호를 입력하세요");
			return;
		}
		
		var postData = {
			user_no : $("#user_id").val(),
			password : $("#user_pw").val()
		};
		

		
		$.ajax({
			type: "POST",
			url: "/login",
			async : false,
			data : postData,
		    success: function (resultMap) {
		        if (resultMap.resultCode != 0) {
			        if (resultMap.resultCode == -2) {
				        invalidPassword++;
				        $('#user_pw').val("");
			        }

			        if (invalidPassword == 5) {
				        alert("비밀번호 5회 오류도 10분간 사용하실수 없습니다.");
				        $("#loginID").prop('disabled', true);
			        	$("#loginSSO").prop('disabled', true);
			        	
				        intervalID = setInterval(function(){ 
					        	$("#loginID").prop('disabled', false);
					        	$("#loginSSO").prop('disabled', false);
					        	invalidPassword = 0;
					        	clearInterval(intervalID);
					        	}, 1000 * 1 * 10);
			        }
			        else {
				        alert("로그인 실패 : " + resultMap.resultMessage);
					}
		        	return;
			    }
			    
		        var user_no = $("#user_id").val();
		        if ($('input:checkbox[name="save"]').is(":checked")) {
			        setCookie("PiBoardUserNo", user_no, 7); // 7일 동안 쿠키 보관
		        }
            	else {
                	deleteCookie("PiBoardUserNo"); // 7일 동안 쿠키 보관
            	}
		        
		        if (resultMap.user_grade == 9){
		        	document.location.href = "<%=request.getContextPath()%>/piboard";
		        } else {
		        	document.location.href = "<%=request.getContextPath()%>/detection/pi_detection_regist";
		        }
			    
		    },
		    error: function (request, status, error) {
				alert("ERROR : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	});

    $("#loginSSO").click(function(){
    	document.location.href = "<%=request.getContextPath()%>/NCLoginTestENC";
    });
}); //$(document).ready

</script>
</html>

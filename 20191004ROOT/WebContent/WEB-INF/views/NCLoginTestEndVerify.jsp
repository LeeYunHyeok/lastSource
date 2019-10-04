<%@ page import="com.initech.provider.crypto.InitechProvider"%>
<%@ page import="com.initech.provider.crypto.Provider"%>
<%@ page language="java"%>
<%@ page contentType="text/html;charset=EUC-KR"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.util.List"%>
<%@ page import="com.initech.eom.nLs.TicketV3"%>
<%@ include file="cutCarriageReturn.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta charset="utf-8">
    <title>NH 농협은행</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-3.3.1.js"></script>
</head>

<body>
<%
	List res = null;
	String userid = null;
	String toa = null;

	try {
		String ticket = (String) request.getParameter("ticket");
		System.out.println("*=========== ticket = "+ticket);
		String savedNonce = (String) session.getAttribute("nexess.nls.resession.nonce");
		System.out.println("*=========== nexess.nls.resession.nonce = "+savedNonce);

		if (ticket != null) {
			ticket = URLDecoder.decode(ticket);
		}

		int firstIndex        = ticket.indexOf("&&");
		int secondeIndex      = ticket.lastIndexOf("&&");
		String encNonce       = ticket.substring(0, firstIndex);
		String encSKIPAndTime = ticket.substring(firstIndex + 2, secondeIndex);
		String encIDAndTOA    = ticket.substring(secondeIndex +2);
		String decNonce       = null;

		try {
			decNonce = cutCarriageReturn(TicketV3.decryptNonce(encSKIPAndTime, encNonce));
		} 
		catch (Exception e) {
			System.out.println("1 티켓검증 실패! 로그인 페이지로 이동필요");
			//response.sendRedirect("fcs?cmd=Error&errorCode=3102");
		}

		if (decNonce.equals(savedNonce)) {

			res = TicketV3.readIDAndTOA(encSKIPAndTime, encIDAndTOA);
			userid = (String) res.get(0);
			toa = (String) res.get(1);
			// System.out.println("================ [login_exec.jsp] userid = "+userid);
		
		} 
		else {
			System.out.println("2 티켓검증 실패! 로그인 페이지로 이동필요");
			//response.sendRedirect("fcs?cmd=Error&errorCode=3102");
		}
		
	} 
	catch (Exception e) {
		System.out.println("3 티켓검증 실패! 로그인 페이지로 이동필요");
		e.printStackTrace();
		// 암오화 실패 로그인 페이지로 이동
		// response.sendRedirect("fcs?cmd=Error&errorCode=3102");
		response.sendRedirect("/");
	}
%>


<!--     <b>Nexess Login Agent</b><br> -->
<!--     Login Success<br> -->
<%--     &nbsp&nbsp&nbsp&nbsp userid = [<%=userid%>]<br> --%>
<%--     &nbsp&nbsp&nbsp&nbsp toa = [<%=toa%>]<br> --%>
</body>
<script language=javascript>
$(document).ready(function () {
    var postData = {
            user_no : "${userid}",
            sso_type : 'success'
        };

    $.ajax({
        type: "POST",
        url: "/ssoLogin",
        async : false,
        data : postData,
        success: function (resultMap) {

            alert(resultMap.user_grade );

            if (resultMap.user_grade==9){
                document.location.href = "<%=request.getContextPath()%>/piboard";
            } else {
                var form = document.createElement('form');
                form.setAttribute('method', 'post');
                form.setAttribute('action', "/detection/pi_detection_regist");
                document.body.appendChild(form);
                form.submit();

            }
        },
        error: function (request, status, error) {
            var form = document.createElement('form');
            form.setAttribute('method', 'post');
            form.setAttribute('action', "/");
            document.body.appendChild(form);
            form.submit();
        }
    });
}); //$(document).ready
</script>
</html>
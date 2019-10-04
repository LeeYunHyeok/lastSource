<%@ page language="java"%>
<%@ page contentType="text/html;charset=EUC-KR"%>
<%@ page import="com.initech.cryptox.util.Base64Util"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.initech.eom.nLs.Ticket"%>
<%@ page import="com.initech.eom.nLs.CookieManager"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="com.initech.eom.nLs.NLSHelper"%>
<%@ include file="cutCarriageReturn.jsp" %>

<%
// 	#noCacheNonce : 프록시에서의 색상을 방지하기 위한 Cookie와 RequestParameter로 이동됨
// 	1) LoginFormPage와 resession.jsp에서 생성하고, 그 이후 페이지에 RequestParameter로 넘겨준다.
// 	    -> NLS에서 Page이동시 항상 넘기고 받도록 한다. 
// 	2) LoginFormPage와 resession.jsp에서 이 이름의 Cookie를 생성해주도록 한다.
	
	// -- resession.nonce 
	SecureRandom random = new SecureRandom();
	byte[] nonce = new byte[8];
	random.nextBytes(nonce);
	
	String nonceStr = cutCarriageReturn(new String(Base64Util.encode(nonce)));
	session.setAttribute("nexess.nls.resession.nonce", nonceStr);
%>

<!-- [if IE], [endif] 등의 태그에 붙어있는 '!--'는 주석이 아니니 삭제하지 말 것. -->
<!-- 멀티브라우저 추가 코드 by minho -->

<!-- IE 일 때는 이 코드 실행 -->
<!--[if IE]>
        <OBJECT IO="NEXESS_API" CLASSID="CLSID:D4F52B57-88A3-4A8O-94F6-777A015D8512" width=0 height=0></OBJECT>
<![endif]-->

<!-- IE가 아니라 Firefox, Chrome등등 일 때는 이 코드 실행
<![if IE]>
        <embed id="NEXESS_API" type="application/initech/npNexessClient, version=2,6,1,1" whdth=0 height=0 ><br>
<![endif]-->

<![if !IE]>
<script language="javascript">
    if (navigator.userAgent.indexOf('MSIE 10') == -1 && navigator.userAgent.indexOf("Trident") == -1) {
		//alert("사용중인 IE가 IE10,11 이 아님");
		document.write("<embed id=\"NEXESS_API\" type=\"application/initech/npNexessClient,version=2,6,1,1\" width=0 height=0 ><br>");
	} 
    else {
		//alert("사용중인 IE가 10 OR 11임");
		document.write("<OBJECT ID=\"NEXESS_API\" CLASSID=\"CLSID:D4F62B67-8BA3-4A8D-94F6-777A015DB612\" width=0 height=0 ></OBJECT>");
	}
</script>
<![endif]>
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
</body>
<script language=javascript>

	console.log("NCLoginTestENC");
	
	var ticket = NEXESS_API.GetTicket("<%=nonceStr%>")
	var ssoid  = NEXESS_API.GetLoginID();

//     var ticket = "1111111+2222222222+333333333+444444+5555";
//     var ssoid  = "iopts";

	if (ticket.length == 1 || ticket == ""){
	    alert("로그인 되어있지 않음 로그인 페이지로 이동필요")
        self.location.replace("${pageContext.request.contextPath}")
	} 
	else {
	    while(ticket.indexOf("+") != -1 ){
	        ticket = ticket.replace("+", "%2b");
	    }

	    // alert(ticket);
        // self.location.replace("./NCLoginTestEncVerifyTicket.jsp?ticket=" + escape(ticket));
	    // self.location.replace("/NCLoginTestEndVerify?ticket=" + escape(ticket));

	    $(document).ready(function(){

    	    var form = document.createElement('form');
    	    var objs;
    	    //objs.setAttribute('ticket', escape(ticket));
    	    alert(ssoid);
    	    
    	    objs = document.createElement('input');
    	    objs.setAttribute('type', 'hidden');
    	    objs.setAttribute('name', "ssoid");
    	    objs.setAttribute('value', ssoid);
    	    form.appendChild(objs);

    	    objs1 = document.createElement('input');
    	    objs.setAttribute('type', 'hidden');
    	    objs1.setAttribute('name', "ticket");
    	    objs1.setAttribute('value', escape(ticket));
    	    form.appendChild(objs1);
    	    
    	    form.setAttribute('method', 'post');
    	    form.setAttribute('action', "/NCLoginTestEndVerify");
    	    document.body.appendChild(form);
    	    form.submit();

//     	    var postData = {
//     	            user_no : ssoid,
//     	            sso_type : 'success'
//     	        };

//     	    $.ajax({
//     	        type: "POST",
//     	        url: "/ssoLogin",
//     	        async : false,
//     	        data : postData,
//     	        success: function (resultMap) {

//     	            if (resultMap.user_grade==9){
<%--     	                document.location.href = "<%=request.getContextPath()%>/piboard"; --%>
//     	            } else {
//     	                var form = document.createElement('form');
//     	                var objs;
//     	                objs = document.createElement('input');
//     	                form.setAttribute('method', 'post');
//     	                form.setAttribute('action', "/detection/pi_detection_regist");
//     	                document.body.appendChild(form);
//     	                form.submit();
//     	            }
//     	        },
//     	        error: function (request, status, error) {
//     	            var form = document.createElement('form');
//     	            form.setAttribute('method', 'post');
//     	            form.setAttribute('action', "/");
//     	            document.body.appendChild(form);
//     	            form.submit();
//     	        }
//     	    });
	    });
    }
</script>
</html>
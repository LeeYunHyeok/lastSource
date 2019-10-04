<%@page language="java"%>
<%@page contentType="text/html;charset=EUC-KR"%>
<%@page import="com.initech.cryptox.util.Base64Util"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.initech.eom.nLs.Ticket"%>
<%@page import="com.initech.eom.nLs.CookieManager"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="com.initech.eom.nLs.NLSHelper"%>
<%@ include file="cutCarriageReturn.jsp" %>


<%
		/*
		#noCacheNonce : 프록시에서의 색상을 방지하기 위한 Cookie와 RequestParameter로 이동됨
		1) LoginFormPage와 resession.jsp에서 생성하고, 그 이후 페이지에 RequestParameter로 넘겨준다.
			-> NLS에서 Page이동시 항상 넘기고 받도록 한다. 
		2) LoginFormPage와 resession.jsp에서 이 이름의 Cookie를 생성해주도록 한다.
		*/
		
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
	if(navigator.userAgent.indexOf('MSIE 10') == -1 && navigator.userAgent.indexOf("Trident") == -1) {
	//alert("사용중인 IE가 IE10,11 이 아님");
	document.write("<embed id=\"NEXESS_API\" type=\"application/initech/npNexessClient,version=2,6,1,1\" width=0 height=0 ><br>");
	}else{
	//alert("사용중인 IE가 10 OR 11임");
	document.write("<OBJECT ID=\"NEXESS_API\" CLASSID=\"CLSID:D4F62B67-8BA3-4A8D-94F6-777A015DB612\" width=0 height=0 ></OBJECT>");
	}
</script>
<![endif]>

<script language=javascript>
	
		alert("Vni ck");
		console.log("Eni ck");
		
		var ticket = NEXESS_API.GetTicket("<%=nonceStr%>")
		var ssoid = NEXESS_API.GetLoginID();
		alert(ssoid);
		
		if (ticket.length == 1 || ticket == ""){
			alert("로그인 되어있지 않음 로그인 페이지로 이동필요")
			// self.location.replace("${pageContext.request.contextPath}")
			
		} else {
			while(ticket.indexOf("+") != -1 ){
				ticket = ticket.replace("+", "%2b");
			}
			// alert(ticket);
			self.location.replace("./NCLoginTestEncVerifyTicket.jsp?ticket=" + escape(ticket));
		}

</script>
<%@page import="com.initech.provider.crypto.InitechProvider"%>
<%@page import="com.initech.provider.crypto.Provider"%>
<%@ page language="java"%>
<%@ page contentType="text/html;charset=EUC-KR"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.util.List"%>
<%@ page import="com.initech.eom.nLs.TicketV3"%>
<%@ include file="cutCarriageReturn.jsp" %>

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
		
		int firstIndex	= ticket.indexOf("&&");
		int secondeIndex	= ticket.lastIndexOf("&&");
		String encNonce	= ticket.substring(0, firstIndex);
		String encSKIPAndTime	= ticket.substring(firstIndex + 2, secondeIndex);
		String encIDAndTOA	= ticket.substring(secondeIndex +2);
		
		
		String decNonce = null;
		try {
			decNonce = cutCarriageReturn(TicketV3.decryptNonce(encSKIPAndTime, encNonce));
		} catch (Exception e) {
			System.out.println("티켓검증 실패! 로그인 페이지로 이동필요");
			//response.sendRedirect("fcs?cmd=Error&errorCode=3102");
		}
		
		if (decNonce.equals(savedNonce)) {
		
			res = TicketV3.readIDAndTOA(encSKIPAndTime, encIDAndTOA);
			userid = (String) res.get(0);
			toa = (String) res.get(1);
			//System.out.println("================ [login_exec.jsp] userid = "+userid);
		
		} else {
			System.out.println("티켓검증 실패! 로그인 페이지로 이동필요");
			//response.sendRedirect("fcs?cmd=Error&errorCode=3102");
		}
		
	} catch (Exception e) {
		System.out.println("티켓검증 실패! 로그인 페이지로 이동필요");
		e.printStackTrace();
		//암오화 실패 로그인 페이지로 이동
		//response.sendRedirect("fcs?cmd=Error&errorCode=3102");
	}
%>

<html>
<body>
<b>Nexess Login Agent</b><br>
Login Success<br>
&nbsp&nbsp&nbsp&nbsp userid = [<%=userid%>]<br>
&nbsp&nbsp&nbsp&nbsp toa = [<%=toa%>]<br>
</body>
</html>
<%@ page import="com.example.loginsidechannels.*" %>
<%
if(session.getAttribute("email") != null){
	getServletContext().getRequestDispatcher(Routes.SECURE_AREA).include(request, response);
} else {
	getServletContext().getRequestDispatcher(Routes.LOGIN).include(request, response);
}
%>
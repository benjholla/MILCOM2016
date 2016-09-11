<%@ page import="com.example.loginsidechannels.*" %>
<% session.invalidate(); %>
<p style="color:gray; text-align:center">Successfully logged out.</p>
<% getServletContext().getRequestDispatcher(Routes.LOGIN).include(request, response); %>
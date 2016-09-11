<%@ page import="java.sql.*"%>
<%@ page import="java.security.*" %>
<%@ page import="com.example.loginsidechannels.*" %>
<%
String emailParam = request.getParameter("email");
String passwordParam = request.getParameter("password");
if (emailParam != null && !emailParam.equals("") && passwordParam != null && !passwordParam.equals("")){
	try {
		Database database = Database.getInstance();
		Connection connection = database.getConnection();
		String sql = "SELECT * FROM webdb.users where Email=? LIMIT 1";
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setString(1, emailParam);
		ResultSet result = statement.executeQuery();
		if (result.next()){
			String email = result.getString("Email");
			String hashedPassword = result.getString("Password");
			String salt = result.getString("Salt");
			String role = result.getString("Role");
			if(AuthUtils.hash(passwordParam, salt).equals(hashedPassword)){
				session.setAttribute("email", email);
				session.setAttribute("role", role);
				response.sendRedirect(Routes.SECURE_AREA);
			} else {
				response.sendRedirect(Routes.LOGIN_ERROR);
			}
		} else {
			response.sendRedirect(Routes.LOGIN_ERROR);
		}
		result.close();
		statement.close();
		database.close();
	} catch (SQLException sqe){
		response.sendRedirect(Routes.LOGIN_ERROR);
	}
} else { 
%>
	<p style="color:red; text-align:center">Please enter your email and password.</p>
<% 
	getServletContext().getRequestDispatcher(Routes.LOGIN).include(request, response);
}
%>
<%@ page import="java.sql.*"%>
<%@ page import="com.example.loginsidechannels.*" %>
  
  <% if(!session.getAttribute("role").equals("admin")){ %>
	<p style="color:red; text-align:left; margin-left:150px;">Restricted action.</p>
	<% getServletContext().getRequestDispatcher(Routes.SECURE_AREA).include(request, response); %>
  <% } %>
  
  <%
  String emailParam = request.getParameter("email");
  String passwordParam = request.getParameter("password");
  String confirmPasswordParam = request.getParameter("confirm_password");
  String roleParam = request.getParameter("role");
  %>
  <% if (emailParam != null && !emailParam.equals("")){ %>
	<% if (passwordParam != null && !passwordParam.equals("")){ %>
		<% if (confirmPasswordParam != null && !confirmPasswordParam.equals("")){ %>
			<% if (passwordParam.equals(confirmPasswordParam)){ %>
				<% if (roleParam != null && !roleParam.equals("")){ %>
					<% try { %>
						<%
						Database database = Database.getInstance();
						Connection connection = database.getConnection();
						String sql = "INSERT INTO users (Email, Role, Salt, Password) values (?, ?, ?, ?)";
						PreparedStatement statement = connection.prepareStatement(sql);
						
						// set email and role
						statement.setString(1, emailParam);
						statement.setString(2, roleParam.equals("admin") ? "admin" : "user");
						
						// generate a random salt
						String salt = AuthUtils.generateSalt();
						statement.setString(3, salt);
						
						// salt and hash the password
						statement.setString(4, AuthUtils.hash(passwordParam, salt));
						
						// insert user
						statement.execute();
						statement.close();
						database.close();
						%>
						<p style="color:green; text-align:left; margin-left:150px;">Successfully added account.</p>
						<% getServletContext().getRequestDispatcher(Routes.SECURE_AREA).include(request, response); %>
					<% } catch (SQLException sqe){ %>
						<p style="color:red; text-align:left; margin-left:150px;">Error adding account.</p>
						<% getServletContext().getRequestDispatcher(Routes.SECURE_AREA).include(request, response); %>
					<% } %>
				<% } else { %>
					<p style="color:red; text-align:left; margin-left:150px;">Role is missing.</p>
					<% getServletContext().getRequestDispatcher(Routes.SECURE_AREA).include(request, response); %>
				<% } %>
			 <% } else { %>
				<p style="color:red; text-align:left; margin-left:150px;">Passwords do not match.</p>
				<% getServletContext().getRequestDispatcher(Routes.SECURE_AREA).include(request, response); %>
			<% } %>
		<% } else { %>
			<p style="color:red; text-align:left; margin-left:150px;">Please confirm password.</p>
			<% getServletContext().getRequestDispatcher(Routes.SECURE_AREA).include(request, response); %>
		<% } %>
	<% } else { %>
		<p style="color:red; text-align:left; margin-left:150px;">Password is missing.</p>
		<% getServletContext().getRequestDispatcher(Routes.SECURE_AREA).include(request, response); %>
	<% } %>
<% } else { %>
	<p style="color:red; text-align:left; margin-left:150px;">Email is missing.</p>
	<% getServletContext().getRequestDispatcher(Routes.SECURE_AREA).include(request, response); %>
<% } %>

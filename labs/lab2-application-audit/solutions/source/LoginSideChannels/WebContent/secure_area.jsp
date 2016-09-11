<%@ page import="com.example.loginsidechannels.*" %>
<% 
if(session.getAttribute("email") == null){
	response.sendRedirect(Routes.LOGIN);
}
%>
<!DOCTYPE html>
<html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/favicon.ico" type="image/x-icon">

    <title>Web Portal</title>

    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/css/starter-template.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/js/ie10-viewport-bug-workaround.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Web Portal</a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="/users/logout.jsp">Logout</a></li>
          </ul>
        </div>
      </div>
    </div>

	<div class="container" style="margin-top:30px">
		<div class="starter-template">
			<h1>Secure Area</h1>
			<p class="lead">Welcome <%=session.getAttribute("role")%>: <%=session.getAttribute("email")%></p>
		</div>
		<% if(session.getAttribute("role").equals("admin")){ %>
		<div class="col-md-4">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title"><strong>Create Account</strong></h3>
				</div>
				<div class="panel-body">
					<form  method="post" action="/users/create.jsp" role="form">
						<div class="form-group">
							<label for="email">Email</label>
							<input type="email" class="form-control" id="email" name="email" placeholder="Enter email">
						</div>
						<div class="form-group">
							<label for="password">Password</label>
							<input type="password" class="form-control" id="password" name="password" placeholder="Password">
						</div>
						<div class="form-group">
							<label for="confirm_password">Confirm Password</label>
							<input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="Password (again)">
						</div>
						<div class="form-group">
							<label for="role">Role</label>
							<br /><input type="radio" name="role" value="user" checked="checked">User
							<br /><input type="radio" name="role" value="admin">Administrator
						</div>
						<button type="submit" class="btn btn-sm btn-default">Create account</button>
					</form>
				</div>
			</div>
		</div>
		<% } %>
	</div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
  
</body>
</html>

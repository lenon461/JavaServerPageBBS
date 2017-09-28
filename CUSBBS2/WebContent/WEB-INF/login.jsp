<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width-device-width">
<link rel="stylesheet" href="css/bootstrap.css">
<title>BOARD WEB SITE</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="main.jsp">BOARD WEB SITE</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
			<div class="navbar-nav">
				<a class="nav-item nav-link" href="main.jsp">Home </a> <a
					class="nav-item nav-link" href="board.jsp">Board</a> <a
					class="nav-item nav-link active" href="login.jsp">login</a> <a
					class="nav-item nav-link disabled" href="#">Disabled</a>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron" style="padding-top: 20px;">

			<form method="post" action="loginAction.jsp">
				<h3 style="text-align: center;">WELCOME TO BOARDSITE</h3>
			
				<div class="form-group">
					<label for="userID">ID</label> 
					<input type="text"
						class="form-control" id="userID"
						name="userID"
						placeholder="ID">
				</div>
				<div class="form-group">
					<label for="Password">Password</label> 
					<input
						type="password" class="form-control" id="Password"
						name="userPassword" 
						placeholder="Password">
				</div>

				<button type="submit" class="btn btn-primary">Submit</button>
				<span style="float:right"><a href="join.jsp" class="btn btn-success">join</a>
			</span></form>
		</div>
	</div>
</body>
</html>
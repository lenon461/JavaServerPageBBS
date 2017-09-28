<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.board" %>
<%@ page import="board.boardDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width-device-width">
<link rel="stylesheet" href="css/bootstrap.css">
<title>BOARD WEB SITE</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		int boardNum = 0;
		if (request.getParameter("boardNum") != null){
			boardNum = Integer.parseInt(request.getParameter("boardNum"));
		}
		if(boardNum == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
		board board = new boardDAO().getBoard(boardNum);
		if(!userID.equals(board.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
	%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="main.jsp">BOARD WEB SITE</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>

		</button>
		<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
			<div class="navbar-nav">
				<a class="nav-item nav-link" href="main.jsp">Home 
				<span class="sr-only">(current)</span></a> 
				<a class="nav-item nav-link active" 
				href="board.jsp">Board</a>
				<%
					if (userID == null) {
				%>
				<a class="nav-item nav-link" href="login.jsp">login</a>

				<%
					} else {
				%>
				<a class="nav-item nav-link" href="logoutAction.jsp">logout</a> <span
					style="float: right;"><a href="myinfo.jsp"
					class="btn btn-outline-secondary"><%=userID%></a> </span>

				<%
					}
				%>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="inherit">
			<form method="post" action="updateAction.jsp?boardNum=<%=boardNum%>">
				<table class="table table-inverse" style="text-align: center;"	>
					<thead>
						<tr>
							<th>Board</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="Title" name="boardTitle" maxlength="50" value="<%= board.getBoardTitle() %>"></td>
						</tr>
						<tr>
							<td><textarea type="text" class="form-control"
									placeholder="Content" name="boardContent" maxlength="2048"
									
									style="height: 350px;"><%= board.getBoardContent()%></textarea></td>
						</tr>

					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right"
					value="update">
			</form>

		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1. min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
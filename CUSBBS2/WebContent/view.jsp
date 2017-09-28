<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.board"%>
<%@ page import="board.boardDAO"%>
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
		int pageNumber = 1;
		
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		board board = new boardDAO().getBoard(boardNum);
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


	<div class="col">
		<table class="table table-inverse" style="text-align: center;">
			<thead>
				<tr>
					<td colspan="3">글 보기</td>
				</tr>
			</thead>
			<tbody>
			<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= board.getBoardTitle() %></td>
					</tr>
				<tr>
						<td>작성자</td>
						<td colspan="2"><%= board.getUserID() %></td>
					</tr><tr>
						<td style="width: 20%;">작성일자</td>
						<td colspan="2"><%= board.getBoardDate()%></td>
					</tr><tr>
						<td style="width: 20%;">글내용</td>
						<td colspan="2"><%= board.getBoardContent() %></td>
					</tr>

			</tbody>
		</table>
		
		
		<a href="board.jsp?pageNumber=<%= pageNumber%>" class="btn btn-primary pull-right">목록</a>
		<%
				if(userID != null && userID.equals(board.getUserID())){
			%>		
				<a href="update.jsp?boardNum=<%= boardNum%>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?boardNum=<%= boardNum%>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
	</div>


<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>
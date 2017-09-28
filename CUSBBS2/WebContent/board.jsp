<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.board"%>
<%@ page import="board.boardDAO"%>
<%@ page import="java.util.ArrayList"%>
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
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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


	<div class="col">
		<table class="table table-inverse" style="text-align: center;">
			<thead style="text-align: center;">
				<tr>
					<td>글 번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성시간</td>
				</tr>
			</thead>
			<tbody>
			<%
					boardDAO BoardDAO = new boardDAO();
					ArrayList<board> list = BoardDAO.getlist(pageNumber);
					list.size();
					for (int i = 0; i < list.size(); i++) {
				%>
				
				
				<tr>
					<td><%=list.get(i).getBoardNum()%>
					</td>
					<td><a href="view.jsp?boardNum=<%=list.get(i).getBoardNum()%>"><%=list.get(i).getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
					<td><%=list.get(i).getUserID()%></td>
					<td><%=list.get(i).getBoardDate().substring(0, 11) + list.get(i).getBoardDate().substring(11, 13)
						+ "시" + list.get(i).getBoardDate().substring(14, 16) + "분"%></td>
				</tr>
				<%
					}
				%>

			</tbody>
		</table>
		

		<%
			if (pageNumber != 1) {
		%>
		<a href="board.jsp?pageNumber=<%=pageNumber - 1%>"
			class="btn btn-success btn-arraw-left">이전</a>
		<%
			}
			if (BoardDAO.nextPage(pageNumber + 1)) {
		%>
		<a href="board.jsp?pageNumber=<%=pageNumber + 1%>"
			class="btn btn-success btn-arraw-left">다음</a>
		<%
			}
		%>
		<span style= "float:right;"><a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
</span>
	</div>


<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>
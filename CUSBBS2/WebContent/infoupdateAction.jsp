<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<% request.setCharacterEncoding("UTF-8"); %>
	
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<jsp:useBean id="user" class="user.User" scope="page" />


<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userPassword" />

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
		int userNum = 0;
		if (request.getParameter("userNum") != null){
			userNum = Integer.parseInt(request.getParameter("userNum"));
		}
		if(user.getUserPassword()== null || user.getUserName() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");
		}else{

			UserDAO userDAO = new UserDAO();
			int result = userDAO.update(userID, user.getUserPassword(), user.getUserName());
			if (result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('정보 수정에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
				
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'myinfo.jsp'");
				script.println("</script>");
			}
			
		}
		
		
	%>
</body>
</html>
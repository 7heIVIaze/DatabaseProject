<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	PrintWriter script = response.getWriter();

	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = (String)session.getAttribute("DBID");
	String pass = (String)session.getAttribute("DBPW");
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

	Connection conn = null;
	PreparedStatement pstmt;
	Statement stmt = null;
	ResultSet rs, rs2, rs3;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	String type = (String)session.getAttribute("userType");
	int userId = (int)session.getAttribute("userId");
	int rId = Integer.parseInt(request.getParameter("reserveId"));

	conn.setAutoCommit(false);//transaction 추가
	conn.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
			
	try{
		if(type.equals("client")) {
			String sql = "delete from reservation where cid = " + userId + "and id = " + rId;
			stmt = conn.createStatement();
			int res = stmt.executeUpdate(sql);
			
			if(res > 0) {
				script.println("<script type='text/javascript'>");
				script.println("alert('예약삭제완료');");
				script.println("location.href='MyPage.jsp'");
				script.println("</script>");
			}
			
			conn.commit();//transaction 추가
			conn.setAutoCommit(true);
			script.flush();
		}
		else if(type.equals("admin")) {
			String sql = "delete from reservation where id = " + rId;
			stmt = conn.createStatement();
			int res = stmt.executeUpdate(sql);
			
			
			if(res > 0) {
				script.println("<script type='text/javascript'>");
				script.println("alert('예약삭제완료');");
				script.println("location.href='AdminReservation.jsp'");
				script.println("</script>");
			}
			
			conn.commit();//transaction 추가
			conn.setAutoCommit(true);
			script.flush();
		}
	}
	catch(Exception e){
		conn.rollback(); //trnasaction rollback 추가
		script.println("<script type='text/javascript'>");
		script.println("alert('예약삭제실패');");
		script.println("history.go(-1);");
		script.println("</script>");
		script.flush();
		e.printStackTrace();
	}
	
	finally{
		stmt.close();
		conn.close();
	}
%>
</body>
</html>
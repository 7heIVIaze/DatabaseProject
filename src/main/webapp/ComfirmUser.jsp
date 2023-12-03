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
	String url = "jdbc:oracle:thin:@" + serverIP + ":"
	+ portNum + ":" + strSID;
	
	Connection conn = null;
	Statement stmt = null;
	

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, user, pass);
        conn.setAutoCommit(false);
        stmt = conn.createStatement();

        // 사용자로부터 입력 받기
        String password = null; // 확인할 비밀번호
		String memPass = null; // 환자 비밀번호
		int id = (Integer)session.getAttribute("userId");; // 아이디 값 담을 변수 생성
		if (request.getParameter("password") == null) { //비밀번호에 아무 것도 입력하지 않았을 때
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("alert('비밀번호를 입력해주세요.')");
			pw.println("history.back();");
			pw.println("</script>");
			pw.close();
			return;
		}
		password = request.getParameter("password");
		
		String sql = "select password from client where id = " + id;
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			memPass = rs.getString(1);
			break;
		}
        
		if(password.equals(memPass)){
			pageContext.forward("Update.jsp");
		}
		else{
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("alert('비밀번호가 맞지 않습니다.')");
			pw.println("history.back();");
			pw.println("</script>");
			pw.close();
			return;
		}
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("에러 발생: " + ex.getMessage());
    } finally {
        try {
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	
	

%>


</body>
</html>
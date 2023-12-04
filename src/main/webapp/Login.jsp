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
        conn.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
        stmt = conn.createStatement();

        // 사용자로부터 입력 받기
        String type = request.getParameter("type");
        
        if("client".equals(type)) {
	        String inputEmail = request.getParameter("email");
	        String inputPassword = request.getParameter("password");
	        if (inputEmail != null && inputPassword != null) {
	            // 입력받은 ID와 비밀번호를 이용하여 데이터베이스에서 검증
	            String query = "SELECT * FROM Client WHERE Email = '" + inputEmail + "' AND password = '" + inputPassword + "'";
	            ResultSet rs = stmt.executeQuery(query);
	
	            if (rs.next()) {
	                // 로그인 성공
	                int id = rs.getInt(1);
	                session.setAttribute("userId", id);
	                session.setAttribute("userType", "client");
	                conn.close();
					rs.close();
					stmt.close();
					script.println("<script type='text/javascript'>");
					script.println("alert('로그인 성공.');");
					script.println("</script>");
	        		response.sendRedirect("Search.jsp");
	            } else {
	                // 로그인 실패
	                script.println("<script type='text/javascript'>");
					script.println("alert('로그인 실패. 이메일 또는 비밀번호를 확인해주세요.');");
					script.println("history.go(-1);");
					script.println("</script>");
	            }
	        }
        }
        else if("admin".equals(type)) {
        	String inputId = request.getParameter("id");
	        String inputPassword = request.getParameter("password");
	        
	        if (inputId != null && inputPassword != null) {
	            // 입력받은 ID와 비밀번호를 이용하여 데이터베이스에서 검증
	            if(inputId.equals("university") && inputPassword.equals("comp322")) {
	                session.setAttribute("userId", 1);
	                session.setAttribute("userType", "admin");
	                conn.close();
					//rs.close();
					stmt.close();
					script.println("<script type='text/javascript'>");
					script.println("alert('로그인 성공.');");
					script.println("</script>");
	        		response.sendRedirect("Search.jsp");
	            	
	            }
           	} else {
                // 로그인 실패
                script.println("<script type='text/javascript'>");
				script.println("alert('로그인 실패. 이메일 또는 비밀번호를 확인해주세요.');");
				script.println("history.go(-1);");
				script.println("</script>");
            }
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
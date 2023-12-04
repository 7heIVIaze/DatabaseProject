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

        // ����ڷκ��� �Է� �ޱ�
        String type = request.getParameter("type");
        
        if("client".equals(type)) {
	        String inputEmail = request.getParameter("email");
	        String inputPassword = request.getParameter("password");
	        if (inputEmail != null && inputPassword != null) {
	            // �Է¹��� ID�� ��й�ȣ�� �̿��Ͽ� �����ͺ��̽����� ����
	            String query = "SELECT * FROM Client WHERE Email = '" + inputEmail + "' AND password = '" + inputPassword + "'";
	            ResultSet rs = stmt.executeQuery(query);
	
	            if (rs.next()) {
	                // �α��� ����
	                int id = rs.getInt(1);
	                session.setAttribute("userId", id);
	                session.setAttribute("userType", "client");
	                conn.close();
					rs.close();
					stmt.close();
					script.println("<script type='text/javascript'>");
					script.println("alert('�α��� ����.');");
					script.println("</script>");
	        		response.sendRedirect("Search.jsp");
	            } else {
	                // �α��� ����
	                script.println("<script type='text/javascript'>");
					script.println("alert('�α��� ����. �̸��� �Ǵ� ��й�ȣ�� Ȯ�����ּ���.');");
					script.println("history.go(-1);");
					script.println("</script>");
	            }
	        }
        }
        else if("admin".equals(type)) {
        	String inputId = request.getParameter("id");
	        String inputPassword = request.getParameter("password");
	        
	        if (inputId != null && inputPassword != null) {
	            // �Է¹��� ID�� ��й�ȣ�� �̿��Ͽ� �����ͺ��̽����� ����
	            if(inputId.equals("university") && inputPassword.equals("comp322")) {
	                session.setAttribute("userId", 1);
	                session.setAttribute("userType", "admin");
	                conn.close();
					//rs.close();
					stmt.close();
					script.println("<script type='text/javascript'>");
					script.println("alert('�α��� ����.');");
					script.println("</script>");
	        		response.sendRedirect("Search.jsp");
	            	
	            }
           	} else {
                // �α��� ����
                script.println("<script type='text/javascript'>");
				script.println("alert('�α��� ����. �̸��� �Ǵ� ��й�ȣ�� Ȯ�����ּ���.');");
				script.println("history.go(-1);");
				script.println("</script>");
            }
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("���� �߻�: " + ex.getMessage());
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
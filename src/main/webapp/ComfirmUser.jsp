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

        // ����ڷκ��� �Է� �ޱ�
        String password = null; // Ȯ���� ��й�ȣ
		String memPass = null; // ȯ�� ��й�ȣ
		int id = (Integer)session.getAttribute("userId");; // ���̵� �� ���� ���� ����
		if (request.getParameter("password") == null) { //��й�ȣ�� �ƹ� �͵� �Է����� �ʾ��� ��
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("alert('��й�ȣ�� �Է����ּ���.')");
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
			pw.println("alert('��й�ȣ�� ���� �ʽ��ϴ�.')");
			pw.println("history.back();");
			pw.println("</script>");
			pw.close();
			return;
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
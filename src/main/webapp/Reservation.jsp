<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
	PrintWriter pw = response.getWriter();
	
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = (String)session.getAttribute("DBID");
	String pass = (String)session.getAttribute("DBPW");
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	
	
	try {
	    Class.forName("oracle.jdbc.driver.OracleDriver");
	    conn = DriverManager.getConnection(url, user, pass);
	    conn.setAutoCommit(false);
	    stmt = conn.createStatement();
        // ����ڷκ��� �Է� �ޱ�
        int IdHospital = -1; //���� ���̵�
		int Idclient = -1;// ȯ�� ���̵�
		String docName = null;// �����ǻ�
		String rrn = null; // �ֹι�ȣ ���ڸ�
		String namepatient = null; //ȯ���̸�
		String symptom = null; // ����
		String reserveDate = null; //���೯¥
    	    
		if(request.getParameter("IdHospital")!=null){
			IdHospital = Integer.parseInt(request.getParameter("IdHospital"));
		}
		if (request.getParameter("Idpatient") != null) {
			Idclient = Integer.parseInt(request.getParameter("Idpatient"));
		}
		if (request.getParameter("docName") != null) {
			docName = request.getParameter("docName");
		}
		if (request.getParameter("department1") != null) {
			rrn = request.getParameter("department1");
			String sql = "select name from kid where rrn = '" + rrn + "'";
			
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				namepatient = rs.getString(1);
			}
		}
		if (request.getParameter("symptom") != null) {
			symptom = request.getParameter("symptom");
		}
		if (request.getParameter("reserveDate") != null) {
			reserveDate = request.getParameter("reserveDate");
		}
		
		if (IdHospital == -1 || Idclient == -1 || docName == null || rrn == null || symptom == null || reserveDate == null || namepatient == null)
		{
			out.println(IdHospital + " " + Idclient + " " + docName + " " + rrn + " " + symptom + " " + reserveDate + " " + namepatient);
			pw.println("<script>");
			pw.println("alert('�Է��� �ùٸ��� �ʽ��ϴ�.')");
			pw.println("history.back();");
			pw.println("</script>");
			pw.close();
			return;
		}
		
		int nextId = -1;
		String sql = "select max(id) from reservation";
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next()) {
			nextId = rs.getInt(1);
			nextId++;
			rs.close();
			break;
		}
		
		int res = 0;
		SimpleDateFormat format = new SimpleDateFormat("mm/dd/yyyy");
		java.util.Date parsedDate = format.parse(reserveDate);
		java.sql.Date date = new java.sql.Date(parsedDate.getTime());
		
		sql = "insert into reservation values (?, ?, ?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, nextId);
		pstmt.setDate(2, date);
		pstmt.setString(3, docName);
		pstmt.setString(4, rrn);
		pstmt.setString(5, namepatient);
		pstmt.setInt(6, IdHospital);
		pstmt.setInt(7, Idclient);
		
		res = pstmt.executeUpdate();
		if(res > 0)
		{
			response.sendRedirect("Search.jsp");
		}
		conn.commit();//transaction �߰�
		pstmt.close();
		conn.setAutoCommit(true);
		pw.flush();
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("���� �߻�: " + ex.getMessage());
        conn.rollback(); //trnasaction rollback �߰�
        pw.println("<script type='text/javascript'>");
        pw.println("alert('�������');");
        pw.println("history.go(-1);");
        pw.println("</script>");
        pw.flush();
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
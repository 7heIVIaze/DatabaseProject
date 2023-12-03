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
	PreparedStatement pstmt = null;
	

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, user, pass);
        conn.setAutoCommit(false);
        stmt = conn.createStatement();

        // 사용자로부터 입력 받기
        int hosId = Integer.parseInt(request.getParameter("hId"));
        int id = (int)session.getAttribute("userId");
        String rdate = request.getParameter("rdate");
        int rating = Integer.parseInt(request.getParameter("rating"));
    	String review = request.getParameter("review");
        
    	int nextId = -1;
    	String sql = "select count(rid) from rating";
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()) {
        	nextId = rs.getInt(1);
        	break;
        }
        rs.close();
        stmt.close();
    	
        sql = "insert into rating values (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
		java.util.Date parsedDate = format.parse(rdate);
		java.sql.Date date = new java.sql.Date(parsedDate.getTime());
        
        pstmt.setInt(1, nextId);
        pstmt.setInt(2, id);
        pstmt.setInt(3, hosId);
        pstmt.setDate(4, date);
        pstmt.setInt(5, rating);
        pstmt.setString(6, review);
            
        int res = pstmt.executeUpdate();
		if(res > 0)
		{
			response.sendRedirect("Search.jsp");
		}
		conn.commit();//transaction 추가
		pstmt.close();
		conn.setAutoCommit(true);
		conn.close();
		stmt.close();
		script.flush();
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("에러 발생: " + ex.getMessage());
        conn.rollback(); //trnasaction rollback 추가
		script.println("<script type='text/javascript'>");
		script.println("alert('리뷰실패');");
		script.println("history.go(-1);");
		script.println("</script>");
		script.flush();
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
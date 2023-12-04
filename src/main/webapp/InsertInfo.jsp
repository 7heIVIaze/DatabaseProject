<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8");%>
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
	
	String name = new String(request.getParameter("name").getBytes("8859_1"), "utf-8");
	String rrn = request.getParameter("rrn");
	String sex = request.getParameter("sex");
	int age = Integer.parseInt(request.getParameter("age"));
	int id = (Integer)session.getAttribute("userId");
	
	String sql = "select rrn from kid";
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	
	
	int flag = 0; // 1: 중복 존재, 2: 주민번호 없음, 3: 이름 없음, 4: 성별 없음
	
	if(rrn.length() == 0){
		flag = 2;
	}
	if(name.length() == 0) flag = 3;
	if(sex.length() == 0) flag = 4;
	
	while(rs.next()){
		String rrnCheck = rs.getString(1);
		if(rrnCheck.equals(rrn)){
			flag = 1;
			break;
		}
	}
	
	int a = 0;
	
	if(flag == 1){
		
		script.println("<script type='text/javascript'>");
		script.println("alert('주민번호가 중복됩니다.');");
		script.println("history.back();");
		script.println("</script>");		
	}
	else if(flag == 2){
		script.println("<script type='text/javascript'>");
		script.println("alert('주민번호를 입력해주세요!');");
		script.println("history.back();");
		script.println("</script>");		
	}
	else if(flag == 3){
		script.println("<script type='text/javascript'>");
		script.println("alert('이름을 입력해주세요!');");
		script.println("history.back();");
		script.println("</script>");	
		
	}
	else if(flag == 4){ 
		script.println("<script type='text/javascript'>");
		script.println("alert('성별을 입력하세요!');");
		script.println("history.back();");
		script.println("</script>");
	}
	
	else{
		conn.setAutoCommit(false);//transaction 추가
		
		try{
			sql = "insert into kid values ('"
					+ rrn + "', '"
					+ name + "', '"
					+ sex + "', "
					+ age + ", "
					+ id + ")";
			
			
			
			int res = stmt.executeUpdate(sql);
			stmt.close();
			conn.close();
			
			script.println("<script type='text/javascript'>");
			script.println("alert('아이 추가 완료');");
			script.println("history.go(-2);");
			script.println("</script>");
			
			conn.commit();//transaction 추가
			conn.setAutoCommit(true);
			script.flush();
		}
		catch(Exception e){
			conn.rollback(); //trnasaction rollback 추가
			script.println("<script type='text/javascript'>");
			script.println("alert('아이추가실패');");
			out.println(sql);
			//script.println("history.go(-1);");
			script.println("</script>");
			script.flush();
			e.printStackTrace();
		}
		
		finally{
			stmt.close();
			conn.close();
			rs.close();
		}
	}
%>
</body>
</html>
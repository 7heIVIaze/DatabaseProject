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
	
	
	int flag = 0; // 1: �ߺ� ����, 2: �ֹι�ȣ ����, 3: �̸� ����, 4: ���� ����
	
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
		script.println("alert('�ֹι�ȣ�� �ߺ��˴ϴ�.');");
		script.println("history.back();");
		script.println("</script>");		
	}
	else if(flag == 2){
		script.println("<script type='text/javascript'>");
		script.println("alert('�ֹι�ȣ�� �Է����ּ���!');");
		script.println("history.back();");
		script.println("</script>");		
	}
	else if(flag == 3){
		script.println("<script type='text/javascript'>");
		script.println("alert('�̸��� �Է����ּ���!');");
		script.println("history.back();");
		script.println("</script>");	
		
	}
	else if(flag == 4){ 
		script.println("<script type='text/javascript'>");
		script.println("alert('������ �Է��ϼ���!');");
		script.println("history.back();");
		script.println("</script>");
	}
	
	else{
		conn.setAutoCommit(false);//transaction �߰�
		
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
			script.println("alert('���� �߰� �Ϸ�');");
			script.println("history.go(-2);");
			script.println("</script>");
			
			conn.commit();//transaction �߰�
			conn.setAutoCommit(true);
			script.flush();
		}
		catch(Exception e){
			conn.rollback(); //trnasaction rollback �߰�
			script.println("<script type='text/javascript'>");
			script.println("alert('�����߰�����');");
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
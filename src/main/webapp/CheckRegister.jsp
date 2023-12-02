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
	
	String email = new String(request.getParameter("email").getBytes("8859_1"), "EUC-KR");
	String address = new String(request.getParameter("address").getBytes("8859_1"), "EUC-KR");
	String phone = request.getParameter("phone");
	String password = request.getParameter("password");
	String password2 = request.getParameter("password2");
	String regType = new String(request.getParameter("regType"));
	
	String sql = "select Email from client";
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	
	
	int flag = 0; // 1: �ߺ� ����, 2: �̸��� ����, 3: �̸��� ������, 4: ��ȭ��ȣ ����, 5: �ּ� ����, 6: ��й�ȣ �ٸ�, 7: ��й�ȣ ����
	
	if(email.length() == 0){
		flag = 2;
	}
	else if (!(email.substring(email.length() - 4, email.length()).equals(".com"))) {
		flag = 3;
	}
	
	if(phone.length() == 0) flag = 4;
	if(address.length() == 0) flag = 5;
	
	if(!(password.equals(password2))){
		flag = 6;
	}
	if(password.length() == 0 || password2.length() == 0){
		flag = 7;
	}
	
	while(rs.next()){
		String emailcheck = rs.getString(1);
		emailcheck = emailcheck.substring(1, emailcheck.length());
		if(emailcheck.equals(email)){
			flag = 1;
			break;
		}
	}
	
	int a = 0;
	
	if(flag == 1){
		
		script.println("<script type='text/javascript'>");
		script.println("alert('�̸��� �ߺ��˴ϴ�. ���Ұ���.');");
		script.println("history.back();");
		script.println("</script>");		
	}
	else if(flag == 2){
		script.println("<script type='text/javascript'>");
		script.println("alert('�̸����� �Է����ּ���!');");
		script.println("history.back();");
		script.println("</script>");		
	}
	else if(flag == 3){
		script.println("<script type='text/javascript'>");
		script.println("alert('�̸��� ���Ŀ� ���� �ʽ��ϴ�!');");
		script.println("history.back();");
		script.println("</script>");	
		
	}
	else if(flag == 4){ 
		script.println("<script type='text/javascript'>");
		script.println("alert('��ȭ��ȣ�� �Է��ϼ���!');");
		script.println("history.back();");
		script.println("</script>");
	}
	else if(flag == 5){
		script.println("<script type='text/javascript'>");
		script.println("alert('�ּҸ� �Է��ϼ���!');");
		script.println("history.back();");
		script.println("</script>");
	}
	else if(flag == 6){
		script.println("<script type='text/javascript'>");
		script.println("alert('��й�ȣ�� ��ġ���� �ʽ��ϴ�');");
		script.println("history.back();");
		script.println("</script>");
	}
	else if(flag == 7){
		script.println("<script type='text/javascript'>");
		script.println("alert('��й�ȣ�� �Է��ϼ���!');");
		script.println("history.back();");
		script.println("</script>");
	}
	else{
		email = email;
		if(regType.equals("client")){
			conn.setAutoCommit(false);//transaction �߰�
			
			try{
				String query = "select max(Id) from client";
				rs = stmt.executeQuery(query);
				int lateId = 0;
						
				while (rs.next()) 
	            {
	            	lateId = rs.getInt(1);
	            	break;
	            } 
            	lateId++;

				query = "insert into client values ("
						+ lateId + ", '"
						+ password + "', '"
						+ phone + "', '"
						+ address + "', '"
						+ email + "')";
				
				int res = stmt.executeUpdate(query);
				stmt.close();
				conn.close();
				
				script.println("<script type='text/javascript'>");
				script.println("alert('ȸ�����ԿϷ�');");
				script.println("history.go(-2);");
				script.println("</script>");
				
				conn.commit();//transaction �߰�
				conn.setAutoCommit(true);
				script.flush();
			}
			catch(Exception e){
				conn.rollback(); //trnasaction rollback �߰�
				script.println("<script type='text/javascript'>");
				script.println("alert('ȸ�����Խ���');");
				script.println("history.go(-1);");
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
		else{
			conn.setAutoCommit(false);//transaction �߰�
			
			try{
				String query = "select max(Id) from client";
				rs = stmt.executeQuery(query);
				int lateId = 0;
						
				while (rs.next()) 
	            {
	            	lateId = rs.getInt(1);
	            	break;
	            } 
            	lateId++;

				query = "insert into client values ("
						+ lateId + ", '"
						+ password + "', '"
						+ phone + "', '"
						+ address + "', '"
						+ email + "')";
				
				int res = stmt.executeUpdate(query);
				stmt.close();
				conn.close();
				
				script.println("<script type='text/javascript'>");
				script.println("alert('ȸ�����ԿϷ�');");
				script.println("history.go(-2);");
				script.println("</script>");
				
				conn.commit();//transaction �߰�
				conn.setAutoCommit(true);
				script.flush();
			}
			catch(Exception e){
				conn.rollback(); //trnasaction rollback �߰�
				script.println("<script type='text/javascript'>");
				script.println("alert('ȸ�����Խ���');");
				script.println("history.go(-1);");
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
	}
%>
</body>
</html>
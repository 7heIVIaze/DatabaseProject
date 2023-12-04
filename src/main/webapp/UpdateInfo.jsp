<%@ page language="java" contentType="text/html; charset=EUC-KR"
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
	
	String email = new String(request.getParameter("email").getBytes("8859_1"), "EUC-KR");
	String address = new String(request.getParameter("address").getBytes("8859_1"), "EUC-KR");
	String phone = request.getParameter("phone");
	String password = request.getParameter("password");
	String regType = (String)session.getAttribute("userType");
	int id = (Integer)session.getAttribute("userId");
	
	String sql = "select Email from client";
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	
	
	int flag = 0; // 1: 중복 존재, 2: 이메일 없음, 3: 이메일 비정상, 4: 전화번호 없음, 5: 주소 없음, 6: 비밀번호 다름, 7: 비밀번호 없음
	
	if(email.length() == 0){
		flag = 2;
	}
	else if (!(email.substring(email.length() - 4, email.length()).equals(".com"))) {
		flag = 3;
	}
	
	if(phone.length() == 0) flag = 4;
	if(address.length() == 0) flag = 5;
	
	if(password.length() == 0){
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
		script.println("alert('이메일 중복됩니다. 사용불가능.');");
		script.println("history.back();");
		script.println("</script>");		
	}
	else if(flag == 2){
		script.println("<script type='text/javascript'>");
		script.println("alert('이메일을 입력해주세요!');");
		script.println("history.back();");
		script.println("</script>");		
	}
	else if(flag == 3){
		script.println("<script type='text/javascript'>");
		script.println("alert('이메일 형식에 맞지 않습니다!');");
		script.println("history.back();");
		script.println("</script>");	
		
	}
	else if(flag == 4){ 
		script.println("<script type='text/javascript'>");
		script.println("alert('전화번호을 입력하세요!');");
		script.println("history.back();");
		script.println("</script>");
	}
	else if(flag == 5){
		script.println("<script type='text/javascript'>");
		script.println("alert('주소를 입력하세요!');");
		script.println("history.back();");
		script.println("</script>");
	}
	else if(flag == 6){
		script.println("<script type='text/javascript'>");
		script.println("alert('비밀번호가 일치하지 않습니다');");
		script.println("history.back();");
		script.println("</script>");
	}
	else if(flag == 7){
		script.println("<script type='text/javascript'>");
		script.println("alert('비밀번호를 입력하세요!');");
		script.println("history.back();");
		script.println("</script>");
	}
	else{
		email = email;
		if(regType.equals("client")){
			conn.setAutoCommit(false);//transaction 추가
			conn.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
			
			try{
				sql = "UPDATE client SET Password = ?, Phone_Number = ?, Address = ?, Email = ? WHERE Id = ?";
				PreparedStatement updatePwdStmt = conn.prepareStatement(sql);
				updatePwdStmt.setString(1, password);
                updatePwdStmt.setString(2, phone);
                updatePwdStmt.setString(3, address);
                updatePwdStmt.setString(4, email);
                updatePwdStmt.setInt(5, id);
                int res = updatePwdStmt.executeUpdate();
				stmt.close();
				conn.close();
				
				script.println("<script type='text/javascript'>");
				script.println("alert('수정완료');");
				response.sendRedirect("MyPage.jsp");
				script.println("</script>");
				
				conn.commit();//transaction 추가
				conn.setAutoCommit(true);
				script.flush();
			}
			catch(Exception e){
				conn.rollback(); //trnasaction rollback 추가
				script.println("<script type='text/javascript'>");
				script.println("alert(수정실패');");
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
			conn.setAutoCommit(false);//transaction 추가
			conn.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
			
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
				script.println("alert('수정완료');");
				script.println("history.go(-2);");
				script.println("</script>");
				
				conn.commit();//transaction 추가
				conn.setAutoCommit(true);
				script.flush();
			}
			catch(Exception e){
				conn.rollback(); //trnasaction rollback 추가
				script.println("<script type='text/javascript'>");
				script.println("alert('수정실패');");
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
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Choose the menu!</title>
</head>
<body>

	<h2>Welcome to Dr.Baby!</h2>
	<h4>---------------------------- </h4>
	<h4>원하시는 메뉴를 선택해주세요.</h4>
	
	<%
    // 데이터베이스 연결 정보
    String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    String USER_UNIVERSITY = "university"; // id
    String USER_PASSWD = "comp322"; // pw

    Connection conn = null; // Connection object
    Statement stmt = null;   // Statement object

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(URL, USER_UNIVERSITY, USER_PASSWD);
        conn.setAutoCommit(false); // auto-commit disabled
        stmt = conn.createStatement();
%>

<form method="post">
    <select name="menu">
		<option value="updateInfo">1. 회원 정보 수정</option>
		<option value="reservation">2. 진료 예약</option>
		<option value="review">3. 리뷰 보기</option>
		<option value="findHistory">4. 과거 진료 이력 보기</option>
		<option value="findPharmacy">5. 가까운 약국 찾기</option>
		<option value="withdrawal">6. 회원 탈퇴</option>
		<option value="logout">7. 로그아웃</option>
	</select>
	<input type="submit" value="Submit">
</form>

<%
    // 사용자로부터 입력 받기
 	String str = "";
    if (request.getMethod().equalsIgnoreCase("post")) {
        str = request.getParameter("menu");

        if (str.equals("updateInfo")) { // 1. 회원 정보 수정
            response.sendRedirect("updateInfo.jsp"); 
        } else if (str.equals("reservation")) { // 2. 진료 예약
            response.sendRedirect("reservation.jsp"); 
        } else if (str.equals("review")) { // 3. 리뷰 보기
            response.sendRedirect("review.jsp"); 
        } else if (str.equals("findHistory")) { // 4.과거 진료 이력 보기
            response.sendRedirect("findHistory.jsp"); 
        } else if (str.equals("findPharmacy")) { // 5. 가까운 약국 찾기
            response.sendRedirect("findPharmacy.jsp"); 
        } else if (str.equals("withdrawal")) { // 6. 회원 탈퇴
            response.sendRedirect("withdrawal.jsp"); 
        } else if (str.equals("")) { // 7. 로그아웃 -> 맨 처음으로 돌아감
            response.sendRedirect("version.jsp"); 
        }
    }
%>

<%
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

	<h4>---------------------------- </h4>

</body>
</html>
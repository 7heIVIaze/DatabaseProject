<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, jsp.member.model.*, java.sql.*"%>
<jsp:useBean id="datas" scope="request" class="java.util.ArrayList" />
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 스크립트 부분 -->
<script
src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
crossorigin="anonymous"></script>
<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
rel="stylesheet"
integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
crossorigin="anonymous">
<link rel="stylesheet" href="./css/custom.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/7f5811a0ff.js"
crossorigin="anonymous"></script>

<link rel="stylesheet" href="css/MyPageStyles.css">
<title>리뷰현황</title>
</head>
<body>
	<% 
		
			String serverIP = "localhost";
			String strSID = "orcl";
			String portNum = "1521";
			String user = (String)session.getAttribute("DBID");
			String pass = (String)session.getAttribute("DBPW");
			String url = "jdbc:oracle:thin:@" + serverIP + ":"
			+ portNum + ":" + strSID;
			
			Connection conn = null;
			Statement stmt = null;
	
  			String memLogin = null; // 로그인 여부에 따라 탑메뉴 보여주는 로직
  			memLogin = (String)session.getAttribute("userType");
  			int id = (Integer)session.getAttribute("userId");
  			if(memLogin == null){ // 로그인 안했을때 헤더
  				%>
				 <jsp:include page="module/header.jsp" flush="false" />
			<%
  				//}
			}
  			else if(memLogin.equals("client")){ // 환자회원 헤더
  				%>
  				 <jsp:include page="module/clientHeader.jsp" flush="false" />
  				<%
  			}
  			else if(memLogin.equals("admin")){ // 병원회원 헤더
  				%>
 				 <jsp:include page="module/adminHeader.jsp" flush="false" />
 				<%
  			} 
  	%>
  	<div class="container-fluid">
  	  <div class="row justify-content-start">
			  <jsp:include page="module/AdminSidebar.jsp" flush="false" />
		  	  <div class="col-md-9" style="white-space:nowrap;overflow:scroll;height:500px;">
		  	  	<table class="table table-hover" style="width:100%;">
		      		<thead>
		    			<tr>
							<th scope="col">번호</th>
							<th scope="col">병원명</th>
							<th scope="col">날짜</th>
							<th scope="col">점수</th>
							<th scope="col">리뷰</th>
							<th scope="col">리뷰삭제</th>
						</tr>
					</thead>
					<tbody>
						<%
						try {
							Class.forName("oracle.jdbc.driver.OracleDriver");
					        conn = DriverManager.getConnection(url, user, pass);
					        conn.setAutoCommit(false);
					        stmt = conn.createStatement();

							int i = 1; // 테이블의 번호를 세주는 변수
							request.setCharacterEncoding("UTF-8");
							String sql = "select r.rid, h.name, r.rdate, r.rate, r.review from Hospital h join Rating r on h.id = r.hid order by h.id asc, r.rid asc";
			       			
							ResultSet rs = stmt.executeQuery(sql);
							
							while(rs.next()){
							%>
							<tr>
								<th scope="row"><%= i %></th>
								<td><%= rs.getString(2) %></td>
								<td><%= rs.getDate(3).toString() %></td>
								<td><%= rs.getInt(4) %></td>
								<td><%= rs.getString(5) %></td>
						      <form method="post" action="DeleteReview.jsp" >
								<input type="hidden" type = "number" name="reviewId" value=<%=rs.getInt(1) %>>
								<td><button type="submit" class="btn btn-danger btn-sm">리뷰 삭제</button></td>
							</form>
						    </tr>
						<%
							}
							rs.close();
						}catch (Exception ex) {
					        ex.printStackTrace();
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
		  			</tbody>
		  		</table>
		  	  </div>
  		</div>
  	</div>
    
    <jsp:include page="module/footer.jsp" flush="false"/>	
    
    <!-- JS -->
    <script src="js/main.js"></script>
</body>
</html>
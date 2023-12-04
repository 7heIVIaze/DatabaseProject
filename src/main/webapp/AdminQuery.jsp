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
<title>예약현황</title>
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
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, pass);
	
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
  			int res = 0, colCnt = 0;
  	        String sql = "", colName, colType, cmd = "";
  	        ResultSet rs = null;
  	        
  	        if(request.getParameter("sql") != null) {
  	        	sql = request.getParameter("sql");
  	        }
  	%>
  	<div class="container">
 		<div>
			<form class="row" action="AdminQuery.jsp" method="post" id="searchBar">
				<div class="search col-md-6 py-3">
					<div class="Mainsearch">
						<input type="text" placeholder="쿼리를 입력하세요:)"
							class="Mainsearch searchBar" name="sql">
						<button class="Mainsearch icon" onclick="clickBtn()">
							<i class="fa fa-search"></i>
						</button>
						<input type="hidden" name="hoslAction" value="search">
					</div>
				</div>
			</form>
		</div>
	</div>
  	<div class="container-fluid">
  	  <div class="row justify-content-start">
			  <jsp:include page="module/AdminSidebar.jsp" flush="false" />
		  	  <div class="col-md-9" style="white-space:nowrap;overflow:scroll;height:500px;">
		  	  	<table class="table table-hover" style="width:100%;">
		      		<thead>
		    			<tr>
		    			<th scope="col">row</th>
		    			<%
		    			try {		
			    			if(!sql.equals("")) {
			    				int j = 1;
				    			stmt = conn.createStatement();
			    				
				    			rs = stmt.executeQuery(sql);
				    			ResultSetMetaData rsmetadata = rs.getMetaData();
				    			colCnt = rsmetadata.getColumnCount();
				    			
				    			for (int i = 1; i <= colCnt; i++) {  
				    		        colName = rsmetadata.getColumnName(i);     			
			    		
		    			
		    			%>
		    			<% %>
					      <th scope="col"><%=colName %></th>
					      <%	}
				    	 %>
					    </tr>
					</thead>
					<tbody>
						<%
						while(rs.next()) { %>
						<tr>
							    
							      <th scope="row"><%= j++ %></th>
						<%
    		        		for (int i = 1; i <= colCnt; i++) {  
    		        			colType = rsmetadata.getColumnTypeName(i);
    		        			//System.out.println(colName + " " + colType);
    		        			
    		        			switch (colType) {
    		        			case "NUMBER": %>
    		        				<td><%= rs.getInt(i) %></td>
    		        				<%
    		        				break;
    		        			case "VARCHAR2": %> 
    		        				<td><%= rs.getString(i) %></td>
    		        			<%
    		        				break;
    		        			case "DATE":%> 
		        				<td><%= rs.getDate(i).toString() %></td>
		        			<%
		        				break;
    		        			case "CHAR":%> 
		        				<td><%= rs.getString(i) %></td>
		        				<%
		        				break;
    		        			}
    		        			}
							}

						}
						} catch (Exception ex) {
					        ex.printStackTrace();
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
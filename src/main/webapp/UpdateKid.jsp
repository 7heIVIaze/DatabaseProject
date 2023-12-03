<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import = "java.net.HttpURLConnection, java.net.URL, java.net.URLEncoder"%>
<%@ page import = "java.io.BufferedReader, java.io.IOException, java.io.*"%>
<%@ page import = "javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, javax.xml.parsers.ParserConfigurationException"%>
<%@ page import = "org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.Node, org.w3c.dom.NodeList, org.xml.sax.SAXException, org.xml.sax.*"%>
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
<link rel="stylesheet" href="./css/custom.css">
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"crossorigin="anonymous">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/7f5811a0ff.js"
crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="css/MyPageStyles.css">
<!-- Modal -->
<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" /> 
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

<title>마이페이지</title>
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
  			String email = null;
	        String address = null;
	        String phone = null;
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
  			
  			 try {
  		        Class.forName("oracle.jdbc.driver.OracleDriver");
  		        conn = DriverManager.getConnection(url, user, pass);
  		        
  		        stmt = conn.createStatement();
  		        String sql = "select phone_number, address, email from client where id = " + id;
  		        
  		        ResultSet rs = stmt.executeQuery(sql);
  		        
  		        
  		        
  		        while(rs.next()) {
  		        	phone = rs.getString(1);
  		        	address = rs.getString(2);
  		        	email = rs.getString(3);
  		        }
  		        rs.close();
  		        stmt.close();
  				conn.close();
  			 } catch (Exception ex) {
  		        ex.printStackTrace();
  		        out.println("에러 발생: " + ex.getMessage());
  		    } 
  	%>
  	<div class="container-fluid">
  	  <div class="row justify-content-start">
			  <jsp:include page="module/MypageSidebar.jsp" flush="false" />
		  	  <div class="col-md-9" style="white-space:nowrap;height:600px;padding-top: 50px">
			  	  <section class="container" style="max-width: 560px; padding-top: 20px; height: 70%;">
				    <div class="row align-items-center justify-content-between">
				            <a class="navbar-brand h1 text-left">	
				                <span class="text-dark h3">아이정보</span> <span class="text-primary h3">관리</span>
				            </a>
						    <td><button type="button" class="btn btn-primary btn-sm" onclick="location.href='InsertKid.jsp'">아이정보추가</button></td>
				    </div>
					<div class="container-fluid">
		  	  <div class="col-md-9" style="white-space:nowrap;overflow:scroll;height:500px;">
		  	  	<table class="table table-hover" style="width:100%;">
		      		<thead>
		    			<tr>
					      <th scope="col">번호</th>
					      <th scope="col">이름</th>
					      <th scope="col">주민번호</th>
					      <th scope="col">성별</th>
					      <th scope="col">나이</th>
					    </tr>
					</thead>
					<tbody>
						<%
						try {
							Class.forName("oracle.jdbc.driver.OracleDriver");
					        conn = DriverManager.getConnection(url, user, pass);
					        conn.setAutoCommit(false);
					        stmt = conn.createStatement();
					        
					        String sql = "select rrn, name, sex, age from kid where cid = " + id;
							
					        stmt = conn.createStatement();
					        int i = 1;
					        ResultSet rs = stmt.executeQuery(sql);
					        
					        while(rs.next()) {
					        	String rrn = rs.getString(1);
					        	String name = rs.getString(2);
					        	String sex = rs.getString(3);
					        	String age = rs.getString(4);
							%>
							    <tr>
							      <th scope="row"><%= i++ %></th>
							      <td><%= name %></td>
							      <td><%= rrn %></td>
							      <td><%= sex %></td>
							      <td><%= age %></td>
							      <td style="text-overflow: ellipsis; overflow: hidden; max-width: 150px; white-space: nowrap;"></td>
							      <td><button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="transParam('<%=rrn%>', '<%=name%>', '<%=sex%>', '<%=age%>')">수정</button></td>
							    </tr>
							<%
								}
						} catch (Exception ex) {
					        ex.printStackTrace();
						}
						%>
		  			</tbody>
		  		</table>
  		</div>
  	</div>
				  </section>
		  	  </div>
  		</div>
  	</div>
    
    <jsp:include page="module/footer.jsp" flush="false"/>	
</body>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
      	<input type="hidden" id="kidName" name="kidName" value="아이이름">
        <h5 class="modal-title" id="kidName">아이이름</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="modKid.jsp" method="get">
      <input type=hidden id = "IdHospital" name = "IdHospital" value ="id 가져오기 실패" >	
	  <input type=hidden id = "Idpatient" name = "Idpatient" value = "<%= id %>" >
      <div class="modal-body">
     	  <div class="container">
       	<div class="col-md-4_1" style="width: 100%;float:center;">
		<div>
			<table class="table table-striped">	
				<colgroup> 
					<col width="200"> 
					<col> 
				</colgroup> 
				<thead>
					<tr>
						<th scope="col"></th>
						<th scope="col"></th>
					</tr>
				</thead>
				<tbody style="border: solid 1px #f0f0f0;border-radius: 5px;">
					<tr>
						<td class="booking_table_list">주민번호 <span></span></td>
						<td>
							<input type="text" class="form-control" id="rrn" name="rrn" placeholder='주민번호'>
						</td>
					</tr>
					<tr>
						<td class="booking_table_list">이름 <span></span></td>
						<td>
							<input type="text" class="form-control" id="name" name="name" placeholder='주민번호'>
						</td>
					</tr>
					<tr>
						<td class="booking_table_list">성별 <span></span></td>
						<td>
							<input type="text" class="form-control" id="sex" name="sex" placeholder='주민번호'>
						</td>
					</tr>
					
					<tr>
						<td class="booking_table_list">나이<span></span></td>
						<td>
							<input type="text" class="form-control" id="age" name="age" placeholder='주민번호'>
						</td>
					</tr>
				</tbody>
			</table>
			<input type=hidden name="patientId" value="<%= id %>">
		</div>
	</div> 
    </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary">변경하기</button>
      </div>
    </div>
    </form>
  </div>
</div>
<script>
function transParam(kRrn, kName, kSex, kAge){ // 병원정보를 모달창으로 넘겨주는 함수
	$("#kidName").val(kName);
	$("#rrn").text(kRrn);
	$("#name").text(kName);
	$("#sex").text(sex);
	$('#age').text(age);
    }
}
	</script>
    <script src="js/main.js"></script>   
</html>
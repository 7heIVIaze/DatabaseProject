<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page language = "java" import="java.util.*, java.text.*, java.sql.*, java.time.*"%>
<%@ page import = "java.net.HttpURLConnection, java.net.URL, java.net.URLEncoder"%>
<%@ page import = "java.io.BufferedReader, java.io.IOException, java.io.*"%>
<%@ page import = "java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page import = "javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, javax.xml.parsers.ParserConfigurationException"%>
<%@ page import = "org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.Node, org.w3c.dom.NodeList, org.xml.sax.SAXException, org.xml.sax.*"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>닥터베이비</title>
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
<!-- 카카오 지도 -->
<!-- services 라이브러리 불러오기 --> 
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=350bb2d30c151e9728ef1bc9066bab9a&libraries=services"></script>


<!-- Modal -->
<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" /> 
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

</head>
<body>
<% 
			String serverIP = "localhost";
			String strSID = "orcl";
			String portNum = "1521";
			String user = (String)session.getAttribute("DBID");
			String pass = (String)session.getAttribute("DBPW");
			String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
  			
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs;
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, pass);
			stmt = conn.createStatement();
			
			
			String memLogin = null; // 로그인 여부에 따라 탑메뉴 보여주는 로직
  			memLogin = (String)session.getAttribute("userType");
  			int id = -1;
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
  			
  			if(memLogin == null) //로그인을 하지 않으면 병원검색을 하지 못함
  	        {
  				PrintWriter pw = response.getWriter();
  				pw.println("<script>");
  				pw.println("alert('로그인을 해주세요.')");
  				pw.println("location.href='ClientLogin.jsp;'");
  				pw.println("</script>");
  				pw.close();
  				return;
  	        }
  			else {
  				id = (Integer)session.getAttribute("userId");
  			}
  			String hosName = request.getParameter("hosName"); //병원 명
  			int hosId = Integer.parseInt(request.getParameter("hosId")); //병원 Id
  			LocalDate now = LocalDate.now();
 %>
	<div class="container">
 		<div>
			<h5 class="modal-title" id="HosName"><%=hosName %></h5>
		</div>
	</div>

	<div class="container py-3">
		<div class="row">
			<div class="col-md-6"
				style="white-space: nowrap; overflow: scroll; height: 500px;">
				<table class="table table-hover" style="width: 100%;">
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">날짜</th>
							<th scope="col">점수</th>
							<th scope="col">리뷰</th>
						</tr>
					</thead>
					<tbody
						style="text-overflow: ellipsis; overflow: hidden; width: 150px; white-space: nowrap;">
						<%
						int i = 1; // 테이블의 번호를 세주는 변수
						request.setCharacterEncoding("UTF-8");
						
						
						
						try {
							String sql = "select rdate, rate, review from rating where hid = " + hosId;
			       			
							rs = stmt.executeQuery(sql);
							
							while(rs.next()){ 
							String rDate = rs.getDate(1).toString();
							int rRate = rs.getInt(2);
							String rReview = rs.getString(3);
							%>
							<tr>
								<th scope="row"><%= i %></th>
								<td><%= rDate %></td>
								<td><%= rRate %></td>
								<td><%= rReview %></td>
								<td style="text-overflow: ellipsis; overflow: hidden; max-width: 150px; white-space: nowrap;"></td>
							</tr>
								<% i++; %>
							<% }
						} catch(Exception e){
							e.printStackTrace();
						}%>	
					</tbody>
				</table>
			</div>
			<div class="col-md-6">
				<div id="Review" style="width: 100%; height: 500px;">
				<form action="WriteReview.jsp" method="post">
	      			<input type=hidden id = "IdHospital" name = "hId" value ="<%= hosId %>" >	
		  			<input type=hidden id = "Idpatient" name = "Idpatient" value = "<%= id %>" >
      				<div class="modal-body">
     	  				<div class="container">
        					<h5>리뷰날짜</h5>
	        				<div class="input-group date"> 
	       						<input readonly class="form-control" id="rdate" name="rdate" value = "<%= now %>">
	        				</div>
	        				
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
												<td class="rating_table_list">별점<span>*</span></td>
												<td>
													<select name="rating" id = "rating" class="treatment_sel_box" style="width: 90%;">
														<option value="1">1</option>
														<option value="2">2</option>
														<option value="3">3</option>
														<option value="4">4</option>
														<option value="5">5</option>	
													</select>
												</td>
											</tr>
											
											<tr>
												<td class="rating_table_list">리뷰<span>*</span></td>
												<td>
													<textarea type="text" name="review" id = "review" class="treatment_txt_box" style="width: 90%; height: 125px;   resize: none;  outline: 0;" placeholder ="리뷰 작성"></textarea>
												</td>
											</tr>
										</tbody>
									</table>
									<input type=hidden name="patientId" value="<%= id %>">
									<input type="hidden" id="namehospital" name="namehospital" value="<%= hosName%>">
									<input type=hidden name="rdAction" value="insert">
								</div>
							</div> 
	  					 </div>
	  					 <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					        <button type="submit" class="btn btn-primary">예약하기</button>
    					</div>
    				</div>
   				 </form>
    			</div>
			</div>
		</div>
	</div>
	</div>
</body>
<jsp:include page="module/footer.jsp" flush="false"/>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="jsp.member.model.*, java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Enumeration"%>
<%request.setCharacterEncoding("UTF-8");%>
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
				                <span class="text-dark h3">아이정보</span> <span class="text-primary h3">추가</span>
				            </a>
				    </div>
				    
					<form style="padding-top: 20px; font-size: 17px;" action = "InsertInfo.jsp" method = "post">
					
					  <div class="form-group row">
					    <label for="staticId" class="col-sm-2 col-form-label">주민번호</label>
					    <div class="col-sm-10">
					      <input type="text" class="form-control" id="rrn" name="rrn" placeholder='주민번호'>
					    </div>
					  </div>
					  <div class="form-group row" style="padding-top: 5px;">
					    <label for="staticBirthdate" class="col-sm-2 col-form-label">이름</label>
					    <div class="col-sm-10">
					      <input type="text" class="form-control" id="name" name="name" placeholder='이름'>
					    </div>
					  </div>
					  <div class="form-group row" style="padding-top: 5px;">
					    <label for="staticAddress" class="col-sm-2 col-form-label">성별</label>
					    <div class="col-sm-10">
					      <input type="text" class="form-control" id="sex" name="sex" placeholder='성별(M/F로 입력해주세요)'>
					    </div>
					  </div>
					  <div class="form-group row" style="padding-top: 5px; padding-bottom: 30px;">
					    <label for="inputPassword" class="col-sm-2 col-form-label">나이</label>
					    <div class="col-sm-10" id="passwordCheck">
					      <input type="password" class="form-control" id="age" placeholder="나이" name="age">
					    </div>
					  </div>
					  <button class="w-100 btn btn-lg btn-primary" type="submit">추가</button>
				      <input type=hidden name="action" value="insert">
					</form>
				  </section>
		  	  </div>
  		</div>
  	</div>
    
    <jsp:include page="module/footer.jsp" flush="false"/>	
    
    <!-- JS -->
    <script type="text/javascript">
	$(document).ready(function(){
	    $('#passwordCheck i').on('click',function(){
	        $('#inputPassword').toggleClass('active');
	        if($('#inputPassword').hasClass('active')){
	            $(this).attr('class',"fa fa-eye-slash fa-lg")
	            .prev('#inputPassword').attr('type',"text");
	        }else{
	            $(this).attr('class',"fa fa-eye fa-lg")
	            .prev('#inputPassword').attr('type','password');
	        }
	    });
	});
	</script>
    <script src="js/main.js"></script>
</body>

</script>
</html>
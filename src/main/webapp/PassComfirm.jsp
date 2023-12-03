<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, jsp.member.model.*"%>
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
<title>마이페이지</title>
</head>
<body>
	<% 
  			String memLogin = null; // 로그인 여부에 따라 탑메뉴 보여주는 로직
  			memLogin = (String)session.getAttribute("userType");
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
			  <jsp:include page="module/MypageSidebar.jsp" flush="false" />
		  	  <div class="col-md-9" style="white-space:nowrap;height:500px;padding-top: 100px">
			  	  <section class="container" style="max-width: 560px; padding-top: 20px; height: 500px;">
				    <div class="row align-items-center justify-content-between">
				            <a class="navbar-brand h1 text-left">	
				                <span class="text-dark h3">비밀번호</span> <span class="text-primary h3">확인</span>
				            </a>
				    </div>
					<form method="post" action="ComfirmUser.jsp" style="padding-top: 30px;">
				    	<div class="form-floating" style="padding-bottom: 30px;">
				      		<input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="password" value="">
				      		<label for="floatingPassword">비밀번호</label>
				    	</div>
				    	
				    	<button class="w-100 btn btn-lg btn-primary" type="submit">확인</button>
				    	<input type=hidden name="action" value="confirm">
					</form>
				  </section>
		  	  </div>
  		</div>
  	</div>
    
    <jsp:include page="module/footer.jsp" flush="false"/>	
    
    <!-- JS -->
    <script src="js/main.js"></script>
</body>
</html>
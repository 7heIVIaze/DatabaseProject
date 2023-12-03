<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터베이비</title>
<style>
.IntroductionPage{
display:block; margin: 0px auto;
text-align: center;
}
.IntroductionPage2{
text-align: center;
display:block; margin: 0px auto;
}
</style>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<link rel="stylesheet" href="./css/custom.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/7f5811a0ff.js" crossorigin="anonymous"></script>

</head>
<body>
<% 
  			String memLogin = null; // 로그인 여부에 따라 탑메뉴 보여주는 로직
  			memLogin = (String)session.getAttribute("userType");
  			if(memLogin == null){ // 로그인 안했을때 헤더
  				%>
				 <jsp:include page="module/header.jsp" flush="false" />
				 <%
  			}
  			else if(memLogin == "client"){ // 환자회원 헤더
  				%>
  				 <jsp:include page="module/clientHeader.jsp" flush="false" />
  				<%
  			}
  			else if(memLogin == "admin"){ // 병원회원 헤더
  				%>
 				 <jsp:include page="module/adminHeader.jsp" flush="false" />
 				<%
  			} 		
 %>
<div class="center_right">
</div>
<div class="jumbotron">
    <img src="img/Introduction1.png" class="IntroductionPage" style="width: 100%; max-width: auto"><br><br>
</div>
<div class="container" style="max-width: 1740px;">
<img src="img/Introduction2.png" class="IntroductionPage" style="width: 100%"><br><br>
<img src="img/Introduction3.png" class="IntroductionPage" style="width: 100%">
<img src="img/Introduction4.png" class="IntroductionPage" style="width: 100%">
<a href="Home.jsp"><img src="img/Introduction5.png" class="IntroductionPage2"></a><br><br>
</div>
</body>
<jsp:include page="module/footer.jsp" flush="false"/>	
</html>
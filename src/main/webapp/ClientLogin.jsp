<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터베이비</title>
<!-- 스크립트 부분 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<link rel="stylesheet" href="./css/custom.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/7f5811a0ff.js" crossorigin="anonymous"></script>
</head>
<body>
<%
	String user = (String)session.getAttribute("DBID");
	String pass = (String)session.getAttribute("DBPW");
%>
<jsp:include page="module/header.jsp" flush="false"/>
<section class="container" style="max-width: 560px; padding-top: 20px; height: 500px;">
	<div class="row" style="padding-bottom: 20px;">
            <a class="navbar-brand text-left col-md-3 patientSignUp" href="ClientLogin.jsp">	
                <span class="text-dark h4" style="font-size:15px;">개인 로그인</span>
            </a>
            <a class="navbar-brand text-left col-md-3 hospitalSignUp" href="AdminLogin.jsp">	
                <span class="text-dark h4" style="font-size:15px;">관리자 로그인</span>
            </a>
    </div>
    <div class="row align-items-center justify-content-between">
            <a class="navbar-brand h1 text-left">	
                <span class="text-dark h3">개인</span> <span class="text-primary h3">로그인</span>
            </a>
    </div>
	<form method="post" action="Login.jsp" style="padding-top: 30px;">
		<div class="form-floating" style="padding-bottom: 10px;">
      		<input type="id" class="form-control" id="floatingInput" placeholder="id" name="email">
      		<label for="floatingInput">이메일</label>
    	</div>
    	<div class="form-floating" style="padding-bottom: 10px;">
      		<input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="password">
      		<label for="floatingPassword">비밀번호</label>
    	</div>
    	<button class="w-100 btn btn-lg btn-primary" type="submit">로그인</button>
    	<input type=hidden name="type" value="client">
	</form>
</section>
    
</body>
<jsp:include page="module/footer.jsp" flush="false"/>	
</html>
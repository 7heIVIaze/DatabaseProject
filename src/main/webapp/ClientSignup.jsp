<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<style type = "text/css">
body{
	background-color: #f7fff8;
}
</style>
<meta charset="EUC-KR">
<title>회원가입</title>
<title>개인 회원가입</title>
<!-- 스크립트 부분 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<link rel="stylesheet" href="./css/custom.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/7f5811a0ff.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="css/PatientSignUp.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" /> 
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
  <jsp:include page="module/header.jsp" flush="false"/>
</head>
<body>
<div align="center">
	<h1>회 원 가 입</h1>
	<form action = "CheckRegister.jsp" method = "post">
		<table border = "1" style="width:600px; height=150px; background-color:#95f3c7;">
			<tr>
				<td>이메일</td>
				
				<td><input type = "text" name = "email"/>
			
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type = "password" name = "password"/></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type = "password" name = "password2"/></td>
			</tr>
			
			<tr>
				<td>주소</td>
				<td><input type = "text" name = "address"/></td>
			</tr>
			<tr>
				<td> 전화번호(dash 포함) </td>
				<td><input type = "text" name = "phone"/></td>
			</tr>
			
		</table>
		<input type = "hidden" name = "regType" value = "client">
		<button type = "submit" class="snip1535"> submit </button>
		<button type = "button" class="snip1535" onClick="location.href='homepage.jsp'"> 뒤로가기 </button>
		
	</form>
</div>
</body>
</html>
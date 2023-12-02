<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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

</head>
<body>
<!--
	<div id="header">
		<a href="homepage.html" class="logo">DataBase Term Project</a>
		<div class="logo-right">COMP322</div>
		-->
	</div>
	<div id="body">
	<!--
		<ul class="actions">
				<li><a href="Search_Query1.jsp" class="button alt"><b>Search</b></a></li>
		</ul>
		-->
		<div class="login-form">
		<% 
			session.setAttribute("DBID", "university");
			session.setAttribute("DBPW", "comp322");
	//		if(session.getAttribute("userType") == null) {
		%>
		<!--
			<form action="ClientLogin.jsp" method="post">
				<input type="text" value="" name="email" class="text-field" placeholder="E-mail">
				<input type="password" value="" name="password" class="text-field" placeholder="PW">
				<input type="submit" value="Log In" class="btn">
				<button type="button" class="btn" value="signup" onClick="location.href='Register.jsp'">Sign Up</button>
			</form>
		-->
		<% 
	//		} else if(session.getAttribute("userType").equals("client")) {
		%>
		
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
	<div class="container">
 		<div>
			<form class="row" action="PageControl.jsp" method="post" id="searchBar">
				<div class="btn-group py-3 col-md-3" role="group"
				aria-label="Basic outlined example">
					<input type="radio" class="btn-check" name="search" value="hosname" id="btnradio1" autocomplete="off" checked>
  					<label class="btn btn-outline-primary" for="btnradio1">병원명</label>
  					<input type="radio" class="btn-check" name="search" value="department" id="btnradio2" autocomplete="off">
  					<label class="btn btn-outline-primary" for="btnradio2">진료과</label>
				</div>
				<div class="search col-md-6 py-3">
					<div class="Mainsearch">
						<input type="text" placeholder="병원명, 진료과 별로 검색해보세요 :)"
							class="Mainsearch searchBar" name="keyword">
						<button class="Mainsearch icon" onclick="clickBtn()">
							<i class="fa fa-search"></i>
						</button>
						<input type="hidden" name="lat" value="s">
						<input type="hidden" name="lng" value="s">
						<input type="hidden" name="hoslAction" value="search">
					</div>
				</div>
			</form>
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
							<th scope="col">병원명</th>
							<th scope="col">전화번호</th>
							<th scope="col">진료과</th>
							<th scope="col">진료여부</th>
							<th scope="col">예약</th>
						</tr>
					</thead>
					<tbody
						style="text-overflow: ellipsis; overflow: hidden; width: 150px; white-space: nowrap;">

					</tbody>
				</table>
			</div>
			<div class="col-md-6">
				<div id="map" style="width: 100%; height: 500px;"></div>
				<script>
					var mapOptions = {
						center : new naver.maps.LatLng(37.3595704, 127.105399),
						zoom : 10
					};

					var map = new naver.maps.Map('map', mapOptions);
				</script>
			</div>
		</div>
	</div>
	<jsp:include page="module/footer.jsp" flush="false"/>	
</body>
</html>
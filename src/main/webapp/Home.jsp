<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language = "java" import = "java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���ͺ��̺�</title>
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
<!-- īī�� ���� -->
<script type="text/javascript" 
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=350bb2d30c151e9728ef1bc9066bab9a"></script>

<script>
function clickBtn(){
	navigator.geolocation.getCurrentPosition(
			function(position) {
			console.log("���� : " + position.coords.latitude);
			console.log("�浵 : " + position.coords.longitude);
			
			 var lat= position.coords.latitude;
             var lng= position.coords.longitude;
             
             var latInput = document.forms['searchBar']['lat'];
             var lngInput = document.forms['searchBar']['lng'];
             
             latInput.setAttribute('value',lat);
             lngInput.setAttribute('value',lng);
             
             document.getElementById('searchBar').submit();
			},
    );
}
</script>
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
  			String memLogin = null; // �α��� ���ο� ���� ž�޴� �����ִ� ����
  			memLogin = (String)session.getAttribute("userType");
  			if(memLogin == null){ // �α��� �������� ���
  				%>
				 <jsp:include page="module/header.jsp" flush="false" />
			<%
  				//}
			}
  			else if(memLogin.equals("client")){ // ȯ��ȸ�� ���
  				%>
  				 <jsp:include page="module/clientHeader.jsp" flush="false" />
  				<%
  			}
  			else if(memLogin.equals("admin")){ // ����ȸ�� ���
  				%>
 				 <jsp:include page="module/adminHeader.jsp" flush="false" />
 				<%
  			} 
  			%>
	<div class="container">
 		<div>
			<form class="row" action="Search.jsp" method="post" id="searchBar">
				<div class="btn-group py-3 col-md-3" role="group"
				aria-label="Basic outlined example">
					<input type="radio" class="btn-check" name="search" value="locname" id="btnradio1" autocomplete="off" checked>
  					<label class="btn btn-outline-primary" for="btnradio1">������</label>
  					<input type="radio" class="btn-check" name="search" value="hosname" id="btnradio2" autocomplete="off">
  					<label class="btn btn-outline-primary" for="btnradio2">������</label>
				</div>
				<div class="search col-md-6 py-3">
					<div class="Mainsearch">
						<input type="text" placeholder="������, ������ ���� �˻��غ����� :)"
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
							<th scope="col">��ȣ</th>
							<th scope="col">������</th>
							<th scope="col">��ȭ��ȣ</th>
							<th scope="col">�����ǻ�</th>
							<th scope="col">���Ῡ��</th>
							<th scope="col">����</th>
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
					var container = document.getElementById('map');
					var mapOptions = { //������ ������ �� �ʿ��� �⺻ �ɼ�
							center: new kakao.maps.LatLng(33.450701, 126.570667), //������ �߽���ǥ.
							level: 5 //������ ����(Ȯ��, ��� ����)
						};

					var map = new kakao.maps.Map(container, mapOptions);
					//var map = new kakao.maps.Map('map', mapOptions);
				</script>
			</div>
		</div>
	</div>
	<jsp:include page="module/footer.jsp" flush="false"/>	
</body>
</html>
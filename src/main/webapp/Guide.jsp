<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터베이비</title>
<style>
.GuideText{
display:block; margin: 0px auto;
text-align: center;
}
.GuidePage{
text-align: center;
display:block; margin: 0px auto;
}
.GT{
display:block;
margin: 0px auto;
text-align: center;
font-weight:bold;
font-size:30px;
}
table {
    margin-left:20%; 
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
<div><br>
<font class="GT">닥터베이비 이용안내</font><br><br>
<img src="img/Guide1-1.png" class="GuidePage"><br>
<font size="3" class="GuideText">1. 원하는 병원명과 진료과 별로 검색을 해보세요.</font><br>
<font size="3" class="GuideText">↓</font><br>
<img src="img/Guide2.png" class="GuidePage"><br>
<font size="3" class="GuideText">2. 찾으시는 병원의 진료 여부를 확인한 후 예약 버튼을 누르세요.</font><br>
<font size="3" class="GuideText">↓</font><br>
<table>
<tr>
<td>
<img src="img/Guide3.png"><br>
</td>
<td>
<img src="img/Guide4.png">
</td>
</tr>
</table>
<font size="3" class="GuideText">3. 예약을 원하시는 날짜를 선택하고 필수 *를 올바르게 선택, 입력 후 예약하기 버튼을 눌러주세요.</font><br>

</div>
</body>
<jsp:include page="module/footer.jsp" flush="false"/>	
</html>
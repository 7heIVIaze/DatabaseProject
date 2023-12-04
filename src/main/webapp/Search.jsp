<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page language = "java" import="java.util.*, java.text.*, java.sql.*"%>
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
 <script>
 $(function() { $( "#datepicker" ).datepicker(); });
 </script>
<script>
$(document).ready(function(){ 
	$.datepicker.setDefaults({ 
		closeText: "닫기", 
		currentText: "오늘", 
		prevText: '이전 달', 
		nextText: '다음 달', 
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		dayNames: ['일', '월', '화', '수', '목', '금', '토'], 
		dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
		weekHeader: "주", 
		yearSuffix: '년',
		minDate:"0",
		maxDate:"+1M"
	}); 
}); 
</script>		
<!-- css -->
<style>
      #datepicker{
        width:800px;
        height:30px;
      }
</style>
<script>
function clickBtn(){
	navigator.geolocation.getCurrentPosition(
			function(position) {
			console.log("위도 : " + position.coords.latitude);
			console.log("경도 : " + position.coords.longitude);
			
			 var lat= position.coords.latitude;
             var lng= position.coords.longitude;
             
             var latInput = document.forms['searchBar']['lat'];
             var lngInput = document.forms['searchBar']['lng'];
             console.log(latInput.value);
             console.log(lngInput.value);
             
             
             latInput.setAttribute('value',lat);
             lngInput.setAttribute('value',lng);
             
             console.log(latInput.value);
             console.log(lngInput.value);
             
             document.getElementById('searchBar').submit();
			},
    );
}
</script>
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
			PreparedStatement pstmt = null;
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
 %>
	<div class="container">
 		<div>
			<form class="row" action="Search.jsp" method="post" id="searchBar">
				<div class="btn-group py-3 col-md-3" role="group"
				aria-label="Basic outlined example">
					<input type="radio" class="btn-check" name="search" value="locname" id="btnradio1" autocomplete="off" checked>
  					<label class="btn btn-outline-primary" for="btnradio1">지역명</label>
  					<input type="radio" class="btn-check" name="search" value="hosname" id="btnradio2" autocomplete="off">
  					<label class="btn btn-outline-primary" for="btnradio2">병원명</label>
				</div>
				<div class="search col-md-6 py-3">
					<div class="Mainsearch">
						<input type="text" placeholder="지역명, 병원명 별로 검색해보세요 :)"
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
							<th scope="col">진료의사</th>
							<th scope="col">주소</th>
							<th scope="col">예약여부</th>
							<th scope="col">예약</th>
							<th scope="col">리뷰</th>
						</tr>
					</thead>
					<tbody
						style="text-overflow: ellipsis; overflow: hidden; width: 150px; white-space: nowrap;">
						<%
						int i = 1; // 테이블의 번호를 세주는 변수
						request.setCharacterEncoding("UTF-8");
						String search = request.getParameter("search"); //검색 분류(지역명, 병원명)
						String keyword = request.getParameter("keyword");// 검색어
						
						String address = null;
						try {
							if(search.equals("hosname")) {
							 	String sql = "select h.id, h.name, h.phone_number, h.address, d.name from Hospital h join Doctor d on h.id = d.hid where name like ?";
							 	pstmt = conn.prepareStatement(sql);
			        			pstmt.setString(1,'%'+keyword+'%');
							}
							else if(search.equals("locname"))
							{
								String sql = "select h.id, h.name, h.phone_number, h.address, d.name from Hospital h join Doctor d on h.id = d.hid where Address like ?";
							 	pstmt = conn.prepareStatement(sql);
			        			pstmt.setString(1,'%'+keyword+'%');
							}
			       			rs = pstmt.executeQuery();
							
							while(rs.next()){ 
							int hId = rs.getInt(1);
							String hosName = rs.getString(2);
							String phone = rs.getString(3);
							address = rs.getString(4);
							String docName = rs.getString(5);
							%>
							
							<tr onclick="hospitalPos('<%=hosName%>','<%=address%>'')">
								<th scope="row"><%= i %></th>
								<td><%= hosName %></td>
								<td><%= phone %></td>
								<td><%= docName %></td>
								<td><%= address %></td>
								<td style="text-overflow: ellipsis; overflow: hidden; max-width: 150px; white-space: nowrap;"></td>
								<%
								String query = "select count(Id) from reservation where hid = " + hId;
								
								ResultSet rs2 = stmt.executeQuery(query);
								int cnt = 0;
								while(rs2.next()) {
									cnt = rs2.getInt(1);
									break;
								}
								
								if(cnt < 10) {
								%>
								<td><span class= "badge bg-success">가능</span></td> <% }  
								else {%><td><span class= "badge bg-danger">불가능</span></td>
								<%} %>
								<td><button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="transParam('<%=hosName%>','<%=docName%>', '<%= rs.getInt(1) %>')">예약</button></td>
								<form method="post" action="Review.jsp" >
									<input type="hidden" type = "number" name="hosId" value=<%=hId%>>
									<input type="hidden" name="hosName" value="<%=hosName%>">
									<td><button type="submit" class="btn btn-primary btn-sm">리뷰보기</button></td>
								</form>
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
				<div id="map" style="width: 100%; height: 500px;"></div>
				<script>
				var container = document.getElementById('map');
				function nowPos(){
		            // BOM의 navigator객체의 하위에 geolocation객체가 새로 추가되었음.
		            var geocoder = new kakao.maps.services.Geocoder();
		            
		            geocoder.addressSearch('대구광역시 북구 대학로80', function(result, status) {

		                // 정상적으로 검색이 완료됐으면 
		                 if (status === kakao.maps.services.Status.OK) {
							
		                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
							
		                    var mapOptions = { //지도를 생성할 때 필요한 기본 옵션
									center: coords, //지도의 중심좌표.
									level: 5 //지도의 레벨(확대, 축소 정도)
								};
		                    // 결과값으로 받은 위치를 마커로 표시합니다
		                    var marker = new kakao.maps.Marker({
		                        map: map,
		                        position: coords
		                    });
		                    
		                    var map = new kakao.maps.Map(container, mapOptions);
		                } 
		            });
		        };
		        
		        nowPos();
				function hospitalPos(hosName, addr) {
					var contentString = [
					        '<div class="iw_inner" style="padding: 1em;">',
					        '   <h3 style="font-weight:bold;">'+ hosName + '</h3><hr>',
					        '   <p>'+addr+'<hr>',
					        '       ',
					        '   </p>',
					        '</div>'
					    ].join('');
					 var geocoder = new kakao.maps.services.Geocoder();
		
					 geocoder.addressSearch(addr, function(result, status) {
						 // 정상적으로 검색이 완료됐으면 
						 if (status === kakao.maps.services.Status.OK) {
							 var hospital = new kakao.maps.LatLng(result[0].y, result[0].x),
	                       	 map = new kakao.maps.Map('map', {
	                       		 center: hospital,
	                       		 scaleControl: false,
	                       		 logoControl: false,
	                       		 mapDataControl: false,
	                       		 zoomControl: true,
	                       		 minZoom: 6
	                       	 }),
	                       	 marker = new kakao.maps.Marker({
	                       		 map: map,
	                       		 position: coords
	                       	 });

							 var infowindow = new kakao.maps.InfoWindow({
								 content: contentString,
								 maxWidth: 300,
								 backgroundColor: "#FFFFFF",
								 borderColor: "#D3D3D3",
								 borderWidth: 2,
								 anchorSize: new naver.maps.Size(30, 30),
								 anchorSkew: true,
								 anchorColor: "#eee",
								 pixelOffset: new naver.maps.Point(20, -20)
			                  });
							 kakao.maps.Event.addListener(marker, "click", function(e) {
								 if (infowindow.getMap()) {
									 infowindow.close();
								 } else {
									 infowindow.open(map, marker);
								 }
							 });    
							 map.setCenter(coords);
						 }
					 })
				};
					 
				
				</script>
			</div>
		</div>
	</div>
</body>
<jsp:include page="module/footer.jsp" flush="false"/>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
      	<input type="hidden" id="hospitalName" name="hName" value="병원이름">
        <h5 class="modal-title" id="exampleModalLabel">병원이름</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="Reservation.jsp" method="post">
      <input type=hidden id = "IdHospital" name = "IdHospital" value ="id 가져오기 실패" >	
	  <input type=hidden id = "Idpatient" name = "Idpatient" value = "<%= id %>" >
      <div class="modal-body">
     	  <div class="container">
        <h5>예약날짜</h5>
        <div class="input-group date">
           <input type="text" id="datepicker" name= "reserveDate"> 
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
					<td class="booking_table_list">진료의사<span>*</span>
						<select name="docName" id="department" class="treatment_sel_box" style="width: 90%">
							<option value="">진료과목 선택</option>
							<option value="002">ex)치과</option>
																															
						</select>
					</td>
					<td class="booking_table_list">예약구분<span>*</span>
						<select name="reserveDiv" id="reserveDiv" class="treatment_sel_box" style="width: 90%;">
							<option value="">예약 선택</option>
								<option value="진료">진료</option>
								<option value="검진">검진</option>	
						</select>
					</td>
					</tr>
					<tr>
						<td class="booking_table_list">진료 받으실 분 <span>*</span></td>
						<td>
							<select name="department1" id = "department1" class="treatment_sel_box" style="width: 90%;">
							<%
							
							String sql = "select rrn, name from kid join client on cid = id where id = ?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, id);
							rs = pstmt.executeQuery();
							while(rs.next()){
							%>
								<option value='<%= rs.getString(1)%>'><%= rs.getString(2)%></option>
							<%} %>
																	
							</select>
						</td>
					</tr>
					
					<tr>
						<td class="booking_table_list">증상<span>*</span></td>
						<td>
							<textarea type="text" name="symptom" id = "symptom" class="treatment_txt_box" style="width: 90%; height: 125px;   resize: none;  outline: 0;" placeholder ="증상 하나마다 ,로 구분해주세요."></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<input type=hidden name="patientId" value="<%= id %>">
			<input type="hidden" id="namehospital" name="namehospital" value="병원이름">
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
<script>
function transParam(dutyName, dgidIdName, hpid){ // 병원정보를 모달창으로 넘겨주는 함수
	var arr = dgidIdName.split(',');
	$("#IdHospital").val(hpid);
	$("#hospitalName").val(dutyName);
	$("#namehospital").val(dutyName);
	$("#exampleModalLabel").text(dutyName);
	$('#department').empty();
	for(var count = 0; count < arr.length; count++){                
        var option = $("<option value=" + arr[count] + ">"+arr[count]+"</option>");
        $('#department').append(option);
    }
}

</script>
</html>
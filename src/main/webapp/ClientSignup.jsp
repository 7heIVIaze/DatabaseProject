<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<!-- ��ũ��Ʈ �κ� -->
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
	<section class="bg-light" style="height: 1000px;">
		<div class="container py-4">
	        <div class="row">
	                <a class="navbar-brand h1 text-left col-md-3">	
	                    <span class="text-dark h4">����</span> <span class="text-primary h4">ȸ������</span>
	                </a>
	            </div>
			<form action = "CheckRegister.jsp" method = "post">
				<div class="form-group">
		   		    <label for="userId" class="form-label mt-4">�̸���</label>
		   		    <input type="text" class="form-control" name="email" id="email" aria-describedby="emailHelp" placeholder="�̸���(??@??.com)�� �Է����ּ���.">
				</div>
				 <div class="form-group">
		   		    <label class="form-label mt-4" for="userPass">��й�ȣ</label>
		     		<input type="password" class="form-control" id="password" name="password" placeholder="��й�ȣ�� �Է����ּ���.">
				</div>
				<div class="form-group"> 
		   		    <label class="form-label mt-4" for="userRePass">��й�ȣ ��Ȯ��</label> 
		   		    <input type="password" class="form-control" id="password2" name ="password2" placeholder="��й�ȣ�� ���Է����ּ���.">
				</div>
				<div class="form-group">
		   		    <label for="name" class="form-label mt-4">�ּ�</label>
		   		    <input type="text" class="form-control" id="address" name="address" placeholder="�ּҸ� �Է����ּ���.">	
				</div>
				<div class="form-group">
		   		    <label for="name" class="form-label mt-4">��ȭ��ȣ(-����)</label>
		   		    <input type="text" class="form-control" id="phone" name="phone" placeholder="010-1111-1111ó�� �Է����ּ���.">
				</div>
				<input type = "hidden" name = "regType" value = "client">
				<button type = "submit" class="snip1535"> submit </button>
				<button type = "button" class="snip1535" onClick="location.href='homepage.jsp'"> �ڷΰ��� </button>
			</form>
		</div>
	</section>
</body>
</html>
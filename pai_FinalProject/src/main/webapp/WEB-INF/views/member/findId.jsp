<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<title>아이디 찾기</title>
    <style>
       .findid {
	  width: 30%;
	  height: 600px;
	  background: white;
	  border-radius: 20px;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  flex-direction: column;
	}
	.btn-outline-secondary:hover{
	   background-color: #6710f242;
	   border: 1px solid #6710f242;
	}
	.btn-outline-secondary{
	   border: 1px solid #6710f242;
	   color:#6710f242;
	}
	.wrap {
	  width: 100%;
	  height: 100vh;
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  background: rgba(0, 0, 0, 0.1);
	}
	.form-floating,.checkbox{
		color:purple;
	}
    </style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
</head>
<body>
	<section class="wrap">
		<div class="findid">
			<div class="nav-lists" id="nav-img">
				<a href="${path}/"><img src="${path }/resources/images/member/logo_white.jpg" width="200px" height="200px"></a>
			</div><br>
		    <div class="headDiv2">
		        <h1>아이디 찾기</h1>
		    </div>
		    <br>
		    <div class="formDiv">
		        <h4 class="c1">회원정보에 등록된 이름과 이메일정보를</h4>
		        <h4 class="c2">활용하여 회원여부를 확인 합니다.</h4>
		        <form action="${ path }/member/findId" method="POST">
		        	<div style="width: 80%;">
			            <div class="form-floating mb-3" style="width: 100%">
						  	<input type="text" class="form-control" id="floatingInput" name="member_name" placeholder="이름">
						  	<label for="floatingInput">이름을 입력하세요</label>
						</div> 
					</div>	
		        	<div style="width: 80%;">
			            <div class="form-floating mb-3" style="width: 100%">
						  	<input type="text" class="form-control" id="floatingInput" name="member_email" placeholder="이메일">
						  	<label for="floatingInput">이메일을 입력하세요</label>
						</div> 
					</div>
					<div style="width: 80%;">
			           	<div style="width: 100%; display: inline-block;">
			           		<input type="submit" class="btn btn-outline-secondary" id="findId" value="아이디 찾기" style="width: 100%;">
			           	</div>
			        </div>	
		        </form>
		    </div>
		</div>
	</section>
</body>
</html>
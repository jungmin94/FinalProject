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
<title>Insert title here</title>
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
	<script>
		$(function(){
			alert("${ msg }");
		})
	</script>
	<div class="wrap">
		<div class="findid">
			<div class="headDiv">
		        <img src="${ path }/resources/images/member/logo_white.jpg" class="homeimg" style="width:300px; height:300px;">
		    </div>
		    <div class="headDiv2">
		        <h2>아이디 찾기</h2>
		    </div>
		    <div class="formDiv">
		        <h3 class="c1">아이디 찾기 결과 입니다.</h3>
		        <h3 class="c2">귀하의 아이디는 <strong>${ user.member_id }</strong> 입니다.</h3>
		        <h3>해당 아이디로 로그인 해주세요.</h3>
		        <div style="width: 100%;">
		           	<div style="width: 100%; display: inline-block;">
		           		<input type="submit" class="loginBtn btn btn-outline-secondary" id="loginBtn" value="로그인하러하기" style="width: 100%;">
		           	</div>
		        </div>
		    </div>
		</div>
	</div>
    
    <script>
    	$(".loginBtn").on("click", function(){
    		location.href="${ path }/member/loginMember.do";
    	});
    </script>
</body>
</html>
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
        .headDiv{
            display: inline-block;
        }
        .formDiv{
            border: 1px solid gray;
            width: 450px;
            height: 500px;
            position: absolute;
            top: 15%;
            left: 40%;
            text-align: center;
        }
        .homeimg{
            width: 200px;
            height: 100px;
            display: inline-block;
            margin-left: 400px;
        }
        h1{
            display: inline-block;
            margin-bottom: 0px;
            margin-top: 0px;
            margin-left: 20px;
            color: rgb(0, 51, 85);
            text-align: center;
        }
        .headDiv2{
            display: inline-block;
            position: relative;
            bottom: 30px;
        }
        .c1{
            color: rgb(0, 51, 85);
            margin-top: 100px;
        }
        .c2{
            margin-top: 100px;
        }
        .loginBtn{
            background-color: rgb(0, 51, 85);
            border-radius: 5px;
            color: white;
            height: 50px;
            width:  120px;
            font-weight : bolder;
            margin-top: 50px;
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
	
	<div class="headDiv">
        <a href="${ path }/home"><img src="${ path }/resources/images/relief.jpg" class="homeimg"></a>
    </div>
    <div class="headDiv2">
        <h1>아이디 찾기</h1>
    </div>
    <hr>
    <div class="formDiv">
        <h3 class="c1">아이디 찾기 결과 입니다.</h3>
        <h4 class="c2">귀하의 아이디는 ${ member.member_id } 입니다.</h4>
        <h4>해당 아이디로 로그인 해주세요.</h4>
        <button class="loginBtn">로그인하러하기</button>
    </div>
    
    <script>
    	$(".loginBtn").on("click", function(){
    		location.href="${ path }/member/loginMember";
    	});
    </script>
</body>
</html>
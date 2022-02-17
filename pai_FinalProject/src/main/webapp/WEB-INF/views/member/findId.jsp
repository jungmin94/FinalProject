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
<title>아이디 찾기</title>
    <style>
       
    </style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
</head>
<body>
	<div class="headDiv">
        <a href="${ path }/home"><img src="${ path }/resources/images/logo_white.jpg" class="homeimg"></a>
    </div>
    <div class="headDiv2">
        <h1>아이디 찾기</h1>
    </div>
    <hr>
    <div class="formDiv">
        <h3 class="c1">회원정보</h3>
        <h3 class="c2">에 등록된 이름과 이메일정보를 활용하여 회원여부를 확인 합니다.</h3>
        <form action="${ path }/member/findId" method="POST">
            <input type="text" name="member_name" class="name" placeholder="이름">
            <input type="email" name="member_email" class="email" placeholder="이메일">
            <button type="submit" class="findIdBtn">확인</button>
        </form>
    </div>
</body>
</html>
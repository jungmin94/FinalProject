<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
	div#enroll-container{width:400px; margin:0 auto; text-align:center;}
	div#enroll-container input, div#enroll-container select {margin-bottom:10px;}

    div#userId-container{position:relative;padding:0px;}
    div#userId-container span.guide{display: none;font-size:12px;position:absolute;top:12px;right:10px;}
    div#userId-container span.ok{color:green;}
    div#userId-container span.error{color:red;}
</style>
<section>

<div id="enroll-container">
			<form name="memberEnrollFrm"  action="${path}/member/enrollMemberEnd.do"  method="post">
				
				<div id="userId-container">
					<input type="text" class="form-control" placeholder="아이디 (4글자이상)" name="userId" id="userId_" required>		
					<span class="guide ok">해당 상품명은 사용이 가능합니다</span> 
					<span class="guide error">해당 상품명은 사용이 불가능합니다</span> 
				</div>
				
				<select class="form-control" name="gender" required>
					<option value="" disabled selected>카테고리1</option>
					<option value="M">남성용</option>
					<option value="F">여성용</option>
				</select>
				
				<select class="form-control" name="gender" required>
					<option value="" disabled selected>카테고리2</option>
					<option value="반팔">반팔</option>
					<option value="긴팔">긴팔</option>
				</select>
				
				
				<br />
				<input type="submit" class="btn btn-outline-success" value="가입" >&nbsp;
				<input type="reset" class="btn btn-outline-success" value="취소" onclick="location.assign('${path}/')">
			</form>
		</div>


</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
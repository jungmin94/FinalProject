<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="회원정보보기"/>
</jsp:include>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
	<form class="wrap" action="${path }/member/insertMbti.do" method="post">
        <div class="">
            <div>
	            <img src="${path }/resources/images/member/logo_white.jpg" style="width:200px; height:200px;">
            </div>
    		<div>
			  	<label>${member_nick } 님의 MBTI를 입력하세요</label>
    		</div>        
            <div style="width: 80%;">
	            <div class="form-floating mb-3">
				  	<input type="text" class="form-control" id="floatingInput" name="member_mbti" placeholder="MBTI 입력">
				  	<label for="floatingInput">MBTI입력</label>
				</div> 
			</div>	
			<div class="submit btn-outline-secondary">
            	
                <button type="submit" value="MBTI입력" class="btn btn-outline-secondary">MBTI입력</button>
            
            </div>
	        	<label>혹시 본인의 MBTI를 아직 모른다면...!!</label>
	        	<label>아래의 버튼을 눌러서 테스트를 완료해주세요!</label>
	        <div class="btn-outline-secondary">
 		        <input type="button" class="btn btn-outline-secondary" value="MBTI테스트" onclick="location.assign('${path}/member/mbtiTest.do')">
		        
	        </div>
		</div>
	</form>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
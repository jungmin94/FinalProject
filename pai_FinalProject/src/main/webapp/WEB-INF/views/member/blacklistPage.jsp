<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<c:set var="path" value="${pageContext.request.contextPath }"/> 
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>블랙리스트</title>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section>
	<div>
		<img src="${path }/resources/images/member/blacklist.jpg" style=width:400px;,height:400px;>
	</div>
	<div>
		<h1>
			회원님은 다수의 신고 건으로 인해서 현재 블랙리스트 상태입니다.
		</h1>
		<p>		
			블랙리스트에 등록된 회원일 경우 저희 PAI의 모든 서비스를 이용하실 수 없습니다.<br>
			이용 신청 혹은 신고 관련 문의는 pai2022@gmail.com으로 문의 주시기 바랍니다.
		</p>
	</div>
		
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
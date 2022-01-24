<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section>
<div class="container">
<!-- 전체 리스트 출력 -->
	<div class="row row-cols-1 row-cols-md-4 g-4">
	<!-- for문으로 복사해서 출력 -->
		<div class="col">
			<div class="card h-100" style="width: 18rem;">
				<img src="https://item.kakaocdn.net/do/5440669192e9c89cb7e42a6ba33df547960f4ab09fe6e38bae8c63030c9b37f9" class="card-img-top" alt="..." style="height: 170px;">
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.dgddfgdgdgdgdfgdfgdfggfd</p>
					<a href="#" class="btn btn-primary">Go somewhere</a>
				</div>
			</div>
	  	</div>
	  	
	</div>
<!-- 페이지바 출력할 부분 -->
</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
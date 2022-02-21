<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<ul class="nav justify-content-center">
		<li class="nav-item">
		  <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/market/myCart.do">장바구니</a>
		</li>
		<li class="nav-item">
		  <a class="nav-link" href="${pageContext.request.contextPath}/market/myOrderedView.do">나의 구매목록</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath}/market/myReviewList.do">리뷰관리</a>
		  </li>
		  <c:if test="${loginMember.member_id.equals('admin')}">
		  	<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/market/enrollManageList.do">상품관리</a>
		  	</li>
		  </c:if>
		</ul>	
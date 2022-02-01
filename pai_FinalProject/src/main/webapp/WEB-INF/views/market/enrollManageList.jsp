<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section>
<div class="container">
<!-------------------------------------------MBTI샵 메뉴바 ---------------------------------------------------------->
<jsp:include page="/WEB-INF/views/market/MenuBar.jsp"/>
 <br>

	<button type="button" class="btn btn-info" onclick="">등록하기</button>
	<table class="table align-middle" style="text-align: center;">
		<thead>
		  <tr>
			<th scope="col">상품번호</th>
			<th scope="col">상품명</th>
			<th scope="col">색상</th>
			<th scope="col">사이즈</th>
			<th scope="col">가격</th>
			<th scope="col">재고수량</th>
			<th scope="col">관리</th>
		  </tr>
		</thead>
		<tbody>
		<c:forEach items="${enrolledList}" var="e">
		  <tr>
			<th scope="row">${e.goodsNo}</th>
			<td>${e.goodsName}</td>
			<td>${e.color}</td>
			<td>${e.size}</td>
			<td>${e.price}</td>
			<td>${e.invenCount}</td>
			<td>
				<button type="button" class="btn btn-outline-success" onclick="">수정</button>
				<button type="button" class="btn btn-outline-danger" onclick="">삭제</button>
			</td>
		  </tr>
		</c:forEach>

		</tbody>
	  </table>
	<div style="text-align:center;">
		${pageBar}
	</div>
	<br>
</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
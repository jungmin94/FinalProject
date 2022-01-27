<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section>

	<button type="button" class="btn btn-info" onclick="">등록하기</button>
	<table class="table" style="text-align: center;">
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
		<!-- 반복문을 통해 출력 -->
		  <tr>
			<th scope="row">@상품번호</th>
			<td>@상품명</td>
			<td>@색상</td>
			<td>@사이즈</td>
			<td>@가격</td>
			<td>@재고수량</td>
			<td>
				<button type="button" class="btn btn-outline-success" onclick="">수정</button>
				<button type="button" class="btn btn-outline-danger" onclick="">삭제</button>
			</td>
		  </tr>

		</tbody>
	  </table>

	<!-- 페이지바 작성 공간 -->

</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
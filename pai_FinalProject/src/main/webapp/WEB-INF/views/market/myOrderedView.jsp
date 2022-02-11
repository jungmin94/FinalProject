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
	<!-------------------------------------------검색창 ---------------------------------------------------------->
<jsp:include page="/WEB-INF/views/market/searchBar.jsp"/>
	<br>

   
 
	<table class="table align-middle" style="text-align: center;">
		<thead>
		  <tr>
			<th scope="col"></th>
			<th scope="col">구매날짜</th>
			<th scope="col">상품명</th>
			<th scope="col">색상</th>
			<th scope="col">사이즈</th>
			<th scope="col">MBTI로고</th>
			<th scope="col">금액</th>
			<th scope="col">수량</th>
			<th scope="col">총 가격</th>
			<th scope="col">구매후기</th>
		  </tr>
		</thead>
		<tbody>
		<c:forEach items="${List}" var="l">
		  <tr>
			<th scope="row">
				<c:if test="${l.image ne null}">
					<img src="${path}/resources/upload/market/${l.image}" class="img-thumbnail" alt="..." style="width: 100px; height: 100px;" 
					onclick="location.assign('${path}/market/goodsDetailView.do?goodsName=${l.orderDetail.get(0).goodsName}')">
				</c:if>
				<c:if test="${l.image eq null}">
					<img src="${path}/resources/images/market/이미지준비중.PNG" class="img-thumbnail" alt="..." style="width: 100px; height: 100px;"
					onclick="location.assign('${path}/market/goodsDetailView.do?goodsName=${l.orderDetail.get(0).goodsName}')">
				</c:if>
			</th>
			<td>${l.orderDate}</td>
			<td>${l.orderDetail.get(0).goodsName}</td>
			<td>${l.orderDetail.get(0).orderColor}</td>
			<td>${l.orderDetail.get(0).orderSize}</td>
			<td>${l.orderDetail.get(0).mbtiLogo}</td>
			<td><fmt:formatNumber  value="${l.orderDetail.get(0).orderPrice/l.orderDetail.get(0).orderCount}"  type="currency"/>원</td>
			<td>${l.orderDetail.get(0).orderCount}</td>
			<td><fmt:formatNumber  value="${l.orderDetail.get(0).orderPrice}"  type="currency"/>원</td>
			<td>
				<c:if test="${l.orderDetail.get(0).checkReview.equals('N')}">
					<button type="button"  id="enrollReviewBtn" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#enrollReviewModal">리뷰등록</button>
				</c:if>
				<c:if test="${l.orderDetail.get(0).checkReview.equals('Y')}">
					<button type="button" class="btn btn-outline-secondary">등록완료</button>
				</c:if>
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
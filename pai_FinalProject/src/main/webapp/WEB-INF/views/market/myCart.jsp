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
			<th scope="col">상품명</th>
			<th scope="col">색상</th>
			<th scope="col">사이즈</th>
			<th scope="col">MBTI로고</th>
			<th scope="col">금액</th>
			<th scope="col">수량</th>
			<th scope="col">총 가격</th>
			<th scope="col"></th>
		  </tr>
		</thead>
		<tbody>
		<c:if test="${cartList eq null || cartList.isEmpty()}">
			<tr>
				<th colspan="9">등록된 장바구니가 없습니다</th>
			</tr>
		</c:if>
		<c:if test="${cartList ne null && !cartList.isEmpty()}">
		<c:forEach items="${cartList}" var="c">
		  <tr>
			<th scope="row">
				<c:if test="${c.image ne null}">
					<img src="${path}/resources/upload/market/${c.image}" class="img-thumbnail" alt="..." style="width: 100px; height: 100px;" 
					onclick="location.assign('${path}/market/goodsDetailView.do?goodsName=${c.goodsName}')">
				</c:if>
				<c:if test="${c.image eq null}">
					<img src="${path}/resources/images/market/이미지준비중.PNG" class="img-thumbnail" alt="..." style="width: 100px; height: 100px;"
					onclick="location.assign('${path}/market/goodsDetailView.do?goodsName=${c.goodsName}')">
				</c:if>
			</th>
			<td>${c.goodsName}</td>
			<td>${c.color}</td>
			<td>${c.size}</td>
			<td>${c.mbtiLogo}</td>
			<td><fmt:formatNumber  value="${c.price}"  type="currency"/>원</td>
			<td>${c.count}</td>
			<td><fmt:formatNumber  value="${c.price*c.count}"  type="currency"/>원</td>
			<td>
				<button type="button"  id="deleteCartBtn" class="btn btn-outline-danger"  data-cno="${c.cartNo}" >삭제</button>
			</td>
		  </tr>
		</c:forEach>
		</c:if>

		</tbody>
	  </table>
	<br>
	
	<div style="text-align:center; border: 1px solid black;">
		<c:if test="${cartList ne null && !cartList.isEmpty()}">
			총결제 금액 : <fmt:formatNumber  value="${totalPrice}"  type="currency"/>원
		</c:if>
	</div>
	<br>
	<div style="text-align:center;">
		<c:if test="${cartList ne null && !cartList.isEmpty()}">
			<button type="button"  class="btn btn-outline-info"  onclick="location.assign('${path}/market/goodsList.do')" >계속 쇼핑하기</button>
			<button type="button"  class="btn btn-outline-primary"  data-cno="${c.cartNo}" 
			onclick="location.assign('${path}/market/cartPurchase.do?totalPrice=${totalPrice}')" >결제하기</button>
		</c:if>
	</div>
		
	</div>

</section>

<script>

// 장바구니 삭제 스크립트
$(document).on("click", "#deleteCartBtn", function () { 
	
	let cartNo = $(this).data('cno');

   	$.ajax({
		url:"${path}/market/deleteCart.do",
		data:{cartNo:cartNo}, //키:벨류 형식으로 데이터를 전송한다
		success:data=>{
			if(data>0){
				alert('해당 상품이 삭제되었습니다! :)');
				history.go(0);
			}else{
				alert('해당 상품 삭제 과정에 오류가 발생하였습니다. :(');
				history.go(0);
			}			
		}	
	});

});

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
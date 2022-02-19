<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
.star-rating {
  border:solid 1px #ccc;
  display:flex;
  flex-direction: row-reverse;
  font-size:1.5em;
  justify-content:space-around;
  padding:0 .2em;
  text-align:center;
  width:5em;
}

.star-rating input {
  display:none;
}

.star-rating label {
  color:#ccc;
  cursor:pointer;
}

.star-rating :checked ~ label {
  color:#f90;
}

.star-rating label:hover,
.star-rating label:hover ~ label {
  color:#fc0;
}
</style>
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
			
			<c:forEach var="i"  begin="0" end="${l.orderDetail.size()-1}" step="1">
			  <tr>
				<th scope="row">
					<c:if test="${l.orderDetail.get(i).image ne null}">
						<img src="${path}/resources/upload/market/${l.orderDetail.get(i).image}" class="img-thumbnail" alt="..." style="width: 100px; height: 100px;" 
						onclick="location.assign('${path}/market/goodsDetailView.do?goodsName=${l.orderDetail.get(i).goodsName}')">
					</c:if>
					<c:if test="${l.orderDetail.get(i).image eq null}">
						<img src="${path}/resources/images/market/이미지준비중.PNG" class="img-thumbnail" alt="..." style="width: 100px; height: 100px;"
						onclick="location.assign('${path}/market/goodsDetailView.do?goodsName=${l.orderDetail.get(i).goodsName}')">
					</c:if>
				</th>
				<td>${l.orderDate}</td>
				<td>${l.orderDetail.get(i).goodsName}</td>
				<td>${l.orderDetail.get(i).orderColor}</td>
				<td>${l.orderDetail.get(i).orderSize}</td>
				<td>${l.orderDetail.get(i).mbtiLogo}</td>
				<td><fmt:formatNumber  value="${l.orderDetail.get(i).orderPrice/l.orderDetail.get(i).orderCount}"  type="currency"/>원</td>
				<td>${l.orderDetail.get(i).orderCount}</td>
				<td><fmt:formatNumber  value="${l.orderDetail.get(i).orderPrice}"  type="currency"/>원</td>
				<td>
					<c:if test="${l.orderDetail.get(i).checkReview.equals('N')}">
						<button type="button"  id="enrollReviewBtn" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#enrollReviewModal"
						data-gno="${l.orderDetail.get(i).goodsNo}" data-gname="${l.orderDetail.get(i).goodsName}" data-detailno="${l.orderDetail.get(i).orderDetailNo}">리뷰등록</button>
					</c:if>
					<c:if test="${l.orderDetail.get(i).checkReview.equals('Y')}">
						<button type="button" class="btn btn-outline-secondary">등록완료</button>
					</c:if>
				</td>
			  </tr>
			</c:forEach>
		</c:forEach>
			
		</tbody>
	  </table>
	<div style="text-align:center;">
		${pageBar}
	</div>
	<br>
</div>
</section>

<!-- 리뷰등록  -->
<div class="modal fade" id="enrollReviewModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">리뷰등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" >
      <form id="enrollReviewFrm" action="${path}/market/enrollReview.do">
    	<span style="color:purple;">별점</span>
		<div class="star-rating" >
		  <input type="radio" id="5-stars" name="grade" value="5" />
		  <label for="5-stars" class="star">&#9733;</label>
		  <input type="radio" id="4-stars" name="grade" value="4" />
		  <label for="4-stars" class="star">&#9733;</label>
		  <input type="radio" id="3-stars" name="grade" value="3" />
		  <label for="3-stars" class="star">&#9733;</label>
		  <input type="radio" id="2-stars" name="grade" value="2" />
		  <label for="2-stars" class="star">&#9733;</label>
		  <input type="radio" id="1-star" name="grade" value="1" />
		  <label for="1-star" class="star">&#9733;</label>
		</div>
		<br>
		<span style="color:purple;">내용작성</span>
		<div class="form-floating">
		  <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea2"  name="reviewText" style="height: 200px;"></textarea>
		</div>
		<input type="hidden" id="re_mem_id" name="member_id" value="${loginMember.member_id}">
		<input type="hidden" id="re_goodsNo" name="goodsNo">
		<input type="hidden" id="re_goodsName" name="goodsName">
		<input type="hidden" id="re_detailNo" name="orderDetailNo">
	</form>


      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="$('#enrollReviewFrm').submit();">등록</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

<script>
$(document).on("click", "#enrollReviewBtn", function () { 
	
	let goodNo = $(this).data('gno');
	let goodName = $(this).data('gname');
	let detailNo = $(this).data('detailno');
	
	$('#re_goodsName').val(goodName);
	$('#re_goodsNo').val(goodNo);
	$('#re_detailNo').val(detailNo);

});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
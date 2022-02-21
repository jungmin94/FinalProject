<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
			.loading span {
			  display: inline-block;
			  margin: 0 -.075em;
			  animation: loading .8s infinite alternate;
			  text-align: center; font-size: 50px; color: #01DFD7;
			}
			.loading span:nth-child(2) {
			  animation-delay: .1s;
			}
			.loading span:nth-child(3) {
			  animation-delay: .2s;
			}
			.loading span:nth-child(4) {
			  animation-delay: .3s;
			}
			.loading span:nth-child(5) {
			  animation-delay: .4s;
			}
			.loading span:nth-child(6) {
			  animation-delay: .5s;
			}
			.loading span:nth-child(7) {
			  animation-delay: .6s;
			}
			.loading span:nth-child(8) {
			  animation-delay: .7s;
			}
			@keyframes loading {
			  0% {
			    transform: scale(1);
			  }
			  100% {
			    transform: scale(0.8);
			  }
			}


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

.star-ratings {
  color: #aaa9a9; 
  position: relative;
  unicode-bidi: bidi-override;
  width: max-content;
  -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
  -webkit-text-stroke-width: 1.3px;
  -webkit-text-stroke-color: #2b2a29;
}
 
.star-ratings-fill {
  color: #fff58c;
  padding: 0;
  position: absolute;
  z-index: 1;
  display: flex;
  top: 0;
  left: 0;
  overflow: hidden;
  -webkit-text-fill-color: gold;
}
 
.star-ratings-base {
  z-index: 0;
  padding: 0;
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
	
	<div class="loading"  style="text-align: center;">
		<span>R</span>
		<span>E</span>
		<span>V</span>
		<span>I</span>	
		<span>E</span>
		<span>W</span>
   </div>
   <br>

	<table class="table align-middle" style="text-align: center;">
		<thead>
		  <tr>
			<th scope="col">상품명</th>
			<th scope="col">색상</th>
			<th scope="col">사이즈</th>
			<th scope="col">MBTI로고</th>
			<th scope="col">별점</th>
			<th scope="col">구매후기</th>
			<th scope="col">리뷰관리</th>
		  </tr>
		</thead>
		<tbody>
		<c:if test="${reviewList eq null || reviewList.isEmpty()}">
			<tr>
				<th colspan="7">등록하신 리뷰가 없습니다</th>
			</tr>
		</c:if>
		<c:if test="${reviewList ne null && !reviewList.isEmpty()}">
		<c:forEach items="${reviewList}" var="r">
		  <tr>
			<td><a href="${path}/market/goodsDetailView.do?goodsName=${r.goodsName}">${r.goodsName}</a></td>
			<td>${r.orderDetail.orderColor}</td>
			<td>${r.orderDetail.orderSize}</td>
			<td>${r.orderDetail.mbtiLogo}</td>
			<td>
					<div class="star-ratings" >
						<div class="star-ratings-fill space-x-2 text-lg" >
							 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							<c:choose>
								<c:when test="${r.grade==1}"><span>★</span></c:when>
								<c:when test="${r.grade==2}"><span>★</span><span>★</span></c:when>
								<c:when test="${r.grade==3}"><span>★</span><span>★</span><span>★</span></c:when>
								<c:when test="${r.grade==4}"><span>★</span><span>★</span><span>★</span><span>★</span></c:when>
								<c:when test="${r.grade==5}"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></c:when>
							</c:choose>
						</div>
						<div class="star-ratings-base space-x-2 text-lg">
							&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
						</div>
					</div>
			</td>
			<td style="width:200px;">${r.reviewText}</td>
			<td>
				<button type="button"  id="updateReviewBtn" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#updateReviewModal"
				data-rno="${r.reviewNo}" data-rgrade="${r.grade}" data-rtext="${r.reviewText}">수정</button>				
				<button type="button"  id="deleteReviewBtn" class="btn btn-outline-danger"  data-bs-toggle="modal" data-bs-target="#deleteReviewModal" 
				data-rno="${r.reviewNo}" data-rgname="${r.goodsName}">삭제</button>
			</td>
		  </tr>
		</c:forEach>
		</c:if>

		</tbody>
	  </table>
	<div style="text-align:center;">
		${pageBar}
	</div>
	<br>
</div>

</section>

<!-- 리뷰수정  -->
<div class="modal fade" id="updateReviewModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">리뷰수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" >
      <form id="updateReviewFrm" action="${path}/market/updateReview.do">
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
		  <textarea class="form-control" placeholder="Leave a comment here" id="up_reviewText"  name="reviewText" style="height: 200px;"></textarea>
		</div>
		<input type="hidden" id="up_reviewNo" name="reviewNo">
	</form>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="$('#updateReviewFrm').submit();">수정</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>


<!-- 리뷰삭제  -->
<div class="modal fade" id="deleteReviewModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">리뷰삭제</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body"  style="text-align:center;">
      <form id="deleteReviewFrm" action="${path}/market/deleteReview.do">
  		 삭제 시 복구나 재등록이 불가능합니다.<br>
			정말 삭제하시겠습니까?
		<input type="hidden" id="re_de_goodsName" name="goodsName">
		<input type="hidden" id="re_de_reviewNo" name="reviewNo">
	</form>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="$('#deleteReviewFrm').submit();">삭제</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

<script>

$(document).on("click", "#updateReviewBtn", function () { 
	
	let reviewNo = $(this).data('rno');
	let text = $(this).data('rtext');
	let grade = $(this).data('rgrade');
	console.log(grade);
	$('#up_reviewNo').val(reviewNo);
	$('#up_reviewText').val(text);
	$("input:radio[name='grade']:radio[value='"+grade+"']").prop('checked', true); 
});


$(document).on("click", "#deleteReviewBtn", function () { 
	
	let reviewNo = $(this).data('rno');
	let goodName = $(this).data('rgname');
	
	$('#re_de_goodsName').val(goodName);
	$('#re_de_reviewNo').val(reviewNo);

});

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
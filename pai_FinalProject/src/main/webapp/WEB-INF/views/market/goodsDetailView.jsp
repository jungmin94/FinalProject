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
</style>
<section>
<div class="container">
    <div class="row">
      <div class="col">
        <img src="https://s-i.huffpost.com/gen/3948866/thumbs/o-PEPE-THE-FROG-570.jpg?3" class="img-thumbnail" alt="..." style="width: 500px; height: 500px;">
      </div>
      <div class="col">
       <form action="" method="post">
        카테고리 1 (색상)
        <select class="form-select" aria-label="Default select example">
            <option selected>Open this select menu</option>
            <option value="1">One</option>
            <option value="2">Two</option>
            <option value="3">Three</option>
          </select>
          <br>
          카테고리 2 (MBTI 로고)
          <select class="form-select" aria-label="Default select example">
            <option selected>Open this select menu</option>
            <option value="1">One</option>
            <option value="2">Two</option>
            <option value="3">Three</option>
          </select>
          <br>
          카테고리 3 (사이즈)
          <select class="form-select" aria-label="Default select example">
            <option selected>Open this select menu</option>
            <option value="1">One</option>
            <option value="2">Two</option>
            <option value="3">Three</option>
          </select>
          <br>
          수량
          <input type="number" class="form-control" start=1 id="inputGoodsName" name="buycount">
          <br>
          가격
          <input type="number" class="form-control" start=1 id="inputGoodsName" name="totalprice" readonly>
          <br>
          <button type="submit" class="btn btn-outline-primary">구매하기</button>
          <button type="button" class="btn btn-outline-info">장바구니</button>
       </form>
      </div>
    </div>
  </div>
  <br>
  <div class="container">
    <div class="row">
      <div class="col" style="background-color: #E6E6E6; height: 50px; text-align: center; padding-top: 12px; color: #819FF7;">
        제품 설명
      </div>
  </div>
 </div>
  <br>

  <div class="container" > 
	<div class="loading"  style="text-align: center;">
		<span>M</span>
		<span>B</span>
		<span>T</span>
		<span>I</span>
		<span>성</span>
		<span>격</span>
		<span>유</span>
		<span>형</span>
   </div>
</div>

  <div class="container" style="text-align: center;">
	<img src="image\MBTI1.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<img src="image\MBTI2.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<!-- 반복문 통해 제품 사진 올리는 부분 -->
    <img src="https://hanamsport.or.kr/www/images/contents/thum_detail.jpg" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
    <img src="https://hanamsport.or.kr/www/images/contents/thum_detail.jpg" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
    <img src="https://hanamsport.or.kr/www/images/contents/thum_detail.jpg" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<!-- 제품 사진 끝부분 (최대 3장 올릴 것) -->
	<img src="image\상품정보1.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<img src="image\사이즈1.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<img src="image\사이즈2.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<img src="image\gggg.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
  </div>

  	<div class="container" style="text-align: center;">

	</div>

	<br>
  <div class="container" style="text-align: center;">
	<div class="d-grid gap-2">
		<button class="btn btn-primary" type="button" onclick="location.assign('#nav-menu')">TOP</button>
	  </div>
  </div>

<br>



</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
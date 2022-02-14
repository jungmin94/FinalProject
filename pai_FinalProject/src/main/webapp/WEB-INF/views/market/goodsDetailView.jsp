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
  padding-left: 0;
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
</div>
<input type="hidden" id="price" >
<div class="container">
    <div class="row">
      <div class="col">
          	<c:if test="${good.image ne null}">
        		<img src="${path}/resources/upload/market/${good.image}" class="img-thumbnail" alt="..." style="width: 500px; height: 500px;">
  			</c:if>
    		<c:if test="${good.image eq null}">
        		<img src="https://hanamsport.or.kr/www/images/contents/thum_detail.jpg" class="img-thumbnail" alt="..." style="width: 500px; height: 500px;">
  			</c:if>
      </div>
      <div class="col">
       <form id="purchaseFrm" action="${path}/market/purchaseGood.do" method="post">
        카테고리 1 (색상)
        <select class="form-select" id="select_color"  name="orderColor" aria-label="Default select example" required>
            <option disabled selected>색상을 선택하세요</option>
            <c:forEach items="${colorList}" var="c">
            	   <option value="${c.color}">${c.color}</option>
            </c:forEach>
          </select>
          <br>
          카테고리 2 (사이즈)
          <select class="form-select"  id="select_size"  name="orderSize" aria-label="Default select example" required>
            <option disabled selected>사이즈를 선택해주세요</option>
          </select>
          <br>
          카테고리 3 (MBTI로고) <span style="color:red;">@주문제작@</span>
          <select class="form-select" aria-label="Default select example" name="mbtiLogo" required>
            <option disabled selected>MBTI로고를 선택해주세요</option>
            <option value="ISTJ">ISTJ</option>
            <option value="ISFJ">ISFJ</option>
            <option value="INFJ">INFJ</option>
            <option value="INTJ">INTJ</option>
            <option value="ISTP">ISTP</option>
            <option value="ISFP">ISFP</option>
            <option value="INFP">INFP</option>
            <option value="INTP">INTP</option>
            <option value="ESTP">ESTP</option>
            <option value="ESFP">ESFP</option>
            <option value="ENFP">ENFP</option>
            <option value="ENTP">ENTP</option>
            <option value="ESTJ">ESTJ</option>
            <option value="ESFJ">ESFJ</option>
            <option value="ENFJ">ENFJ</option>
            <option value="ENTJ">ENTJ</option>
          </select>
          <br>
          수량
          <input type="number" class="form-control"  min="1" id="inputBuyCount" name="orderCount">
          <br>
         
          <!-- <input type="hidden" class="form-control" start=1 id="inputTotlaPrice" name="totalPrice"> -->
			<%-- <p><fmt:formatNumber var="totalPrice" value=""  type="currency"/>원</p> --%>
			<input type="number"  id="inputTotalPrice" name="orderPrice" readonly>원
		  <br>
          <br>
          <input type="hidden" id="gName"  name="goodsName" value="${good.goodsName}">
          <input type="hidden" id="gNo"  name="goodsNo" value="${good.goodsNo}">
          <button type="submit" class="btn btn-outline-primary" onclick="$('#purchaseFrm').submit();">구매하기</button>
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
	<img src="${path}/resources/images/market/MBTI1.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<img src="${path}/resources/images/market/MBTI2.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<img src="${path}/resources/images/market/마켓설명1.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<img src="${path}/resources/images/market/마켓설명2.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<img src="${path}/resources/images/market/카툰.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 2100px;">
	<!-- 반복문 통해 제품 사진 올리는 부분 -->
	<c:if test="${imageList eq null || imageList.size() eq 0}">
    	<img src="https://hanamsport.or.kr/www/images/contents/thum_detail.jpg" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
    </c:if>
    <c:if test="${imageList ne null && imageList.size() ne 0}">
    	<img src="${path}/resources/upload/market/${imageList.filePath}" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
    </c:if>
	<!-- 제품 사진 끝부분 (최대 3장 올릴 것) -->
	<img src="${path}/resources/images/market/인쇄예시.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<br>
	<br>
	<div style="text-align:center; color:purple;">(반발 사이즈)<br><span style="color:red;">(남/여)</span></div>
	<br>
	<img src="${path}/resources/images/market/사이즈1.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<img src="${path}/resources/images/market/사이즈2.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<br>
	<br>
	<div style="text-align:center; color:purple;">(긴팔 사이즈)</div>
	<br>
	<img src="${path}/resources/images/market/사이즈3.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<img src="${path}/resources/images/market/사이즈4.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<img src="${path}/resources/images/market/세탁방법.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
	<img src="${path}/resources/images/market/제품증명.PNG" class="img-thumbnail" alt="..." style="width: 800px; height: 800px;">
  </div>
	<br>
	<br>
  	<div class="container" style="text-align: center; color:purple;">
		<h3>상품리뷰</h3>
	<table class="table align-middle" style="text-align: center;">
		<thead>
		  <tr>
			<th scope="col">구매자</th>
			<th scope="col">색상</th>
			<th scope="col">사이즈</th>
			<th scope="col">MBTI로고</th>
			<th scope="col" >별점</th>
			<th scope="col">구매후기</th>
		  </tr>
		</thead>
		<tbody>
		<c:forEach items="${reviewList}" var="r">
		  <tr>
			<td>${r.member_id}</td>
			<td>${r.orderDetail.orderColor}</td>
			<td>${r.orderDetail.orderSize}</td>
			<td>${r.orderDetail.mbtiLogo}</td>
			<td>
					<div class="star-ratings" >
						<div class="star-ratings-fill space-x-2 text-lg" >
							<!--  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp -->
							<c:choose>
								<c:when test="${r.grade==1}"><span>★</span></c:when>
								<c:when test="${r.grade==2}"><span>★</span><span>★</span></c:when>
								<c:when test="${r.grade==3}"><span>★</span><span>★</span><span>★</span></c:when>
								<c:when test="${r.grade==4}"><span>★</span><span>★</span><span>★</span><span>★</span></c:when>
								<c:when test="${r.grade==5}"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></c:when>
							</c:choose>
						</div>
						<div class="star-ratings-base space-x-2 text-lg">
				<!-- 			&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp -->
							<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
						</div>
					</div>
			</td>
			<td style="width:200px;">${r.reviewText}</td>
		  </tr>
		</c:forEach>

		</tbody>
	  </table>
		
	</div>
	<div style="text-align:center;">
		${pageBar}
	</div>


	<br>
  <div class="container" style="text-align: center;">
	<div class="d-grid gap-2">
		<button class="btn btn-primary" type="button" onclick="location.assign('#nav-menu')">TOP</button>
	  </div>
  </div>

<br>

</section>

<script>

$(document).ready(function () {
    $('#select_color').change(function () {
    	$.ajax({
    		url:"${path}/market/sizeInvenList.do",
    		data:{color:$("#select_color").val(),goodsName:$("#gName").val()}, 
    		success:data=>{
    		$('#select_size').empty();
    		let defoption=$("<option disabled selected>"+"사이즈를 선택하세요"+"</option>");
    		$('#select_size').append(defoption);
				for(let i=0; i<data.length; i++){
					let option;
					if(data[i].invenCount==0){
						option = $("<option style='color:red;' disabled value='"+data[i].size+"'>"+data[i].size+" 품절</option>");
					}else if(0<data[i].invenCount && data[i].invenCount<5){
						option = $("<option style='color:#F781BE;' value='"+data[i].size+"'>"+data[i].size+" 품절임박("+data[i].invenCount+"개남음)</option>");
					}else{
						option = $("<option value='"+data[i].size+"'>"+data[i].size+" -"+data[i].invenCount+"개남음-</option>");
					}
					$('#select_size').append(option);
    			}
    		}	
    	});	
    });
});

$(document).ready(function () {
    $('#select_size').change(function () {
    	$.ajax({
    		url:"${path}/market/goodPrice.do",
    		data:{color:$("#select_color").val(),goodsName:$("#gName").val(),size:$("#select_size").val()}, 
    		success:data=>{
    				$('#price').val(data.price);
    				$('#inputTotalPrice').val(data.price);
    				$('#inputBuyCount').val(1);
    				$('#inputBuyCount').attr("max",data.invenCount);
    			}  
    		})	
    	});	
    });
    
$(document).ready(function () {
    $('#inputBuyCount').change(function () {
    		if($(this).val()<1){
    			alert('수량은 최소 1개입니다. 다시 입력하세요.');
    			$(this).val(1);    		
    		}else if(parseInt($('#inputBuyCount').attr("max"))<$(this).val()){
    			alert('현재 남아있는 재고보다 많이 주문하실 수 없습니다. 죄송합니다');
    			let con = parseInt($(this).val());
    			$(this).val(parseInt($('#inputBuyCount').attr("max")));			
    		}
			let count = parseInt($('#inputBuyCount').val());
			let price = parseInt($('#price').val());		
			let total = count*price;
			$('#inputTotalPrice').val(total);
    	});	
    });
    
    



</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
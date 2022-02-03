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

<div class="row">
    <div class="col-2">
      <button type="button" class="btn btn-info" onclick="">신규상품 등록</button>
    </div>
   
    <div class="col">
	<form class="row g-3" action="${path}/market/goodSearch.do">
	  <div class="col-auto">
	 <div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio" name="searchOp" id="inlineRadio1" value="code">
	  <label class="form-check-label" for="inlineRadio1">상품코드</label>
	</div>
	<div class="form-check form-check-inline" style="padding-top:5px;">
	  <input class="form-check-input" type="radio" name="searchOp" id="inlineRadio2" value="name">
	  <label class="form-check-label" for="inlineRadio2">상품명</label>
	</div>
	  </div>
	  <div class="col-auto">
	    <input type="search" class="form-control" id="inputPassword2"  name="searchText" placeholder="검색어를 입력하세요">
	  </div>
	  <div class="col-auto">
	    <button type="submit" class="btn btn-primary mb-3">검색</button>
	  </div>
	</form>
      </div>
    </div>

<table class="table align-middle" style="text-align: center;">
		<thead>
		  <tr>
			<th scope="col">상품번호</th>
			<th scope="col">상품명</th>
			<th scope="col">등록일</th>
			<th scope="col">카테고리1</th>
			<th scope="col">카테고리2</th>
			<th scope="col">총판매량</th>
			<th scope="col">평점</th>
			<th scope="col">등록</th>
		  </tr>
		</thead>
		<tbody>
		<c:forEach items="${goodsList}" var="g">
		  <tr>
			<th scope="row">${g.goodsNo}</th>
			<td>${g.goodsName}</td>
			<td>${g.goodsEnrollDate}</td>
			<td>
				<c:if test="${g.largeCategory eq 'M'}">남성용</c:if>
				<c:if test="${g.largeCategory eq 'F'}">여성용</c:if>			
			</td>
			<td>${g.middleCategory}</td>
			<td>${g.totalCell}</td>
			<td>${g.avgGrade}</td>
			<td>
				<button type="button" class="btn btn-outline-primary" onclick="">
  				상품 상세등록
				</button>
				<c:if test="${g.image eq null}">
					<button type="button"  id="updateGoodImageBtn" class="btn btn-outline-success" 
					data-bs-toggle="modal" data-bs-target="#updateGoodImage" data-gno="${g.goodsNo}" data-gname="${g.goodsName}">
	  				대표이미지 등록
					</button>
				</c:if>
				<c:if test="${g.image ne null}">
					<button type="button"  id="updateGoodImageBtn" class="btn btn-outline-secondary" 
					data-bs-toggle="modal" data-bs-target="#updateGoodImage" data-gno="${g.goodsNo}" data-gname="${g.goodsName}">
	  				대표이미지 수정
					</button>
				</c:if>
				<c:if test="${g.goodsDetailImage.isEmpty()}">
					<button type="button" class="btn btn-outline-success" onclick="">
	  				상세이미지 등록
					</button>
				</c:if>
				<c:if test="${g.goodsDetailImage.size() ne 0}">
					<button type="button" class="btn btn-outline-secondary" onclick="">
	  				상세이미지 수정
					</button>
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

<!--------------------------------------------- Modal ----------------------------------------------------------------->
<!-- 대표 이미지 등록/수정  -->
<div class="modal fade" id="updateGoodImage" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">상품 대표이미지</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="text-align:center;">
        <form id="enrollGoodImgFrm" action="${path}/market/enrollGoodImage.do" method="post"
        enctype="multipart/form-data">
        	<input type="hidden" id="img_gno" name="goodsNo">
        	<input type="hidden" id="img_gname" name="goodsName">
        	<img id="image_section" src="${path}/resources/images/market/add-image.PNG"  alt="your image" style="height:300px; width:300px;"/>
        	<br><br>
        	<input type='file' id="imgInput" name="upFile"/>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="$('#enrollGoodImgFrm').submit();">확인</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

<!-- 상세 이미지 등록/수정  -->
<div class="modal fade" id="updateGoodDetailImage" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">상품 대표이미지</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...1
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary">확인</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>



<script>

$(document).on("click", "#updateGoodImageBtn", function () { 
	
	let goodNo = $(this).data('gno');
	let goodName = $(this).data('gname');

	$('#img_gno').val(goodNo);
	$('#img_gname').val(goodName);

});

// 대표 이미지 등록시 이미지 파일 미리 보여주기 로직
function readURL(input) {
	 if (input.files && input.files[0]) {
	  var reader = new FileReader();
	  
	  reader.onload = function (e) {
	   $('#image_section').attr('src', e.target.result);  
	  }
	  
	  reader.readAsDataURL(input.files[0]);
	  }
	}
	 
	// 이벤트를 바인딩해서 input에 파일이 올라올때 (input에 change를 트리거할때) 위의 함수를 this context로 실행
	$("#imgInput").change(function(){
	   readURL(this);
	});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
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
      <button type="button" class="btn btn-info" onclick="">신규등록하기</button>
    </div>
   
    <div class="col">
	<form class="row g-3" action="${path}/market/enrolledGoodSearch.do">
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
			<th scope="col">색상</th>
			<th scope="col">사이즈</th>
			<th scope="col">가격</th>
			<th scope="col">재고수량</th>
			<th scope="col">재고/상품관리</th>
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
			<td>
				<c:if test="${e.invenCount==0}">
					<span style="color:red;">품절</span>
				</c:if>
				<c:if test="${e.invenCount<6}">
					<span style="color:red;">${e.invenCount}</span>
				</c:if>
				<c:if test="${e.invenCount>5}">
					${e.invenCount}
				</c:if>
			</td>
			<td>
				<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#enrollGoodModal">
  				등록
				</button>
				<button type="button"  id="updateGoodBtn" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#updateGoodModal"
				data-gno="${e.goodsNo}" data-gname="${e.goodsName}"  data-gcolor="${e.color}" data-gsize="${e.size}"  data-gprice="${e.price}" data-ginven="${e.invenCount}" >
  				수정
				</button>
				<button type="button"  id="deleteGoodBtn" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteGoodModal"
				data-gno="${e.goodsNo}" data-gname="${e.goodsName}"  data-gcolor="${e.color}" data-gsize="${e.size}" >
  				삭제
				</button>
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
<!-- 기존 상품 추가 등록 모달  -->
<div class="modal fade" id="enrollGoodModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">상품 추가등록</h5>
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

<!-- 관리자 제품 수정 모달  -->
<div class="modal fade" id="updateGoodModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">상품정보 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form id="upd_goodFrm" action="${path}/market/updateGood.do" method="post">
        상품코드<input type="text"  id="upd_gno" name="upgoodno" class="form-control"   value="" readonly><br>
        상품명<input type="text" id="upd_gname" name="upgoodname" class="form-control"   value="" readonly><br>
        색상<input type="text" id="upd_gcolor" name="upgoodcolor" class="form-control"   value="" readonly><br>
        사이즈<input type="text" id="upd_gsize" name="upgoodsize" class="form-control"   value="" readonly><br>
        재고<input type="text" id="upd_ginven" name="upgoodinven" class="form-control"   value="" ><br>
        가격<input type="text" id="upd_gprice" name="upgoodprice" class="form-control"   value="" ><br>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="$('#upd_goodFrm').submit();">확인</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

<!-- 관리자 제품 삭제 모달  -->
<div class="modal fade" id="deleteGoodModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">상품 삭제</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="text-align:center;">
      삭제하시겠습니까?
         <form id="del_goodFrm" action="${path}/market/deleteGood.do" method="post">
	      <input type="hidden" id="del_gname" name="delgoodname" class="form-control"   value="" ><br>
	      <input type="hidden" id="del_gcolor" name="delgoodcolor" class="form-control"   value="" ><br>
	      <input type="hidden" id="del_gsize" name="delgoodsize" class="form-control"   value="" ><br>
        </form>
        <form id="del_goodAllFrm" action="${path}/market/deleteGood.do" method="post">
	      <input type="hidden" id="del_gno" name="delgoodno" class="form-control"   value="" ><br>
        </form>
       </div>
      <div class="modal-footer">
       <button type="button" class="btn btn-danger" onclick="$('#del_goodAllFrm').submit();">해당상품 전체삭제</button>
        <button type="button" class="btn btn-primary" onclick="$('#del_goodFrm').submit();">해당상품 삭제</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>


<!------------------------------------------------Scrpit----------------------------------------------------------------->
<script>

$(document).on("click", "#updateGoodBtn", function () { 
	
	let goodNo = $(this).data('gno');
	let goodName = $(this).data('gname');
	let goodColor = $(this).data('gcolor');
	let goodSize = $(this).data('gsize');
	let goodPrice = $(this).data('gprice');
	let goodInven = $(this).data('ginven');

	$('#upd_gno').val(goodNo);
	$('#upd_gname').val(goodName);
	$('#upd_gcolor').val(goodColor);
	$('#upd_gsize').val(goodSize);
	$('#upd_gprice').val(goodPrice);
	$('#upd_ginven').val(goodInven);

});

$(document).on("click", "#deleteGoodBtn", function () { 
	
	let goodNo = $(this).data('gno');
	let goodName = $(this).data('gname');
	let goodColor = $(this).data('gcolor');
	let goodSize = $(this).data('gsize');
	
	$('#del_gname').val(goodName);
	$('#del_gcolor').val(goodColor);
	$('#del_gsize').val(goodSize);
	$('#del_gno').val(goodNo);

});

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
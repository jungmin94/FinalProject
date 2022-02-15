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
      <button type="button"  id="enrollGoodBtn" class="btn btn-outline-primary" data-bs-toggle="modal"  data-bs-target="#enrollGoods" >
	  	상품 등록
	</button>
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
				<button type="button"  id="enrollGoodDetailBtn" class="btn btn-outline-info" 
					data-bs-toggle="modal" data-bs-target="#enrollGoodDetail" data-gno="${g.goodsNo}" data-gname="${g.goodsName}">
	  				상품 상세등록
				</button>
				<c:if test="${g.image eq null}">
					<button type="button"  id="updateGoodImageBtn" class="btn btn-outline-success" 
					data-bs-toggle="modal" data-bs-target="#updateGoodImage" data-gno="${g.goodsNo}" data-gname="${g.goodsName}">
	  				대표이미지 등록
					</button>
				</c:if>
				<c:if test="${g.image ne null}">
					<button type="button"  id="updateGoodImageBtn" class="btn btn-outline-warning" 
					data-bs-toggle="modal" data-bs-target="#updateGoodImage" data-gno="${g.goodsNo}" data-gname="${g.goodsName}" data-img="${g.image}">
	  				대표이미지 수정
					</button>
				</c:if>
				<c:if test="${g.goodsDetailImage.isEmpty()}">
					<button type="button"  id="enrollGoodDetailImageBtn" class="btn btn-outline-success"  
					data-bs-toggle="modal" data-bs-target="#enrollGoodDetailImage"  data-gno="${g.goodsNo}" data-gname="${g.goodsName}">
	  				상세이미지 등록
					</button>
				</c:if>
				<c:if test="${g.goodsDetailImage.size() ne 0}">
					<button type="button" id="updateGoodDetailImageBtn"   class="btn btn-outline-warning" 
					data-bs-toggle="modal" data-bs-target="#updateGoodDetailImage"  data-gno="${g.goodsNo}" data-gname="${g.goodsName}" data-dlist="${g.goodsDetailImage}">
	  				상세이미지 수정
					</button>
				</c:if>
				<button type="button"  id="deleteTitleGoodBtn" class="btn btn-outline-danger" 
					data-bs-toggle="modal" data-bs-target="#deleteGoods" data-gno="${g.goodsNo}" data-gname="${g.goodsName}">
	  				상품 삭제
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
        	<img id="image_section" src=""  alt="your image" style="height:300px; width:300px;"/>
        	<br><br>
        	<input type='file' id="imgInput" name="upFile"/><br>
        	<label class="form-label"  id="lab_img" style="color:#7401DF;"></label>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="$('#enrollGoodImgFrm').submit();">수정</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

<!-- 상세 이미지 등록  -->
<div class="modal fade" id="enrollGoodDetailImage" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">상품 상세이미지</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <div style="text-align:center; color:purple;">최대 3장까지 등록 가능합니다</div>
      <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
		  <div class="carousel-indicators">
		    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
		    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
		  </div>
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src=""  id="car_img1" class="d-block w-100" alt="..." style="height:300px; width:300px;">
		      <div class="carousel-caption d-none d-md-block">
		        <h5 id="h_img1"></h5>
		      </div>
		    </div>
		    <div class="carousel-item">
		      <img src="" id="car_img2"  class="d-block w-100" alt="..." style="height:300px; width:300px;">
		      <div class="carousel-caption d-none d-md-block">
		        <h5 id="h_img2"></h5>
		      </div>
		    </div>
		    <div class="carousel-item">
		      <img src="" id="car_img3"  class="d-block w-100" alt="..." style="height:300px; width:300px;">
		      <div class="carousel-caption d-none d-md-block">
		        <h5 id="h_img3"></h5>
		      </div>
		    </div>
		  </div>
		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>
      
      	<br>
      	<br>
      
        <form id="enrollGoodDetailImgFrm" action="${path}/market/enrollGoodDetailImage.do" method="post"
        enctype="multipart/form-data">
			<input type='file' id="imgInput1" name="upFile" required/><br><br>
			<input type='file' id="imgInput2" name="upFile" required/><br><br>
			<input type='file' id="imgInput3" name="upFile" required/><br><br>
			<input type="hidden" id="detailImg_gno" name="goodsNo">
        	<input type="hidden" id="detailImg_gname" name="goodsName">
        </form>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="$('#enrollGoodDetailImgFrm').submit();">등록</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>


<!-- 상세 이미지 수정  -->
<div class="modal fade" id="updateGoodDetailImage" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">상품 상세이미지</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <div style="text-align:center; color:purple;">1~3개(낱개별) 수정 가능합니다</div>
      <div id="carouselExampleCaptions1" class="carousel slide" data-bs-ride="carousel">
		  <div class="carousel-indicators">
		    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
		    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
		  </div>
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src=""  id="up_car_img1" class="d-block w-100" alt="..." style="height:300px; width:300px;">
		      <div class="carousel-caption d-none d-md-block">
		        <h5 id="h_img1"></h5>
		      </div>
		    </div>
		    <div class="carousel-item">
		      <img src="" id="up_car_img2"  class="d-block w-100" alt="..." style="height:300px; width:300px;">
		      <div class="carousel-caption d-none d-md-block">
		        <h5 id="h_img2"></h5>
		      </div>
		    </div>
		    <div class="carousel-item">
		      <img src="" id="up_car_img3"  class="d-block w-100" alt="..." style="height:300px; width:300px;">
		      <div class="carousel-caption d-none d-md-block">
		        <h5 id="h_img3"></h5>
		      </div>
		    </div>
		  </div>
		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions1" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions1" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>
      
      	<br>
      	<br>
      
        <form id="updateGoodDetailImgFrm" action="${path}/market/updateGoodDetailImage.do" method="post"
        enctype="multipart/form-data">
        
			<input type='file' id="up_imgInput1" name="upFile"/><br><label class="form-label"  id="lab_img1" style="color:#7401DF;"></label><br>
			<input type='file' id="up_imgInput2" name="upFile"/><br><label class="form-label" id="lab_img2" style="color:#7401DF;"></label><br>
			<input type='file' id="up_imgInput3" name="upFile"/><br><label class="form-label" id="lab_img3" style="color:#7401DF;"></label><br>
			<input type="hidden" id="up_detailImg_gno" name="goodsNo">
        	<input type="hidden" id="up_detailImg_gname" name="goodsName">
        	<input type="hidden" id="up_imgNo1" name="imgNo">
        	<input type="hidden" id="up_imgNo2" name="imgNo">
        	<input type="hidden" id="up_imgNo3" name="imgNo">
        </form>
            <input type="hidden" id="imgNo1" >
        	<input type="hidden" id="imgNo2" >
        	<input type="hidden" id="imgNo3" >
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="$('#updateGoodDetailImgFrm').submit();">수정</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>


<!-- 상품 등록  -->
<div class="modal fade" id="enrollGoods" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">상품 등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form id="enrGoodsFrm" action="${path}/market/enrollGoods.do">
      상품이름
      <input type="text" class="form-control"  name="goodsName" id="enr_goodsname_"  onchange="duplicategoodsName();" required><br>
        <select id="cate_large" class="form-control" name="largeCategory" required>
			<option value="" disabled selected>성별</option>
			<option value="M">남성용</option>
			<option value="F">여성용</option>
		</select>
		<br>
        <select id="cate_middle" class="form-control" name="middleCategory" required>
			<option value="" disabled selected>용도</option>
			<option value="반팔">반팔</option>
			<option value="긴팔">긴팔</option>
		</select>
		<br>
      </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="$('#enrGoodsFrm').submit();">등록</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

<!-- 상품 상세 등록  -->
<div class="modal fade" id="enrollGoodDetail" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">상품 상세등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form id="enrGoodsDetailsFrm" action="${path}/market/enrollGoodsDetails.do">
      상품번호
      <input type="text" class="form-control"  name="goodsNo" id="enr_goodsno"  readonly><br>
      상품이름
      <input type="text" class="form-control"  name="goodsName" id="enr_goodsname" readonly><br>
      카테고리1(색상)
        <select id="cate_color" class="form-control" name="color" required>
			<option value="" disabled selected>색상</option>
			<option value="RED">RED</option>
			<option value="ORANGE">ORANGE</option>
			<option value="YELLOW">YELLOW</option>
			<option value="GREEN">GREEN</option>
			<option value="BLUE">BLUE</option>
			<option value="PURPLE">PURPLE</option>
			<option value="BEIGE">BEIGE</option>
			<option value="GRAY">GRAY</option>
			<option value="BLACK">BLACK</option>
			<option value="WHITE">WHITE</option>
			<option value="PINK">PINK</option>
			<option value="BROWN">BROWN</option>
			<option value="IVORY">IVORY</option>
		</select>
		<br>
		<span id="cate_size_text">카테고리2(사이즈)</span>
        <select id="cate_size" class="form-control" name="size" required>
			<option value="" disabled selected>사이즈</option>
			<option value="1.XS">1.XS</option>
			<option value="2.S">2.S</option>
			<option value="3.M">3.M</option>
			<option value="4.L">4.L</option>
			<option value="5.XL">5.XL</option>
		</select>
		<br>
	  <span id="enr_invencount_text">재고수량</span>
      <input type="number" class="form-control"  placeholder="수량" name="invenCount" id="enr_invencount" required><br>
      <span id="enr_price_text">가격</span>
      <input type="number" class="form-control"  placeholder="가격" name="price" id="enr_price" required><br>
      </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="$('#enrGoodsDetailsFrm').submit();">등록</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>


<!-- 상품 삭제  -->
<div class="modal fade" id="deleteGoods" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">상품삭제</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="text-align:center;">
        삭제하시겠습니까?
        <br>
        <span style="color:red;">(해당상품 삭제시 등록된 재고가 모두 삭제됩니다)</span>
        <br>
        <br>
        상품코드<input type="text"  id="de_gno_text" name="delgoodsno" class="form-control"   value="" readonly><br>
        상품명<input type="text" id="de_gname_text" name="delgoodsname" class="form-control"   value="" readonly><br>
        <form id="delTitleGood" action="${path}/market/deleteTitleGood.do">
        <input type="hidden" id="de_gno_" name="goodsNo" value="">
        <input type="hidden" id="de_gname_" name="goodsName" value="">
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="$('#delTitleGood').submit();">삭제</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

<script>

$(document).on("click", "#updateGoodImageBtn", function () { 
	$("#lab_img").text("");
	$("#image_section").attr("src", "${path}/resources/images/market/add-image.PNG");
	let goodNo = $(this).data('gno');
	let goodName = $(this).data('gname');
	let img = $(this).data('img');
	console.log(img);
	$('#img_gno').val(goodNo);
	$('#img_gname').val(goodName);
	if(img != undefined){
		$("#image_section").attr("src", "${path}/resources/upload/market/"+img);
		$("#lab_img").text("기존 등록된 파일명 : "+img);
	}
	
});

$(document).on("click", "#enrollGoodDetailBtn", function () { 
	
	let goodNo = $(this).data('gno');
	let goodName = $(this).data('gname');
	
	$('#cate_size').hide();
	$('#cate_size_text').hide();
	$('#enr_invencount_text').hide();
	$('#enr_invencount').hide();
	$('#enr_price_text').hide();
	$('#enr_price').hide();
	$('#enr_goodsno').val(goodNo);
	$('#enr_goodsname').val(goodName);

});

$(document).ready(function () {
    $('#cate_color').change(function () {
    	$('#cate_size').show();
    	$('#cate_size_text').show();
    });
});

$(document).ready(function () {
    $('#cate_size').change(function () {
    	$.ajax({
    		url:"${path}/market/checkExistGoodDetail.do",
    		data:{goodsNo:$("#enr_goodsno").val(),goodsName:$("#enr_goodsname").val(),
    			color:$("#cate_color").val(),size:$("#cate_size").val()}, //키:벨류 형식으로 데이터를 전송한다
    		success:data=>{
    			if(data==0){
    				alert('해당 조건으로 상품 등록 가능합니다.');
    				$('#enr_invencount_text').show();
    				$('#enr_invencount').show();
    				$('#enr_price_text').show();
    				$('#enr_price').show();
    			}else{
    				alert('해당 조건의 상품은 등록되어있습니다.');
    			}			
    		}	
    	});	
    });
});


$(document).on("click", "#enrollGoodBtn", function () { 
	
	$('#cate_large').hide();
	$('#cate_middle').hide();

});


const duplicategoodsName=()=>{
	$.ajax({
		url:"${path}/market/checkExistGoodName.do",
		data:{goodsName:$("#enr_goodsname_").val()}, //키:벨류 형식으로 데이터를 전송한다
		success:data=>{
			if(data==0){
				alert('해당 상품명 사용가능합니다.');
				$('#cate_large').show();
				$('#cate_middle').show();
			}else{
				alert('해당 상품명이 존재합니다.');
				$('#enr_goodsname_').focus();
			}			
		}	
	});	
}

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
	

	
	$(document).on("click", "#deleteTitleGoodBtn", function () { 
		
		let goodNo = $(this).data('gno');
		let goodName = $(this).data('gname');

		$('#de_gno_text').val(goodNo);
		$('#de_gname_text').val(goodName);
		
		$('#de_gno_').val(goodNo);
		$('#de_gname_').val(goodName);

	});
	
	
	$(document).on("click", "#enrollGoodDetailImageBtn", function () { 
		
		$("#car_img1").attr("src", "${path}/resources/images/market/add-image.PNG");
		$("#car_img2").attr("src", "${path}/resources/images/market/add-image.PNG");
		$("#car_img3").attr("src", "${path}/resources/images/market/add-image.PNG");
		
		let detImg=$(this).data('dlist');
		let goodNo = $(this).data('gno');
		let goodName = $(this).data('gname');

		$('#detailImg_gno').val(goodNo);
		$('#detailImg_gname').val(goodName);
		
	});
	
	
	$(document).on("click", "#updateGoodDetailImageBtn", function () { 
		
		$("#lab_img1").text("");
		$("#lab_img2").text("");
		$("#lab_img3").text("");
		$("#up_car_img1").attr("src", "${path}/resources/images/market/add-image.PNG");
		$("#up_car_img2").attr("src", "${path}/resources/images/market/add-image.PNG");
		$("#up_car_img3").attr("src", "${path}/resources/images/market/add-image.PNG");
		
		let detImg=$(this).data('dlist');
		let goodNo = $(this).data('gno');
		let goodName = $(this).data('gname');

		$('#up_detailImg_gno').val(goodNo);
		$('#up_detailImg_gname').val(goodName);
		
		if(detImg != undefined){
			$.ajax({
				url:"${path}/market/goodDetailImageList.do",
				data:{goodsName:goodName}, //키:벨류 형식으로 데이터를 전송한다
				success:data=>{
					if(data!=null){
						for(let i=0; i<data.length; i++){
							if(i==0){
								if(data[i].filePath==null){
									$("#lab_img1").text("기존 등록된 파일명 : 등록된 파일이 없습니다");
									$("#up_car_img1").attr("src", "${path}/resources/images/market/add-image.PNG");
								}else{
									$("#lab_img1").text("기존 등록된 파일명 : "+data[i].filePath);
									$("#up_car_img1").attr("src", "${path}/resources/upload/market/"+data[i].filePath);
								} 
								$("#imgNo1").val(data[i].imgNo);
							}else if(i==1){							
								if(data[i].filePath==null){
									$("#lab_img2").text("기존 등록된 파일명 : 등록된 파일이 없습니다");
									$("#up_car_img2").attr("src", "${path}/resources/images/market/add-image.PNG");
								}else{
									$("#lab_img2").text("기존 등록된 파일명 : "+data[i].filePath);
									$("#up_car_img2").attr("src", "${path}/resources/upload/market/"+data[i].filePath);
								} 
								$("#imgNo2").val(data[i].imgNo);
							}else if(i==2){
								if(data[i].filePath==null){
									$("#lab_img3").text("기존 등록된 파일명 : 등록된 파일이 없습니다");
									$("#up_car_img3").attr("src", "${path}/resources/images/market/add-image.PNG");
								}else{
									$("#lab_img3").text("기존 등록된 파일명 : "+data[i].filePath);
									$("#up_car_img3").attr("src", "${path}/resources/upload/market/"+data[i].filePath);
								} 
								$("#imgNo3").val(data[i].imgNo);
							}
						}
					}else{
						alert('실패');		
					}			
				}	
			});	
		} 

	});
	
	
	$("#up_imgInput1").change(function(){
		 let imgval=$('#imgNo1').val();
		 $('#up_imgNo1').val(imgval);
		});
	
	$("#up_imgInput2").change(function(){
		 let imgval=$('#imgNo2').val();
		 $('#up_imgNo2').val(imgval);
		});
	
	$("#up_imgInput3").change(function(){
		 let imgval=$('#imgNo3').val();
		 $('#up_imgNo3').val(imgval);
		});
	
	
	
	 
	// 이벤트를 바인딩해서 input에 파일이 올라올때 (input에 change를 트리거할때) 위의 함수를 this context로 실행
	$("#imgInput1").change(function(){
	   readURL1(this);
	});
	

	$("#imgInput2").change(function(){
	   readURL2(this);
	});
	

	$("#imgInput3").change(function(){
	   readURL3(this);
	});
	
	// 대표 이미지 등록시 이미지 파일 미리 보여주기 로직
	function readURL1(input) {
		 if (input.files && input.files[0]) {
		  var reader = new FileReader();
		  
		  reader.onload = function (e) {
		   $('#car_img1').attr('src', e.target.result);  
		  }
		  
		  reader.readAsDataURL(input.files[0]);
		  }
		}

	
	// 대표 이미지 등록시 이미지 파일 미리 보여주기 로직
	function readURL2(input) {
		 if (input.files && input.files[0]) {
		  var reader = new FileReader();
		  
		  reader.onload = function (e) {
		   $('#car_img2').attr('src', e.target.result);  
		  }
		  
		  reader.readAsDataURL(input.files[0]);
		  }
		}
	
	
	// 대표 이미지 등록시 이미지 파일 미리 보여주기 로직
	function readURL3(input) {
		 if (input.files && input.files[0]) {
		  var reader = new FileReader();
		  
		  reader.onload = function (e) {
		   $('#car_img3').attr('src', e.target.result);  
		  }
		  
		  reader.readAsDataURL(input.files[0]);
		  }
		}
		 

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
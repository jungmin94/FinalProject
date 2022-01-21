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
	<ul class="nav justify-content-center">
		<li class="nav-item">
		  <a class="nav-link active" aria-current="page" href="#">장바구니</a>
		</li>
		<li class="nav-item">
		  <a class="nav-link" href="#">나의 구매목록</a>
		</li>
		<li class="nav-item">
		  <a class="nav-link" href="#">나의 찜목록</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="#">리뷰관리</a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link" href="#">상품등록</a>
		  </li>
	  </ul>	

	  <br>
	<!-------------------------------------------검색창 ---------------------------------------------------------->

	  <div class="collapse" id="navbarToggleExternalContent">
		<div class="bg-white p-4">

	  <form>
		<div class="row mb-3">
		  <label for="inputEmail3" class="col-sm-2 col-form-label">상품명</label>
		  <div class="col-sm-10">
			<input type="search" class="form-control" id="inputGoodsName">
		  </div>
		</div>

		<fieldset class="row mb-3">
		  <legend class="col-form-label col-sm-2 pt-0">카테고리</legend>
		  <div class="col-sm-10">

			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="checkbox" id="gridCheck1">
			  <label class="form-check-label" for="gridCheck1">남성용</label>
			</div>

			<div class="form-check form-check-inline">
				<input class="form-check-input" type="checkbox" id="gridCheck2">
				<label class="form-check-label" for="gridCheck2">여성용</label>
			  </div>

			  <div class="form-check form-check-inline">
				<input class="form-check-input" type="checkbox" id="gridCheck3">
				<label class="form-check-label" for="gridCheck3">의류</label>
			  </div>

			  
			<div class="form-check form-check-inline">
				<input class="form-check-input" type="checkbox" id="gridCheck4">
				<label class="form-check-label" for="gridCheck4">기타(etc)</label>
			  </div>

		  </div>
		</fieldset>
		<div class="row mb-3">
		  <div class="col-sm-10 offset-sm-2">
			<select class="form-select form-select-sm" aria-label=".form-select-sm example">
				<option selected>의류 카테고리</option>
				<option value="">One</option>
				<option value="">Two</option>
				<option value="">Three</option>
			  </select>
		  </div>
		</div>
		<button type="submit" class="btn btn-primary">검색하기</button>
	  </form>

		</div>
	  </div>
	  <nav class="navbar navbar-light bg-secondary">
		<div class="container-fluid">
		  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		  </button>
		</div>
	  </nav>

	<br>
	<!-------------------------------------------홍보 표시 ---------------------------------------------------------->
	<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
		<div class="carousel-indicators">
		  <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		  <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
		  <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
		  <div class="carousel-item active">
			<img src="https://t1.daumcdn.net/cfile/tistory/24283C3858F778CA2E" class="d-block w-100" alt="..." style="height: 500px;">
			<div class="carousel-caption d-none d-md-block">
			  <h5>First slide label</h5>
			  <p>Some representative placeholder content for the first slide.</p>
			</div>
		  </div>
		  <div class="carousel-item">
			<img src="https://user-images.githubusercontent.com/74690464/141612037-afac1948-5ffe-4c62-96b0-0b7ee12c6f93.gif" class="d-block w-100" alt="..." style="height: 500px;">
			<div class="carousel-caption d-none d-md-block">
			  <h5>Second slide label</h5>
			  <p>Some representative placeholder content for the second slide.</p>
			</div>
		  </div>
		  <div class="carousel-item">
			<img src="https://www.urbanbrush.net/web/wp-content/uploads/edd/2021/06/urbanbrush-20210611102855770634.jpg" class="d-block w-100" alt="..." style="height: 500px;">
			<div class="carousel-caption d-none d-md-block">
			  <h5>Third slide label</h5>
			  <p>Some representative placeholder content for the third slide.</p>
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
	  <!-------------------------------------------판매량 TOP3---------------------------------------------------------->
	  <div style="text-align: center;">
		<span class="badge bg-success">판매량 TOP 3</span>
	  </div>
		<br>
		<div class="row" style="text-align: center;">
			<div class="col">
					
			</div>
			  <div class="col">
				<div class="card" style="width: 18rem;">
					<img src="https://item.kakaocdn.net/do/5440669192e9c89cb7e42a6ba33df547960f4ab09fe6e38bae8c63030c9b37f9" class="card-img-top" alt="..." style="height: 170px;">
					<div class="card-body">
					  <h5 class="card-title">Card title</h5>
					  <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					  <a href="#" class="btn btn-primary">Go somewhere</a>
					</div>
				  </div>
			  </div>
			  <div class="col">
				<div class="card" style="width: 18rem;">
					<img src="https://item.kakaocdn.net/do/5440669192e9c89cb7e42a6ba33df547960f4ab09fe6e38bae8c63030c9b37f9" class="card-img-top" alt="..." style="height: 170px;">
					<div class="card-body">
					  <h5 class="card-title">Card title</h5>
					  <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					  <a href="#" class="btn btn-primary">Go somewhere</a>
					</div>
				  </div>
			  </div>
			  <div class="col">
				<div class="card" style="width: 18rem;">
					<img src="https://item.kakaocdn.net/do/5440669192e9c89cb7e42a6ba33df547960f4ab09fe6e38bae8c63030c9b37f9" class="card-img-top" alt="..." style="height: 170px;">
					<div class="card-body">
					  <h5 class="card-title">Card title</h5>
					  <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					  <a href="#" class="btn btn-primary">Go somewhere</a>
					</div>
				  </div>
			  </div>
			<div class="col">
					
			</div>
		</div>	 
		
		<br>
		<br>
		<!-------------------------------------------리뷰수 TOP3---------------------------------------------------------->
		<div style="text-align: center;">
		  <span class="badge bg-warning">리뷰수 TOP 3</span>
		</div>
		  <br>
		  <br>
		  <div class="row" style="text-align: center;">
			<div class="col">
				
			  </div>
			<div class="col">
			  <div class="card" style="width: 18rem;">
				  <img src="https://item.kakaocdn.net/do/5440669192e9c89cb7e42a6ba33df547960f4ab09fe6e38bae8c63030c9b37f9" class="card-img-top" alt="..." style="height: 170px;">
				  <div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					<a href="#" class="btn btn-primary">Go somewhere</a>
				  </div>
				</div>
			</div>
			<div class="col">
			  <div class="card" style="width: 18rem;">
				  <img src="https://item.kakaocdn.net/do/5440669192e9c89cb7e42a6ba33df547960f4ab09fe6e38bae8c63030c9b37f9" class="card-img-top" alt="..." style="height: 170px;">
				  <div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					<a href="#" class="btn btn-primary">Go somewhere</a>
				  </div>
				</div>
			</div>
			<div class="col">
			  <div class="card" style="width: 18rem;">
				  <img src="https://item.kakaocdn.net/do/5440669192e9c89cb7e42a6ba33df547960f4ab09fe6e38bae8c63030c9b37f9" class="card-img-top" alt="..." style="height: 170px;">
				  <div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					<a href="#" class="btn btn-primary">Go somewhere</a>
				  </div>
				</div>
			</div>
			<div class="col">	
			  
			  </div>
		  </div>
			<br>
			<br>
		<!-------------------------------------------전체상품 보러가기---------------------------------------------------------->
		<div class="d-grid gap-2">
			<button class="btn btn-secondary" type="button">전체상품 보러가기</button>
		</div>
			<br>
		</div>
	</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
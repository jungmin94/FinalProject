<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	  <div class="collapse" id="navbarToggleExternalContent">
		<div class="bg-white p-4">

	  <form action="${pageContext.request.contextPath}/market/searchList.do" method="post">
		<div class="row mb-3">
		  <label for="inputEmail3" class="col-sm-2 col-form-label">상품명</label>
		  <div class="col-sm-10">
			<input type="search" class="form-control" id="inputGoodsName" name="goodsName">
		  </div>
		</div>

		<fieldset class="row mb-3">
		  <legend class="col-form-label col-sm-2 pt-0">카테고리</legend>
		  <div class="col-sm-10">

			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="checkbox" id="gridCheck1" name="male" value="M">
			  <label class="form-check-label" for="gridCheck1">남성용</label>
			</div>

			<div class="form-check form-check-inline">
				<input class="form-check-input" type="checkbox" id="gridCheck2" name="female" value="F">
				<label class="form-check-label" for="gridCheck2">여성용</label>
			  </div>

			  <div class="form-check form-check-inline">
				<input class="form-check-input" type="checkbox" id="gridCheck3" name="top" value="반팔">
				<label class="form-check-label" for="gridCheck3">반팔</label>
			  </div>

			  
			<div class="form-check form-check-inline">
				<input class="form-check-input" type="checkbox" id="gridCheck4" name="pants" value="긴팔">
				<label class="form-check-label" for="gridCheck4">긴팔</label>
			  </div>

		  </div>
		</fieldset>
		
		<button type="submit" class="btn btn-primary">검색하기</button>
	  </form>

		</div>
	  </div>
	  <nav class="navbar navbar-light bg-light">
		<div class="container-fluid">
		  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		  </button>
		</div>
	  </nav>
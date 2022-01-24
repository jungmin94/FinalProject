<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
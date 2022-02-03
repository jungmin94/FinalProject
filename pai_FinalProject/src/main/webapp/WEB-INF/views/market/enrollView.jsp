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
  				등록
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
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
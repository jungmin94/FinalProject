<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
.star-ratings {
  color: #aaa9a9; 
  position: relative;
  unicode-bidi: bidi-override;
  width: max-content;
  -webkit-text-fill-color: transparent; 
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
	<!-------------------------------------------홍보 표시 ---------------------------------------------------------->
	<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
		<div class="carousel-indicators">
		  <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		  <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
		  <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
		  <div class="carousel-item active">
			<img src="${path}/resources/images/market/마켓설명1.PNG" class="d-block w-100" alt="..." style="height: 500px;">
			<div class="carousel-caption d-none d-md-block">
			<button class="btn btn-warning" type="button"  onclick="location.assign('${path}/market/goodsList.do')">전체상품 보러가기</button>
			</div>
		  </div>
		  <div class="carousel-item">
			<img src="${path}/resources/images/market/메인캐러셀2.PNG" class="d-block w-100" alt="..." style="height: 500px;">
			<div class="carousel-caption d-none d-md-block">
			<button class="btn btn-warning" type="button"  onclick="location.assign('${path}/market/goodsList.do')">전체상품 보러가기</button>
			</div>
		  </div>
		  <div class="carousel-item">
			<img src="${path}/resources/images/market/메인캐러셀1.PNG" class="d-block w-100" alt="..." style="height: 500px;">
			<div class="carousel-caption d-none d-md-block">
			<button class="btn btn-warning" type="button"  onclick="location.assign('${path}/market/goodsList.do')">전체상품 보러가기</button>
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
			<c:forEach items="${topSellList}" var="s">
			  <div class="col">
				<div class="card" style="width: 18rem;">
					<c:if test="${s.image eq null}">
						<img src="${path}/resources/images/market/이미지준비중.PNG" class="card-img-top" alt="..." style="height: 170px;">
					</c:if>
					<c:if test="${s.image ne null}">
						<img src="${path}/resources/upload/market/${s.image}" class="card-img-top" alt="..." style="height: 170px;">
					</c:if>
					<div class="card-body">
					  <h5 class="card-title">${s.goodsName}</h5>
					  <p class="card-text"><fmt:formatNumber  value="${s.minPrice}"  type="currency"/>원</p>
					  <span style="color:purple;">(총 판매량 : ${s.totalCell})</span>
					  <div class="star-ratings" >
						<div class="star-ratings-fill space-x-2 text-lg" >
							&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							<c:choose>
								<c:when test="${s.avgGrade==1}"><span>★</span></c:when>
								<c:when test="${s.avgGrade==2}"><span>★</span><span>★</span></c:when>
								<c:when test="${s.avgGrade==3}"><span>★</span><span>★</span><span>★</span></c:when>
								<c:when test="${s.avgGrade==4}"><span>★</span><span>★</span><span>★</span><span>★</span></c:when>
								<c:when test="${s.avgGrade==5}"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></c:when>
							</c:choose>
						</div>
						<div class="star-ratings-base space-x-2 text-lg">
							&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
						</div>
					</div>
					<br>
					  <a href="${path}/market/goodsDetailView.do?goodsName=${s.goodsName}" class="btn btn-primary">상품 보러가기</a>
					</div>
				  </div>
			  </div>
			  </c:forEach>
			<div class="col">
					
			</div>
		</div>	 
		
		<br>
		<br>
		<!-------------------------------------------평점 TOP3---------------------------------------------------------->
		<div style="text-align: center;">
		  <span class="badge bg-warning">평점 TOP 3</span>
		</div>
		<br>
		<div class="row" style="text-align: center;">
			<div class="col">
					
			</div>
			<c:forEach items="${topGradeList}" var="g">
			  <div class="col">
				<div class="card" style="width: 18rem;">
					<c:if test="${g.image eq null}">
						<img src="${path}/resources/images/market/이미지준비중.PNG" class="card-img-top" alt="..." style="height: 170px;">
					</c:if>
					<c:if test="${g.image ne null}">
						<img src="${path}/resources/upload/market/${g.image}" class="card-img-top" alt="..." style="height: 170px;">
					</c:if>
					<div class="card-body">
					  <h5 class="card-title">${g.goodsName}</h5>
					  <p class="card-text"><fmt:formatNumber  value="${g.minPrice}"  type="currency"/>원</p>
					  <div class="star-ratings" >
						<div class="star-ratings-fill space-x-2 text-lg" >
							&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							<c:choose>
								<c:when test="${g.avgGrade==1}"><span>★</span></c:when>
								<c:when test="${g.avgGrade==2}"><span>★</span><span>★</span></c:when>
								<c:when test="${g.avgGrade==3}"><span>★</span><span>★</span><span>★</span></c:when>
								<c:when test="${g.avgGrade==4}"><span>★</span><span>★</span><span>★</span><span>★</span></c:when>
								<c:when test="${g.avgGrade==5}"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></c:when>
							</c:choose>
						</div>
						<div class="star-ratings-base space-x-2 text-lg">
							&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
						</div>
					</div>
					<br>
					  <a href="${path}/market/goodsDetailView.do?goodsName=${g.goodsName}" class="btn btn-primary">상품 보러가기</a>
					</div>
				  </div>
			  </div>
			  </c:forEach>
			<div class="col">
					
			</div>
		</div>	 
		
		<br>
		<br>
		<!-------------------------------------------전체상품 보러가기---------------------------------------------------------->
		<div class="d-grid gap-2">
			<button class="btn btn-secondary" type="button" 
			onclick="location.assign('${path}/market/goodsList.do')">전체상품 보러가기</button>
		</div>
			<br>
		</div>
	</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
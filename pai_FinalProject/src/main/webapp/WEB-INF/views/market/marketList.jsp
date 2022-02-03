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

<!-- 전체 리스트 출력 -->
	<div class="row row-cols-1 row-cols-md-4 g-4" style="text-align: center;">
	<!-- for문으로 복사해서 출력 -->
			<c:forEach items="${goodsList}" var="g">
			  <div class="col">
				<div class="card" style="width: 18rem;">
					<c:if test="${g.image eq null}">
						<img src="${path}/resources/images/market/이미지준비중.jpg" class="card-img-top" alt="..." style="height: 170px;">
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
	  	
	</div>
	<br>
	<br>
	<div style="text-align:center;">
		${pageBar}
	</div>
	<br>

</div>

</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
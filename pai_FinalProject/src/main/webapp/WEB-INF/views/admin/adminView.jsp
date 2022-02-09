<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> 
<style>
	.nav-link{
		font-size:30px;
		bolder:1px gray solid;
	}
	.admin{
		font-size:50px;
		font-weight:bolder;
		text-align:center;
		background-color:cornflowerblue;
	}
	.text{ 
		height:800px;
		border-left: lightGray 2px solid;
	}
</style>
<section>
	<div class="container">
		<div class="admin">
			회원관리
		</div>
	
		<div class="row" style="margin-top:50px;"> 
			<div class="navi col-2"> 
				<ul class="nav flex-column">
				  <li class="nav-item">
				    <a class="nav-link active" aria-current="page" href="${path}/admin/adminView.do">홈</a>
				  </li>
				  <li class="nav-item dropdown">
			          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
			            신고내역
			          </a>
			          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
			            <li><a class="dropdown-item" href="${path}/admin/declareAdminView.do">게시글신고</a></li>
			            <li><a class="dropdown-item" href="${path}/admin/commentDeclare.do">댓글신고</a></li> 
			          </ul>
			        </li> 
				  <li class="nav-item">
				    <a class="nav-link" href="#">Link</a>
				  </li> 
				</ul>
			</div>
			<div class="col text">
				메인화면
			</div>
		</div>
		
		
		
		
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
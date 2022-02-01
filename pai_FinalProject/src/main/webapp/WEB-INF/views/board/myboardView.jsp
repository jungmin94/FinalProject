<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> 
<style>
	.main-top{
		height:150px;
		background-color:cornflowerblue; 
	} 
	.nav{
		width:300px;
		margin-top:50px;
	} 
	.nav-link{
		margin-bottom:10px;
		font-size:25px;
	}
	.title{
		font-size:25px;
		font-weight:bolder; 
	}
</style>

<section>
	<div class="container">
		<div class="main-top">
			 <div class="row">
			    <div class="col-2" style="margin-left:30px; width:180px;" >
			      <img src="${path}/resources/images/board/profile.png" style="width:150px;height:130px;margin-top:10px;">
			    </div>
			    <div class="col-3" style="background-color:gray; margin-top:50px;height:40px;">
					<span style="color:yellow; font-size:20px;">${loginMember.member_nick}</span>
					<span style="color:white;">님의 공간입니다</span> 
			    </div>
			    <div class="col"> 
			    </div>
			  </div>
		</div>
		
		<div class="d-flex align-items-start">
		  <div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
		    <button class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">홈</button>
		    <button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">게시글</button>
		    <button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">댓글</button>
		    <button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">신고내역	</button>
		  </div>
		  <div class="tab-content" id="v-pills-tabContent">
		    <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
		    	<div class="title">게시글 일부공개</div>
		    	<div>게시글</div>
		    	<div class="title">댓글 일부공개</div>
		    	<div>댓글</div>
		    </div>
		    
		    <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
		   		<div class="title">전체게시글</div>
		    	<div>게시글</div>
		    	<div>페이지바</div>
		    </div>
		    
		    <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
		    	<div class="title">전체댓글</div>
		    	<div>게시글</div>
		    	<div>페이지바</div>
		    </div>
		    
		    <div class="tab-pane fade" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
		   		 <div class="title">신고접수내역</div>
		   		 <div>리스트</div>
		   		 <div>페이지바</div>
		    </div>
		  </div>
		</div>
	
	
	
	
	
	
	
	
	 
	
	
	
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> 
<%@ page import="com.pai.spring.board.model.vo.Board,java.util.List" %>
<%
	List<Board> declareList=(List)request.getAttribute("declareList");
%>
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
					<span style="color:yellow; font-size:20px;">${member.member_nick}</span>
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
		    <c:if test="${loginMember!=null&&loginMember.member_id eq member.member_id }"> 
		    	<button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">신고내역	</button>
		  	</c:if>
		  </div>
		  <div class="tab-content" id="v-pills-tabContent">
		    <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
		    	<div class="title">게시글 일부공개(10)</div>
		    	<c:if test="${list.size()<=0}">
		    		등록된 게시글이 없습니다.
		    	</c:if>
		    	<c:forEach var="b" items="${list}">  
			    	<div class="row" style="border-bottom:gray 1px solid;width:950px; height:30px;"> 
				    	<div class="col-9"style="margin-left:30px;">
				    		<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${b.boardNo}&memberId=${b.boardWriter.member_id}"><c:out value="${b.boardTitle}"/></a></div>
				    	<div class="col"  >
				    		<span style="font-weight:bolder;font-size:16px;"><c:out value="${b.boardWriter.member_nick}"/></span>
				    		<span style="font-size:12px;"><c:out value="${b.boardEnrollDate}"/></span>
				    	</div>
			    	</div> 
		    	</c:forEach>
		     	<div class="title" style="margin-top:20px;">댓글 일부공개(10)</div> 
		     	<c:if test="${comments.size()<=0}">
		    		<p style="margin-top:20px;font-size:13px;">등록된 댓글이 없습니다.</p>
		    	</c:if>
		    	<c:forEach var="c" items="${comments}">
		    		<div class="row" style="border-bottom:gray 1px solid;width:950px; height:30px;"> 
				    	<div class="col-9"  style="margin-left:30px;">
				    		<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${c.boardRef}&memberId=${c.commentWriter}"><c:out value="${c.commentContent}"/></a>
				    	</div>
				    	<div class="col"  >
				    		<span style="font-weight:bolder;font-size:16px;"><c:out value="${c.commentWriter}"/></span>
				    		<span style="font-size:12px;"><c:out value="${c.commentDate	}"/></span>
				    	</div>
			    	</div> 
		    		   
		    	</c:forEach>
		    	 
		    </div>
		    
		    
		    <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
		   		<div class="title" style="margin-bottom:20px;">전체게시글</div>
		    	<div>
		    		<c:if test="${listAll.size()<=0}">
		    		등록된 게시글이 없습니다.
		    		</c:if>
		    		<c:forEach var="b" items="${listAll}">
		    			<div class="row" style="border-bottom:gray 1px solid;width:950px; height:30px;"> 
				    	<div class="col-9"style="margin-left:30px;">
				    		<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${b.boardNo}&memberId=${b.boardWriter.member_id}"><c:out value="${b.boardTitle}"/></a></div>
				    	<div class="col"  >
				    		<span style="font-weight:bolder;font-size:16px;"><c:out value="${b.boardWriter.member_nick}"/></span>
				    		<span style="font-size:12px;"><c:out value="${b.boardEnrollDate}"/></span>
				    	</div>
			    		</div>  
		    		</c:forEach>
		    	</div>
		    	<div style="margin-top:20px;">${pageBar}</div>
		    </div>
		    
		    <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
		    	<div class="title"  style="margin-bottom:20px;">전체댓글</div> 
		    	<div>
		    		<c:if test="${commentAll.size()<=0}">
		    		등록된 댓글 없습니다.
		    		</c:if>
		    		<c:forEach var="c" items="${commentAll}">
		    			<div class="row" style="border-bottom:gray 1px solid;width:950px; height:30px;"> 
				    	<div class="col-9"style="margin-left:30px;">
				    		<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${c.boardRef}&memberId=null"><c:out value="${c.commentContent}"/></a></div>
				    	<div class="col"  >
				    		<span style="font-weight:bolder;font-size:16px;"><c:out value="${c.commentWriter}"/></span>
				    		<span style="font-size:12px;"><c:out value="${c.commentDate}"/></span>
				    	</div>
			    		</div>  
		    		</c:forEach>
		    	</div>
		    	<div style="margin-top:20px;">${pageBar2}</div>
		    </div>
		    
		    <!-- 자신페이지에만 신고접수내역이 보임  -->
	 
			    <div class="tab-pane fade" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
			   		 <div class="title" style="border-bottom:black 2px solid;" >신고접수내역</div> 
			   		  <c:forEach var="d" items="${declareList}">
			   		  <div style="border-bottom:gray 2px solid;width:950px; height:70px; margin-bottom:10px;  ">
				   		 <div class="row" style="text-align:justify; margin-top:10px;" >
						    <div class="col">
						        ${d.declareContent }
						    </div>
						    <div class="col-2" style="width:150px;">
						      ${d.declareDate}
						    </div>
						    <div class="col-2">
						       <c:if test="${d.declareResult!=null}"> 
						      	 <button type="button" class="btn btn-outline-warning">처리완료</button>
						       </c:if>
						       <c:if test="${d.declareResult==null}"> 
						      	 <button type="button" class="btn btn-outline-secondary">처리중</button>
						       </c:if>
						    </div>
						  </div>
						 <div style="background-color:cornflowerblue;  width:300px ">
						 	<a style="text-decoration:none; color:white;" href="${path}/board/boardView.do?boardNo=${d.boardNo}&memberId=null">
						 		${d.boardTitle}
						 	</a>	
						 </div> 
					  </div>	 
			   		  </c:forEach> 
			   		 <div>${pageBar3}</div>
			    </div>
		     
		    
		  </div>
		</div>
	
	
	
	
	
	
	
	
	 
	
	
	
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
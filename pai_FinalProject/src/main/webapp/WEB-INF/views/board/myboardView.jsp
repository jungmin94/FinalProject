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
		    	<div class="title" style="border-bottom:black 2px solid;">게시글 일부공개(10)</div>
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
		     	<div class="title" style="margin-top:20px; border-bottom:black 2px solid;">댓글 일부공개(10)</div> 
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
		   		<div class="title" style=" border-bottom:black 2px solid;">전체게시글</div>
		    	<div>
		    		<c:if test="${listAll.size()<=0}">
		    		등록된 게시글이 없습니다.
		    		</c:if>
		    		<c:forEach var="b" items="${listAll}">
		    			<div class="row" style="border-bottom:lightGray 2px solid;width:950px; height:40px;"> 
				    	<div class="col-9"style="margin-left:30px; margin-top:10px;	">
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
		    	<div class="title"  style=" border-bottom:black 2px solid;" >전체댓글</div> 
		    	<div>
		    		<c:if test="${commentAll.size()<=0}">
		    		등록된 댓글 없습니다.
		    		</c:if>
		    		<c:forEach var="c" items="${commentAll}">
		    			<div class="row" style="border-bottom:lightGray 1px solid;width:950px; height:40px;"> 
				    	<div class="col-9"style="margin-left:30px; margin-top:10px;">
				    		<a style="text-decoration:none; color:black; " href="${path}/board/boardView.do?boardNo=${c.boardRef}&memberId=null"><c:out value="${c.commentContent}"/></a></div>
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
			   		
			   		<ul class="nav nav-tabs" id="myTab" role="tablist" style="margin-top:20px"> 
						  <li class="nav-item" role="presentation">
						    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">게시글</button>
						  </li>
						  <li class="nav-item" role="presentation">
						    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">댓글</button>
						  </li> 
					</ul>
					
					<div class="tab-content" id="myTabContent">
						  <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">  
					   		  <c:if test="${declareList.size()<=0}">
					   		  <div style="text-align:center; width:950px;"></div>
					   		 	신고접수내역이 없습니다.
					   		 </c:if>
					   		 <c:if test="${declareList.size()>0}"> 
					   		  <c:forEach var="d" items="${declareList}">
					   		  <div style="border-bottom:gray 2px solid;width:950px; height:65px; margin-bottom:10px;  ">
						   		 
						   		 <div class="row" style="text-align:justify; " >
								    <div class="col">
								        ${d.declareContent }
								    </div>
								    <div class="col-2" style="width:150px;">
								      ${d.declareDate}
								    </div>
								    <div class="col-2">
								       <c:if test="${d.declareResult!=null}"> 
								      	 <button type="button" class="btn btn-outline-warning" style="height:10px;">처리완료</button>
								       </c:if>
								       <c:if test="${d.declareResult==null}"> 
								      	 <button type="button" class="btn btn-outline-secondary" style="height:33px;">처리중</button>
								       </c:if>
								    </div>
								  </div>
								 <div style="background-color:cornflowerblue;   display: table; table-layout: fixed ;  ">
								 	<a style="text-decoration:none; color:white;" href="${path}/board/boardView.do?boardNo=${d.boardNo}&memberId=null">
								 		${d.boardTitle}
								 	</a>	
								 </div> 
							  </div>	
					   		  </c:forEach> 
					   		  <div>${pageBar3}</div>
							  </c:if>
						  </div>
						  
						  <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">  
					   		  <c:if test="${commentDeclareList.size()<=0}">
					   		  <div style="text-align:center; width:950px;"></div>
					   		 	신고접수내역이 없습니다.
					   		 </c:if>
					   		 <c:if test="${commentDeclareList.size()>0}"> 
					   		  <c:forEach var="cd" items="${commentDeclareList}">
					   		  <div style="border-bottom:gray 2px solid;width:950px; height:65px; margin-bottom:10px;  ">
						   		 
						   		 <div class="row" style="text-align:justify; " >
								    <div class="col">
								        ${cd.declareContent }
								    </div>
								    <div class="col-2" style="width:150px;">
								      ${cd.declareDate}
								    </div>
								    <div class="col-2">
								       <c:if test="${cd.declareResult!=null}"> 
								      	 <button type="button" class="btn btn-outline-warning" style="height:10px;">처리완료</button>
								       </c:if>
								       <c:if test="${cd.declareResult==null}"> 
								      	 <button type="button" class="btn btn-outline-secondary" style="height:33px;">처리중</button>
								       </c:if>
								    </div>
								  </div>
								 <div style="background-color:cornflowerblue;  display: table; table-layout: fixed ; ">
								 	<a style="text-decoration:none; color:white;" href="${path}/board/boardView.do?boardNo=${cd.boardNo}&memberId=null">
								 		${cd.commentContent}
								 	</a>	
								 </div> 
							  </div>	
					   		  </c:forEach> 
					   		  <div>${pageBar3}</div>
							  </c:if> 
						  </div> 
					</div>
					
					  
					  
					   
			    </div> 
		  </div>
		</div>
	
	
	
	
	
	
	
	
	 
	
	
	
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
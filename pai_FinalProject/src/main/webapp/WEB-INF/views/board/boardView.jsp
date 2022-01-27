<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> 
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ page import="com.pai.spring.board.model.vo.Board" %> 
<%
	Board b=(Board)request.getAttribute("board");
%>
<style>
section>*{
	 font-family: sans-serif;
}
.main>div{
	 font-weight: bold;
}
</style>
<section>
	<div class="container" style="margin-top:50px;"> 
	 <div class="row main" style="border-bottom:1px gray solid;">
	    <div class="col-1">
	      <h1 style="color:blue; font-family:fantasy">${board.boardCategory}</h1>
	    </div>
	    <div class="col-11">
	      <h1>${board.boardTitle}</h1>
	    </div>
	  </div>
	  
	    <div class="row" style="border-bottom:2px gray solid;">
		    <div class="col-1">
		      ${board.boardWriter.member_nick}
		    </div>
		    <div class="col-8">
		      ${board.boardEnrollDate }
		    </div>
		    <div class="col-1">
		      조회수 ${board.boardReadCount }
		    </div>
		    <div class="col-1">
		      추천수 ${board.recommendCount }
		    </div>
		    <div class="col-1">
		      댓글 0
		    </div>
	    </div>
	    
	    <!-- 첨부파일이 있으면 carousel이 보임 -->
	    <c:if test="${board.attachFile.size()>0}">
	    	<div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel" style="height:350px;">
			  <div class="carousel-indicators">
			   <%for(int i=0;i<b.getAttachFile().size();i++){%>
			    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="<%=i%>" class="active" aria-current="true" aria-label="Slide <%=i+1%>"></button>
			   <%} %>  
			  </div>
			  <div class="carousel-inner"> 
			    <div class="carousel-item active" data-bs-interval="10000">
			      <img style="height:350px;" src="${path}/resources/upload/board/${board.getAttachFile().get(0).getAttachFileName()}" class="d-block w-100" alt="...">
			    </div>
			    <%for(int i=1;i<b.getAttachFile().size();i++){%>
				    <div class="carousel-item" data-bs-interval="2000">
				      <img style="height:350px;" src="${path}/resources/upload/board/<%=b.getAttachFile().get(i).getAttachFileName()%>" class="d-block w-100" alt="...">
				    </div> 
			    <%} %> 
			    
			</div>
			  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Previous</span>
			  </button>
			  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Next</span>
			  </button>
			</div> 
	    </c:if>
	    
	   <!-- 게시글 내용 -->
		<div class="form-floating" style="margin-top:30px;">
		  <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 300px" readonly></textarea>
		  <label for="floatingTextarea2">${board.boardContent}</label>
		</div>
		
	   <!-- 신고&공유&추천버튼 -->	
	    
	  <div class="row justify-content-md-center" style="margin-top:30px; margin-left:400px; margin-right:400px;">
	        <div class="btn-group" role="group" aria-label="Third group">
	        	<button type="button" class="btn btn-danger">
	      			<img style="height:15px; width:15px;"src="${path}/resources/images/board/siren.png">&nbsp;신고
	      		</button>
	        	<button type="button" class="btn btn-info">
					<img style="height:15px; width:15px;"src="${path}/resources/images/board/share.png">&nbsp;공유
   		  		</button>
			    <button type="button" class="btn btn-info">
			    	<img style="height:20px; width:20px;"src="${path}/resources/images/board/recommended.png">&nbsp;추천
			    </button>
			    <button type="button" class="btn btn-info">8명</button>
		    </div>
	  </div>  
	    
	    
	    
	   <!-- 댓글 -->
	    
	    
	    
	   <!-- 이전글/다음글/글쓰기 버튼 -->
	     <div class="row" style="border-top:2px gray solid; margin-top:20px;">
		    <div class="col" style="margin-top:10px;" >
		       <div class="d-grid gap-2 d-md-block"  >
				  <button class="btn btn-primary" id="before" type="button" onclick="before();">이전글</button>
				  <button class="btn btn-primary" type="button" onclick="after();">다음글</button>
				</div>
		    </div>
		    <div class="col-1" style="margin-top:10px; padding:0px;" >
		       <button class="btn btn-primary" type="button" onclick="location.assign('${path}/board/boardList.do')">전체목록</button>
		    </div>
		  </div> 	   
	</div>
</section>

<script>
	const before=()=>{ 
		$.ajax({
			url:"${path}/board/ajax/boardView.do",
			data:{boardNo:${board.boardNo-1}},
			success:data=>{
				console.log(data);
				if(data){
					alert('이전글이 없습니다');
				}else{
					location.assign('${path}/board/boardView.do?boardNo='+${board.boardNo-1}); 
				} 
			}		
		})
	}
	
	const after=()=>{ 
		$.ajax({
			url:"${path}/board/ajax/boardView.do",
			data:{boardNo:${board.boardNo+1}},
			success:data=>{
				console.log(data);
				if(data){
					alert('현재 게시글이 마지막 글입니다!');
				}else{
					location.assign('${path}/board/boardView.do?boardNo='+${board.boardNo+1}); 
				} 
			}		
		})
	}
	
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
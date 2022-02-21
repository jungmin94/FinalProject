<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> 
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	section{
		margin: 0px auto;
		padding-top: 100px;
	}
	.col-12{
		display: inline-flex; 
		border-bottom:gray 1px solid;
		margin-top:20px; 
		margin-bottom:10px;
		padding-bottom: 20px;
	} 
    div#board-container{width:900px; margin:0 auto; text-align:center;}
    div#board-container input{margin-bottom:15px;}
</style>
<section>
	<div class="container" id="board-container">
		<%-- <form action="${path}/board/insertBoardEnd.do" method="post" enctype="multipart/form-data">  --%>
			  <div style="border-bottom: black solid 3px">
		       		 <label for="enrollTitle" class="enrollTitle"><h1>수정하기</h1></label>
		      </div>
			  <div class="col-12" >
			      <label class="form-label" style="width:100px;">제목</label>
			      <input type="text" class="form-control" name="boardTitle" id="boardTitle" value="${board.boardTitle}"> 
		      </div>
		      <div class="col-12" >
			      <label class="form-label" style="width:100px;">카테고리</label>
		      <!-- 관리자일땐 카테고리 정보 or 공지만 보임 -->
		      <c:if test="${loginMember!=null&&loginMember.member_id eq 'admin'}">
			  	  <label><input type="radio" id="category" name="boardCategory"  value="NOTICE">공지</label>
			  	  <label><input type="radio" id="category" name="boardCategory"  value="INFO">정보</label>
			  </c:if>	
		      <c:if test="${loginMember.member_id ne 'admin'}"> 
				  <label><input type="radio" id="category" name="boardCategory"  value="INTJ" ${board.boardCategory eq "INTJ"?"checked":""}>INTJ</label>		     
				  <label><input type="radio" id="category" name="boardCategory"  value="INTP" ${board.boardCategory eq "INTP"?"checked":""}>INTP</label>		     
				  <label><input type="radio" id="category" name="boardCategory"  value="ENTJ" ${board.boardCategory eq "ENTJ"?"checked":""}>ENTJ</label>		     
				  <label><input type="radio" id="category" name="boardCategory"  value="ENTP" ${board.boardCategory eq "ENTP"?"checked":""}>ENTP</label>		     
				  <label><input type="radio" id="category" name="boardCategory"  value="INFJ" ${board.boardCategory eq "INFJ"?"checked":""}>INFJ</label>		     
				  <label><input type="radio" id="category" name="boardCategory"  value="INFP" ${board.boardCategory eq "INFP"?"checked":""}>INFP</label>		     
				  <label><input type="radio" id="category" name="boardCategory"  value="ENFJ" ${board.boardCategory eq "ENFJ"?"checked":""}>ENFJ</label> 		     
				  <label><input type="radio" id="category" name="boardCategory"  value="ENFP" ${board.boardCategory eq "ENFP"?"checked":""}>ENFP</label> 		     
				  <label><input type="radio" id="category" name="boardCategory"  value="ISTJ" ${board.boardCategory eq "ISTJ"?"checked":""}>ISTJ</label>		     
				  <label><input type="radio" id="category" name="boardCategory"  value="ISFJ" ${board.boardCategory eq "ISFJ"?"checked":""}>ISFJ</label>		     
				  <label><input type="radio" id="category" name="boardCategory"  value="ESTJ" ${board.boardCategory eq "ESTJ"?"checked":""}>ESTJ</label>		     
				  <label><input type="radio" id="category" name="boardCategory"  value="ESFJ" ${board.boardCategory eq "ESFJ"?"checked":""}>ESFJ</label>		     
				  <label><input type="radio" id="category" name="boardCategory"  value="ISTP" ${board.boardCategory eq "ISTP"?"checked":""}>ISTP</label>		     
				  <label><input type="radio" id="category" name="boardCategory"  value="ISFP" ${board.boardCategory eq "ISFP"?"checked":""}>ISFP</label>		     
				  <label><input type="radio" id="category" name="boardCategory"  value="ESTP" ${board.boardCategory eq "ESTP"?"checked":""}>ESTP</label>		     
				  <label><input type="radio" id="category" name="boardCategory"  value="ESFP" ${board.boardCategory eq "ESFP"?"checked":""}>ESFP</label>		     
				  <label><input type="radio" id="category" name="boardCategory"  value="INFO" ${board.boardCategory eq "INFO"?"checked":""}>정보</label>
			  </c:if>  		     
		      </div> 
		       <div class="col-12"  >
			      <label class="form-label" style="width:100px;">닉네임</label>
			      <input type="text" class="form-control" name="boardWriter" id="boardWriter" value="${loginMember.member_nick}" readonly> 
		       </div>
		       <div class="col-12" style="display:inline-block;"  >
		       	  <div class="row">
				    <div class="col-2">
				        <label class="form-label" style="width:100px;">파일첨부</label>
				    </div>
				    <div class="col"> 
				    	<input type="file" class="form-control" name="attachFile" id="upload" multiple>				 
				    </div> 
				  </div>  
				  
				  <!-- 첨부된 파일명 보임 -->
			      <div style="display:inline-block;" id="upFiles"> 
				      <c:if test="${not empty board.attachFile}">
					      <c:forEach var="b" items="${board.attachFile}"> 
					      	<button type="button" class="btn btn-outline-primary" name="files"><c:out value="${b.attachFileName}"/></button> 
					      </c:forEach>
				      </c:if>
			      </div>
			      
		       </div>
		   
		        <div class="col-12" style="display:inline-block;" >
		          <label style="font-weight: bolder;">사전경고안내</label><br>
			      <p style="text-align:center;">
						정보통신망에서 불법촬영물등을 유통할 경우「전기통신사업법」 제22조의 5 제1항에 따른 삭제·접속차단 등 유통방지에 필요한 조치가 취해지며
						「성폭력처벌법」 제14조 「청소년성보호법」 제11조에 따라 형사처벌을 받을 수 있습니다.
			      </p> 
		        </div>
		        <div class="col-12">
				  <label class="form-label" style="width:100px;">내용</label>
				  <textarea class="form-control" id="boardContent" rows="3">${board.boardContent}</textarea>
				</div>
				<div>
					<input type="hidden" id="memberId" value="${loginMember.member_id}">
					<input type="hidden" id="boardNo" value="${board.boardNo}">
				</div>
				<button id="submit" class="btn btn-primary btn-lg">수정</button>
				<button type="reset" class="btn btn-secondary btn-lg">취소</button> 
		<!-- </form> -->
	</div>
</section>

<script>
/*	$(()=>{
		$("button[name=files]").click(e=>{
			$(e.target).remove();
		})
	}) 
	
	 
$("#upFiles").change(e=>{ 
			const fileInput=$("input[name=attachFile]");
			if(fileInput[0].files.length>0){
				for(let i=0;i<fileInput[0].length;i++){
					 $("#upFiles").append("<button type="button" class="btn btn-outline-primary" name="files"></button>);
				}
			} 
		})
	 
 	 
 */

	$("#submit").click(e=>{
		const frm=new FormData();
		const fileInput=$("input[name=attachFile]");
		
		if(fileInput[0].files.length>0){
			for(let i=0;i<fileInput[0].files.length;i++){
				frm.append("upFile",fileInput[0].files[i]);
			}
			/* frm.append("upFile",${board.attachFileName}) */
		}
		
		/* if(${board.attachFile}.size()>0){
			for(let i=0;i<${board.attachFile}.size;i++){}
			console.log()
		} */
		
		
		const title=$("#boardTitle").val().trim();
		if(title.length<1){
			alert("제목을 입력해주세요!");
		}
		
		const category=$("input[name=boardCategory]:checked").val().trim(); 
		console.log(category);
		if(category.length<1){
			alert("카테고리를 선택해주세요!");
		}
		
		
		frm.append("boardTitle",title);
		frm.append("boardCategory",category);
		frm.append("boardContent",$("#boardContent").val());
		frm.append("memberId",$("#memberId").val());
		frm.append("boardNo",$("#boardNo").val());
		
		$.ajax({
			url:"${path}/board/updateBoardEnd.do",
			type:"post",
			data:frm,
			processData:false,
			contentType:false,
			success:data=>{
				console.log(data);
				if(data){
					alert("성공적으로 게시물이 수정되었습니다!");
					location.replace('${path}/board/boardList.do'); 
				}else{
					alert("게시물이 수정에 실패하였습니다!");
					location.replace('${path}/board/boardList.do'); 
				}
			}
			
		})
	    
		
		
		
	})	
	



</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> 
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
		<form action="">
		  <div style="border-bottom: black solid 3px">
	       		 <label for="enrollTitle" class="enrollTitle"><h1>기본정보</h1></label>
	      </div>
		  <div class="col-12" >
		      <label class="form-label" style="width:100px;">제목</label>
		      <input type="text" class="form-control" name="boardTitle" id="inputTitle" placeholder="제목을 입력해주세요."> 
	      </div>
	      <div class="col-12" >
		      <label class="form-label" style="width:100px;">카테고리</label>
	      <!-- 관리자일땐 카테고리 정보 or 공지만 보임 -->
	      <c:if test="${loginMember!=null&&loginMember.userId eq 'admin'}">
		  	  <label><input type="radio" id="category" name="category"  value="notice">공지</label>
		  	  <label><input type="radio" id="category" name="category"  value="info">정보</label>
		  </c:if>	
	      <c:if test="${loginMember.userId ne 'admin'}"> 
			  <label><input type="radio" id="category" name="category" value="INTJ">INTJ</label>		     
			  <label><input type="radio" id="category" name="category"  value="INTP">INTP</label>		     
			  <label><input type="radio" id="category" name="category"  value="ENTJ">ENTJ</label>		     
			  <label><input type="radio" id="category" name="category"  value="ENTP">ENTP</label>		     
			  <label><input type="radio" id="category" name="category"  value="INFJ">INFJ</label>		     
			  <label><input type="radio" id="category" name="category"  value="INFP">INFP</label>		     
			  <label><input type="radio" id="category" name="category"  value="ENFJ">ENFJ</label> 		     
			  <label><input type="radio" id="category" name="category"  value="ENFP">ENFP</label> 		     
			  <label><input type="radio" id="category" name="category"  value="ISTJ">ISTJ</label>		     
			  <label><input type="radio" id="category" name="category"  value="ISFJ">ISFJ</label>		     
			  <label><input type="radio" id="category" name="category"  value="ESTJ">ESTJ</label>		     
			  <label><input type="radio" id="category" name="category"  value="ESFJ">ESFJ</label>		     
			  <label><input type="radio" id="category" name="category"  value="ISTP">ISTP</label>		     
			  <label><input type="radio" id="category" name="category"  value="ISFP">ISFP</label>		     
			  <label><input type="radio" id="category" name="category"  value="ESTP">ESTP</label>		     
			  <label><input type="radio" id="category" name="category"  value="ESFP">ESFP</label>		     
			  <label><input type="radio" id="category" name="category"  value="info">정보</label>
		  </c:if>  		     
	      </div> 
	       <div class="col-12"  >
		      <label class="form-label" style="width:100px;">닉네임</label>
		      <input type="text" class="form-control" name="boardWriter" id="boardWriter" value="닉네임" readonly> 
	       </div>
	       <div class="col-12"  >
		      <label class="form-label" style="width:100px;">파일첨부</label>
		      <input type="file" class="form-control" name="file" id="inputFile"> 
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
			  <textarea class="form-control" name="boardContent" rows="3" placeholder="내용을 입력해주세요"></textarea>
			</div>
			<button type="submit" class="btn btn-primary btn-lg">등록</button>
			<button type="reset" class="btn btn-secondary btn-lg">취소</button>
		</form>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
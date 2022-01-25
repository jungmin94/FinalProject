<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	

<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> 

 <section> 


	  <div style="text-align: center;">
		<span class="badge bg-success">친구찾기 리스트</span>
	  </div>
		<br>
		<div class="row" style="text-align: center;">
			<div class="col">
					
			</div>
			
			<c:forEach var="t" items="${list }">
			  <div class="col">
				<div class="card" style="width: 18rem;">
					<img src="${t.member_id.member_profile }" class="card-img-top" alt="..." style="height: 170px;">
					<div class="card-body">
					  <h5 class="card-title"><c:out value="${t.member_id.member_id }"/></h5>
					  <p class="card-text"><c:out value="${t.member_id.member_nick }"/></p>
					  <p class="card-text"><c:out value="${t.member_id.member_date }"/></p>
					  <p class="card-text"><c:out value="${t.member_id.member_gender }"/></p>
					  <p class="card-text"><c:out value="${t.member_id.member_mbti }"/></p>
					  <a href="javascript:fn_sendNote(this);" class="btn btn-primary">쪽지 보내기</a>
					</div>
				  </div>
			  </div>
			</c:forEach>


			<div class="col">
					
			</div>
			
		</div>	 
		
		<br>
		<br>

</section> 

<script>

const fn_sendNote=(e)=>{
	open("${path}/message/sendMessage","_blank","width=300,height=500");
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
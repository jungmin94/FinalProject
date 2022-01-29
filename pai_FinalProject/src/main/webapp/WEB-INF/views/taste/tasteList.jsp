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
					<%-- <img src="${t.member_id.member_profile }" class="card-img-top" alt="..." style="height: 170px;"> --%>
					<div class="card-body">
					  <p class="card-text"><c:out value="${t.member_id.member_id }"/></p>
					  <p class="card-text"><c:out value="${t.member_id.member_nick }"/></p>
					  <p class="card-text"><c:out value="${t.member_id.member_date }"/></p>
					  <p class="card-text"><c:out value="${t.member_id.member_gender }"/></p>
					  <p class="card-text"><c:out value="${t.member_id.member_mbti }"/></p>
					  <button onclick="sendMessage(this);" class="btn btn-primary">쪽지 보내기</button>
					</div>
				  </div>
			  </div>
			</c:forEach>


			<div class="col">
					
			</div>
			
		</div>	 
		
		<br>
		<br>
		<form id="sendData" action="${path}/message/sendMessage" method="post">
			<input type="hidden" name="member_id" id="member_id" >
			<input type="hidden" name="member_nick" id="member_nick">
			<input type="hidden" name="member_date" id="member_date">
			<input type="hidden" name="member_gender" id="member_gender">
			<input type="hidden" name="member_mbti" id="member_mbti">
		</form>

</section> 

<script>

const sendMessage=(e)=>{
 	 var memberId = e.parentElement.children[0].innerText;
	 var memberNick = e.parentElement.children[1].innerText;
	 var memberDate = e.parentElement.children[2].innerText;
	 var memberGender = e.parentElement.children[3].innerText;
	 var memberMbti = e.parentElement.children[4].innerText;
	 $("#member_id").val(memberId);
	 $("#member_nick").val(memberNick);
	 $("#member_date").val(memberDate);
	 $("#member_gender").val(memberGender);
	 $("#member_mbti").val(memberMbti);
	 $('#sendData').attr("target", "formInfo");
	 open("", "formInfo", "height=600, width=600, menubar=no, scrollbars=yes, resizable=no, toolbar=no, status=no, left=50, top=50");
	 $("#sendData").submit();
};
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="회원탈퇴"/>
</jsp:include>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
	<form action="/member/delete" method="post" id="deleteForm" name="deleteForm">
		<input type="hidden" id="memberId" name="memberId" value="${loginmember.member_Id}">
		<div class="col-sm-8 col-sm-offset-2">
			<div class="panel panel-default panel-margin-10">
				<div class="panel-body panel-body-content text-center">
					<p class="lead">회원탈퇴를 하려면 비밀번호를 입력해주세요.</p>
					<div class="form-group">
						<input type="password" id = "member_pw" name="member_pw" class="form-control form-control-inline text-center" placeholder="비밀번호" />
					</div>
					<div class="form-group">
						<input type="password" id="member_pw2" name="member_pw2"  class="form-control form-control-inline text-center" placeholder="비밀번호 확인" />
					</div>
					<button type="button" id="deletee" name="delete" class="btn btn-primary">회원탈퇴</button> <a href="/member/infoView" class="btn btn-default">취소</a>
				</div>
			</div>
		</div>
	</form>
</body>
<script type="text/javascript">
	$(document).ready(function(){
	
		$("#deletee").on("click", function(){
			
			if($("#member_pw").val()==""){
				alert("비밀번호를 입력해주세요");
				$("#member_pw").focus();
				return false
			}
			
			if($("#member_pw2").val()==""){
				alert("비밀번호 확인을 입력해주세요");
				$("#member_pw2").focus();
				return false
			}
			
			if ($("#member_pw").val() != $("#member_pw2").val()) {
				alert("비밀번호가 일치하지 않습니다.");
				$("#memberPw").focus();
				return false;
			}
			
			$.ajax({
				url : "/member/pwCheck",
				type : "POST",
				dataType : "json",
				data : $("#deleteForm").serializeArray(),
				success: function(data){
					
					if(data==0){
						alert("비밀번호를 확인해주세요.");
						return;
					}else{
						if(confirm("탈퇴하시겠습니까?")){
							$("#deleteForm").submit();
						}
						
					}
				}
			})
			/* $.ajax({
				url : "/member/checkPW.do",
				type : "POST",
				dataType : "json",
				data : $("#deleteForm").serializeArray(),
				success: function(data){
					
					if(data==false){
						alert("비밀번호를 확인해주세요.");
						return;
					}else{
						if(confirm("탈퇴하시겠습니까?")){
							$("#deleteForm").submit();
						}
						
					}
				}
			}) */
		});
	})
</script>		
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
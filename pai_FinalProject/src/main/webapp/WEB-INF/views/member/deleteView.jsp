<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="회원탈퇴"/>
</jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.delete {
	  width: 30%;
	  height: 700px;
	  background: white;
	  border-radius: 20px;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  flex-direction: column;
	}
	.btn-outline-secondary:hover{
	   background-color: #6710f242;
	   border: 1px solid #6710f242;
	}
	.btn-outline-secondary{
	   border: 1px solid #6710f242;
	   color:#6710f242;
	}
	.wrap {
	  width: 100%;
	  height: 100vh;
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  background: rgba(0, 0, 0, 0.1);
	}
	.form-floating,.checkbox{
		color:purple;
	}
</style>
<section>
	<form action="${path }/member/delete.do" method="post" class="wrap" id="deleteForm" name="deleteForm">
		<input type="hidden" id="member_id" name="member_id" value="${loginMember.member_id}">
		<div class="delete">
			<div class="col-sm-8 col-sm-offset-2">
				<div class="panel panel-default panel-margin-10">
					<div class="headDiv">
			        	<img src="${ path }/resources/images/member/logo_white.jpg" class="homeimg" width="300px" height="300px" >
			    	</div>
					<div class="panel-body panel-body-content text-center">
						<h4>회원탈퇴를 하려면</h4>
						<h4>비밀번호를 입력해주세요.</h4>
						<div style="width: 100%;">
				            <div class="form-floating mb-3" style="width: 100%">
							  	<input type="password" class="form-control" id="member_pw" name="member_pw" placeholder="패스워드" required>
							  	<label for="floatingInput">패스워드를 입력하세요</label>
							</div> 
						</div>	
						<div style="width: 100%;">
				            <div class="form-floating mb-3" style="width: 100%">
							  	<input type="password" class="form-control" id="member_pw2" name="member_pw2" placeholder="패스워드" required>
							  	<label for="floatingInput">패스워드를 다시 입력하세요</label>
							</div> 
						</div>
		                <div style="width: 100%;">
				           	<div style="width: 100%; display: inline-block;">
				           		<input type="button" class="btn btn-outline-secondary" name="delete" id="delete" value="회원 탈퇴" style="width: 100%;">
				           	</div>
				        </div><br>
		                <div style="width: 100%;">
				           	<div style="width: 100%; display: inline-block;">
				           		<input type="submit" class="deleteBtn btn btn-outline-secondary" id="goBack" value="취소" style="width: 100%;">
				           	</div>
				        </div>
					</div>
				</div>
			</div>
		</div>
	</form>
</section>
<script type="text/javascript">
	$(document).ready(function(){
	
		$("#delete").on("click", function(){
			
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
				$("#member_pw").focus();
				return false;
			}
			
			$.ajax({
				url : "${path}/member/pwCheck.do",
				type : "POST",
				dataType : "json",
				data : $("#deleteForm").serializeArray(),
				success: function(data){
					if(data==0){
						alert("비밀번호를 확인해주세요.");
						return;
					}else{
						confirm("탈퇴하시겠습니까?")
							$("#deleteForm").submit();
					}
						
				}
			})
		})
	});
</script>		
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
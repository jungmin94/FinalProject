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
	<form action="${path }/member/pwUpdateEnd.do" method="post" id="pwUpdateForm" name="pwUpdateForm">
                       <input type="hidden" id="member_id" name="member_id" value="${loginMember.member_id}">
    <div class="col-sm-8 col-sm-offset-2">
        <div class="panel panel-default panel-margin-10">
            <div class="panel-body panel-body-content text-center">
                <p class="lead">변경하실 비밀번호를 입력해 주세요.</p>
                <div class="form-group">
                    <input type="password" name="member_pw" id="member_pw" class="form-control form-control-inline text-center" placeholder="현재 비밀번호" />
                </div>
                <div class="form-group">
                    <input type="password" name="member_pw1" id="member_pw1" class="form-control form-control-inline text-center" placeholder="새 비밀번호" />
                </div>
                <div class="form-group">
                    <input type="password" name="member_pw2" id="member_pw2" class="form-control form-control-inline text-center" placeholder="새 비밀번호 확인" />
                </div>
                <button type="submit" id="pwUpdate" name="pwUpdate" class="btn btn-primary">비밀번호 변경</button> <a href="${path }/member/memberView.do" class="btn btn-default">취소</a>
            </div>
        </div>
    </div>
    </form>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("#pwUpdate").on("click", function(){
			if($("#member_pw").val==""){
				alert("현재 비밀번호를 입력해주세요");
				$("#member_pw").focus();
				return false
			}
			if($("#member_pw1").val==""){
				alert("변경비밀번호을를 입력해주세요");
				$("#member_pw1").focus();
				return false
			}
			if($("#member_pw2").val==""){
				alert("변경비밀번호를 입력해주세요");
				$("#member_pw2").focus();
				return false
			}
			
			if ($("#member_pw1").val() != $("#member_pw2").val()) {
				alert("변경비밀번호가 일치하지 않습니다.");
				$("#member_pw2").focus();
			
				$.ajax({
					url : "${path}/member/pwCheck.do",
					type : "POST",
					dataType : "json",
					data : $("#pwUpdateForm").serializeArray(),
					success: function(data){
						
						if(data==0){
							alert("패스워드가 틀렸습니다.");
							return;
						}else{
							if(confirm("변경하시겠습니까?")){
								$("#pwUpdateForm").submit();
							}
						}
					}
				})
			}
		});
	})
</script>	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
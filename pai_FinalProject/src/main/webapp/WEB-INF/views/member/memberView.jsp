<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="회원정보보기"/>
</jsp:include>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
<style>
	div#enroll-container{width:400px; margin:0 auto; text-align:center;}
	div#enroll-container input, div#enroll-container select {margin-bottom:10px;}
	div#enroll-container{width:400px; margin:0 auto; text-align:center;}
	div#enroll-container input, div#enroll-container select {margin-bottom:10px;}
	div#memberId-container{position:relative;padding:0px;}
	div#memberNick-container{position:relative;padding:0px;}
</style>
<div id="enroll-container">
				<h2>회원정보</h2>
				<div id="memberProfile-container">
					<div id="image-container">
 						<c:if test="">
 						</c:if>
 						<img src="${path }/resources/upload/member/${renamedFileName}" >
					</div>
					<label for="exampleDataList" class="form-label">프로필사진</label>
				</div>
				<div id="memberContent-container">
					<label for="exampleDataList" class="form-label">자기소개</label>
					<textarea class="form-control" name="member_content" readonly><c:out value="${loginMember.member_content }"/></textarea>
				</div>
				<div id="memberId-container">
					<label for="exampleDataList" class="form-label">아이디</label>
					<input type="text" class="form-control" value="${loginMember.member_id }" name="member_id" id="member_id" readonly/>
				</div>
				<div id="memberNick-container">
					<label for="exampleDataList" class="form-label">닉네임</label>
					<input type="text" class="form-control" value="${loginMember.member_nick }" name="member_nick" id="member_nick" readonly>
				</div>
				<div id="memberName-container">
					<label for="exampleDataList" class="form-label">이름</label>
					<input type="text" class="form-control" name="member_name" id="member_name" value="${loginMember.member_name }" readonly>
				</div>	
				<div id="memberDate-container">
					<label for="exampleDataList" class="form-label">생년월일</label>
					<input type="date" class="form-control" name="member_date" value="${loginMember.member_date }" id="member_date" readonly>
				</div>			
				<div id="memberEmail-container">
					<label for="exampleDataList" class="form-label">이메일</label>
					<input type="text" class="form-control" name="member_email" id="member_email" value="${loginMember.member_email }" maxlength="30" readonly/>
				</div>				
				<div id="memberPhone-container">
					<label for="exampleDataList" class="form-label">전화번호</label>
					<input type="tel" class="form-control" value="${loginMember.member_phone }" name="member_phone" id="member_phone" maxlength="11" readonly>
				</div>
				<div id="memberAddr-container">
					<label for="exampleDataList" class="form-label">주소</label>
					<div class="form-group">                   
						<input class="form-control" style="width: 100%; display: inline;" value="${loginMember.member_addr }" name="member_addr" id="member_addr" type="text" readonly>
					</div>
				</div>
				<div id="memberGender-container">
					<label for="exampleDataList" class="form-label">성별</label>
					<input type="text" class="form-control" value="${loginMember.member_gender }" name="member_gender" id="member_gender" maxlength="30" readonly/>
				</div>				
				<div style="width: 49%; display: inline-block;">
	           		<input type="button" class="btn btn-outline-secondary" id="updateMember" value="회원정보수정" style="width: 100%;">
	           	</div>
		        <div  style="width: 49%; display: inline-block;">
		        	<input type="button" class="btn btn-outline-secondary" id="changePwd" value="패스워드 변경" style="width: 100%;">
		        </div>
		        <div  style="width: 49%; display: inline-block;">
		        	<input type="button" class="btn btn-outline-secondary" id=deleteView value="회원탈퇴" style="width: 100%;">
		        </div>
			</form>
		</div>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(function(){
		$("#updateMember").on("click", function(){
			location.href = '${ path }/member/updateMember.do'
		})
	})
	$(function(){
		$("#changePwd").on("click", function(){
			location.href = '${ path }/member/changePw.do'
		})
	})
	$(function(){
		$("#deleteMember").on("click", function(){
			location.href = '${ path }/member/deleteView'
		})
	})
	
</script>		

</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
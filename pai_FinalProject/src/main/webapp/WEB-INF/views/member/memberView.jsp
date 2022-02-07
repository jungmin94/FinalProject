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
<%-- 						<img src="${path }/resources/upload/member/${profile." --%>
					</div>
					<label for="exampleDataList" class="form-label">프로필사진</label>
				</div>
				<div id="memberContent-container">
					<label for="exampleDataList" class="form-label">자기소개</label>
					<textarea class="form-control" name="member_content" placeholder="자기소개를"><c:out value="${member.member_content }"/></textarea>
				</div>
				<div id="memberId-container">
					<label for="exampleDataList" class="form-label">아이디</label>
					<input type="text" class="form-control" placeholder="아이디 (4글자이상)" name="member_id" id="member_id" required oninput="checkId()"/>
				</div>
				<div id="memberNick-container">
					<label for="exampleDataList" class="form-label">닉네임</label>
					<input type="text" class="form-control" placeholder="닉네임을 입력해주세요" name="member_nick" id="member_nick" required oninput="checkNick()">
				</div>
				<div id="memberName-container">
					<label for="exampleDataList" class="form-label">이름</label>
					<input type="text" class="form-control" placeholder="이름을 입력해주세요" name="member_name" id="member_name" required>
				</div>	
				<div id="memberDate-container">
					<label for="exampleDataList" class="form-label">생년월일</label>
					<input type="date" class="form-control" placeholder="" name="member_date" id="member_date">
				</div>			
				<div id="memberEmail-container">
					<label for="exampleDataList" class="form-label">이메일</label>
					<input type="text" class="form-control" name="email_1" id="email_1" value="" maxlength="30"/>
				</div>				
				<div id="memberPhone-container">
					<label for="exampleDataList" class="form-label">전화번호</label>
					<input type="tel" class="form-control" placeholder="전화번호 (예:01012345678)" name="member_phone" id="member_phone" maxlength="11" required>
				</div>
				<div id="memberAddr-container">
					<label for="exampleDataList" class="form-label">주소</label>
					<div class="form-group">                   
						<input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="member_addr1" id="member_addr1" type="text" disabled="disabled" >
					</div>
					<div class="form-group">
					    <input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="member_addr2" id="member_addr2" type="text" disabled="disabled" />
					</div>
					<div class="form-group">
					    <input class="form-control" placeholder="상세주소" name="member_addr3" id="member_addr3" type="text"  />
					</div>
				</div>
				<div id="memberGender-container">
					<label for="exampleDataList" class="form-label">성별</label>
					<div class="form-check">
					  <label class="form-check-label" for="flexRadioDefault1">
					    남자
					  </label>
					</div>
				</div>				
				<input type="submit" class="btn btn-outline-success" id="join" value="회원정보수정" >&nbsp;
				<input type="reset" class="btn btn-outline-success" value="비밀번호 변경">
			</form>
		</div>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

	
</script>		

</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
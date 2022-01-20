<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="게시판"/>
</jsp:include>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/resources/js/addressapi.js"></script>
<body>
<style>
	div#enroll-container{width:400px; margin:0 auto; text-align:center;}
	div#enroll-container input, div#enroll-container select {margin-bottom:10px;}
	div#enroll-container{width:400px; margin:0 auto; text-align:center;}
	div#enroll-container input, div#enroll-container select {margin-bottom:10px;}
	div#userId-container{position:relative;padding:0px;}
	div#userId-container span.guide{display: none;font-size:12px;position:absolute;top:12px;right:10px;}
	div#userId-container span.ok{color:green;}
	div#userId-container span.error{color:red;}
</style>
<div id="enroll-container">
			<form name="memberEnrollFrm" action="${path }/member/enrollMemberEnd.do" method="post">
				<div id="userId-container">
					<input type="text" class="form-control" placeholder="아이디 (4글자이상)" name="member_id" id="member_id" required>
					<button type="button" class="btn btn-outline-success" onclick="jacksonAjax();">중복확인(@ResponseBody))</button>
					<span class="guide ok">이 아이디는 사용이 가능합니다.</span>
					<span class="guide error">이 아이디는 사용이 불가능합니다.</span>
				</div>
				
				<input type="password" class="form-control" placeholder="비밀번호" name="member_pw" id="member_pw" required>
				<input type="password" class="form-control" placeholder="비밀번호확인" id="member_pw2" required>
				
				<input type="text" class="form-control" placeholder="별명" name="member_nick" id="member_nick" required>
				
				<input type="text" class="form-control" placeholder="이름" name="member_name" id="member_name" required>
				
				<input type="number" class="form-control" placeholder="나이" name="age" id="age">
				
				<input type="email" class="form-control" placeholder="이메일" name="member_email" id="member_email" required>
				<input type="tel" class="form-control" placeholder="전화번호 (예:01012345678)" name="member_phone" id="member_phone" maxlength="11" required>
				<div class="form-group">                   
				<input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="member_addr1" id="member_addr1" type="text" readonly="readonly" >
				    <button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>                               
				</div>
				<div class="form-group">
				    <input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="member_addr2" id="member_addr2" type="text" readonly="readonly" />
				</div>
				<div class="form-group">
				    <input class="form-control" placeholder="상세주소" name="member_addr3" id="member_addr3" type="text"  />
				</div>
				
				<select class="form-control" name="gender" required>
					<option value="" disabled selected>성별</option>
					<option value="M">남</option>
					<option value="F">여</option>
				</select>
				<br />
				<input type="submit" class="btn btn-outline-success" value="가입" >&nbsp;
				<input type="reset" class="btn btn-outline-success" value="취소">
			</form>
		</div>
<script>
	function execPostCode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	           var extraRoadAddr = ''; // 도로명 조합형 주소 변수
	
	           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	               extraRoadAddr += data.bname;
	           }
	           // 건물명이 있고, 공동주택일 경우 추가한다.
	           if(data.buildingName !== '' && data.apartment === 'Y'){
	              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	           }
	           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	           if(extraRoadAddr !== ''){
	               extraRoadAddr = ' (' + extraRoadAddr + ')';
	           }
	           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	           if(fullRoadAddr !== ''){
	               fullRoadAddr += extraRoadAddr;
	           }
	
	           // 우편번호와 주소 정보를 해당 필드에 넣는다.
	           console.log(data.zonecode);
	           console.log(fullRoadAddr);
	           
	           
	           $("[name=addr1]").val(data.zonecode);
	           $("[name=addr2]").val(fullRoadAddr);
	           
	           /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
	           document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
	           document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
	       }
	    }).open();
	}
	
	//아이디 중복확인
	const jacksonAjax=()=>{
		$.get("${path}/ajax/jacksonCheckId?userId="+$("#userId_").val(),
				data=>{
					console.log(data);
				});
	}
	
	
</script>		

</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
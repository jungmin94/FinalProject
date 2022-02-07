<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
</head>
<body>
<style>
.final_pw_ck{
	    display: none;
	}
	.final_pwck_ck{
	    display: none;
	}
</style>
	<script>
		$(function(){
			alert("${ msg }");
		})
	</script>
	
	<div class="insertFormDiv">
       	<h1>비밀번호 변경</h1>
       	<form action="${ path }/member/findPwdUpdate" method="POST" id="joinForm">
       		<input type="hidden" name="member_id" value="${ user.member_id }">
       		<div id="memberPw-container">
					<label for="exampleDataList" class="form-label">비밀번호</label>
					<input type="password" class="form-control" placeholder="비밀번호를 입력해주세요" name="member_pw" id="member_pw" tabindex="2" oninput="checkPw(member_pw.value)" required>
					<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
				</div>
				<div id="memberPw2-container">
					<label for="exampleDataList" class="form-label">비밀번호 확인</label>
					<input type="password" class="form-control" placeholder="비밀번호를 다시 한 번 입력해주세요" name="member_pw2" id="member_pw2" tabindex="3" required />
					<p id="pwCheckF" style="color: #FF6600; margin: 0;"></p>
					<p id="pwCheckFF" style="color: #FF6600; margin: 0;"></p>
					<span class="final_pwck_ck">비밀번호를 다시 한번 입력해주세요.</span>
				</div>
            <button type="submit" class="updateBtn" id="updateBtn">확인</button>
       	</form>
    </div>
    <script>
        
  //비밀번호 일치확인
    $(document).ready(function(){
    	$('#member_pw').keyup(function(){
    		$('#pwCheckFF').text('');
    	}); 
    	
    	$('#member_pw2').keyup(function(){
    		if($('#member_pw').val()!=$('#member_pw2').val()){
    			$('#pwCheckFF').text('');
    	  		$('#pwCheckFF').html("패스워드 확인이 불일치 합니다");
    	 	}else{
    		  	$('#pwCheckFF').text('');
    		  	$('#pwCheckFF').html("<font color='#70AD47'>패스워드가 일치 합니다.</font>");
    	 	}
    	});
     }); 
     
     //비밀번호 실시간 유효성 체크
    function checkPw(member_pw){
    	$.ajax({
    		type:"POST",
    		url: "${path}/member/checkPw.do",
    		data : { member_pw:member_pw },
    		success:function(result){	
    			if(result == true){				
    				pwCheckF.innerHTML = "안전한 비밀번호입니다."; 				
    			}else{				
    				pwCheckF.innerHTML = "8~15자리 영대문자,소문자,특수문자를 꼭 포함해주세요"; 
    			}
    		},
        	error:function(request,status){
        		alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        	}
    	});	
    }
    </script>
</body>
</html>
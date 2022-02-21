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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<style>
  .findpw {
	  width: 30%;
	  height: 600px;
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

.final_pw_ck{
	    display: none;
	}
	.final_pwck_ck{
	    display: none;
	}
</style>
</head>
<body>
	<script>
		$(function(){
			alert("${ msg }");
		})
	</script>
	
	<div class="wrap">
		<div class="findpw">
			<div class="headDiv">
	        	<img src="${ path }/resources/images/member/logo_white.jpg" class="homeimg" width="300px" height="300px" >
	    	</div>
	       	<br>
	       	<h3>비밀번호 변경</h3>
	       	<br>
	       	<form action="${ path }/member/findPwdUpdate" method="POST" id="joinForm">
	       		<input type="hidden" name="member_id" value="${ user.member_id }">
				<div style="width: 100%;">
		            <div class="form-floating mb-3" style="width: 100%">
					  	<input type="password" class="form-control" id="member_pw" name="member_pw" placeholder="패스워드" tabindex="2" oninput="checkPw(member_pw.value)" required>
					  	<label for="floatingInput">패스워드를 입력하세요</label>
					</div> 
				</div>	
					<span class="final_pw_ck">패스워드를 입력해주세요.</span>
				<div style="width: 400px;">
		            <div class="form-floating mb-3" style="width: 100%">
					  	<input type="password" class="form-control" id="member_pw2" name="member_pw2" placeholder="패스워드" tabindex="3" required>
					  	<label for="floatingInput">패스워드를 다시 입력하세요</label>
					</div> 
				</div>	
					<p id="pwCheckF" style="color: #FF6600; margin: 0;"></p>
					<p id="pwCheckFF" style="color: #FF6600; margin: 0;"></p>
					<span class="final_pwck_ck">패스워드를 다시 한번 입력해주세요.</span>
	            <div style="width: 100%;">
		           	<div style="width: 100%; display: inline-block;">
		           		<input type="submit" class="updateBtn btn btn-outline-secondary" id="updateBtn" value="패스워드 변경" style="width: 100%;">
		           	</div>
		        </div>
		        <br>
	       	</form>
	    </div>
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
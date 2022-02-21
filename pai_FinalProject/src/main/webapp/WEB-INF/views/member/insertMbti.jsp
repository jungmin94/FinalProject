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
<style>
	.wrap {
		  width: 100%;
		  height: 100vh;
		  display: flex;
		  align-items: center;
		  justify-content: center;
		  background: rgba(0, 0, 0, 0.1);
		}
	.insertMbti {
	  width: 30%;
	  height: 800px;
	  background: white;
	  border-radius: 20px;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  flex-direction: column;
	}
	.form-floating,.checkbox{
		color:purple;
	}
	.btn-outline-secondary:hover{
	   background-color: #6710f242;
	   border: 1px solid #6710f242;
	}
	.btn-outline-secondary{
	   border: 1px solid #6710f242;
	   color:#6710f242;
	}
</style>
<section>
	<form class="wrap" action="${path }/member/insertMbti.do" method="post" onsubmit="return check()">
        <div class="insertMbti">
            <div>
	            <img src="${path }/resources/images/member/logo_white.jpg" style="width:300px; height:300px;">
            </div><br>
    		<div>
			  	<h3><strong>${loginMember.member_nick }</strong> 님의 MBTI를 입력하세요</h3>
			  	<h3>(대문자로 입력해주세요!)</h3>
    		</div><br>	    
            <div style="width: 60%;">
	            <div class="form-floating mb-3">
				  	<input type="text" class="form-control" id="member_mbti" name="member_mbti" placeholder="MBTI 입력" >
				  	<label for="floatingInput">MBTI입력</label>
				</div> 
			</div>	
			<div class="submit btn-outline-secondary" style=width:60%;>
            	
                <button type="submit" value="MBTI입력" class="btn btn-outline-secondary" style="width:100%;">MBTI입력</button>
            
            </div><br>
	        	<h4>혹시 본인의 MBTI를 아직 모른다면...!!</h4><br>
	        	<h4>아래의 버튼을 눌러서 테스트를 완료해주세요!</h4><br>
	        <div class="btn-outline-secondary" style="width:60%;">
 		        <input type="button" class="btn btn-outline-secondary" style="width:100%;" value="MBTI테스트" onclick="location.assign('${path}/member/mbtiTest.do')">
		        
	        </div>
		</div>
	</form>
</section>
<script>
	function check() {
		/* var checkMbti= RegExp(/^(ENFP|ENFJ|ENTP|ENTJ|ESFP|ESFJ|ESTP|ESTJ|INFP|INFJ|INTP|INTJ|ISFP|ISFJ|ISTP|ISTJ){4}/); */
		var checkMbti = RegExp(/^[EI][SN][FT][PJ]$/);
		if($("#member_mbti").val() == ""){ 
			alert("MBTI를 입력해주세요"); 
			$("#member_mbti").focus(); 
			return false; 
		}

		if(!checkMbti.test($("#member_mbti").val())){ 
			alert("올바른 MBTI를 입력해주세요"); 
			$("#member_mbti").val(""); 
			$("#member_mbti").focus(); 
			return false; 
		}
	}
		
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
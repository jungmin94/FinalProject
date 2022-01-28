<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="게시판"/>
</jsp:include>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
<style>
	div#enroll-container{width:400px; margin:0 auto; text-align:center;}
	div#enroll-container input, div#enroll-container select {margin-bottom:10px;}
	div#enroll-container{width:400px; margin:0 auto; text-align:center;}
	div#enroll-container input, div#enroll-container select {margin-bottom:10px;}
	div#memberId-container{position:relative;padding:0px;}
	div#memberId-container span.id_ok{color:green; display: none;}
	div#memberId-container span.id_error{color:red; display: none;}
	div#memberNick-container{position:relative;padding:0px;}
	div#memberNick-container span.nick_ok{color:green; display: none;}
	div#memberNick-container span.nick_error{color:red; display: none;}
	.final_id_ck{
	    display: none;
	}
	.final_pw_ck{
	    display: none;
	}
	.final_pwck_ck{
	    display: none;
	}
	.final_name_ck{
	    display: none;
	}
	.final_mail_ck{
	    display: none;
	}
	.final_addr_ck{
	    display: none;
	}
	.final_birth_ck{
	    display: none;
	}
	.final_nick_ck{
	    display: none;
	}
</style>
<div id="enroll-container">
			<form id="joinFrm" name="memberEnrollFrm" action="${path }/member/enrollMemberEnd.do" method="post" enctype="multipart/form-data">
				<h2>회원가입</h2>
				
				<div id="memberId-container">
					<label for="exampleDataList" class="form-label">아이디</label>
					<input type="text" class="form-control" placeholder="아이디 (4글자이상)" name="member_id" id="member_id" required oninput="checkId()"/>
					<span class="id_ok">사용 가능한 아이디입니다.</span>
					<span class="id_error">누군가가 이 아이디를 사용하고있어요.</span>
					<span class="final_id_ck">아이디를 입력해주세요.</span>
				</div>
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
					<span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
				</div>
				<div id="memberNick-container">
					<label for="exampleDataList" class="form-label">닉네임</label>
					<input type="text" class="form-control" placeholder="닉네임을 입력해주세요" name="member_nick" id="member_nick" required oninput="checkNick()">
					<span class="nick_ok">사용 가능한 닉네임입니다.</span>
					<span class="nick_error">누군가가 이 닉네임을 사용하고있어요.</span>
					<span class="final_nick_ck">닉네임을 입력해주세요.</span>
				</div>
				<div id="memberName-container">
					<label for="exampleDataList" class="form-label">이름</label>
					<input type="text" class="form-control" placeholder="이름을 입력해주세요" name="member_name" id="member_name" required>
					<span class="final_name_ck">이름을 입력해주세요.</span>
				</div>	
				<div id="memberDate-container">
					<label for="exampleDataList" class="form-label">생년월일</label>
					<input type="date" class="form-control" placeholder="" name="age" id="age">
					<span class="final_birth_ck">생년월일을 입력해주세요.</span>
				</div>			
				<div id="memberEmail-container">
					<input type="text" class="form-control" name="email_1" id="email_1" value="" maxlength="30"/>
					<span id="at">@</span>
					<input type="text" class="form-control" name="email_2" value="" maxlength="30" style="ime-mode:disabled;" />
					<select name="email_3" id="email_3" class="form-select">
				        <option value="" selected>선택하세요</option>
				        <option value="naver.com">naver.com</option>
				        <option value="hotmail.com">hotmail.com</option>
				        <option value="hanmail.com">hanmail.com</option>
				        <option value="yahoo.co.kr">yahoo.co.kr</option>
				        <option value="etc" selected="selected">직접입력</option>
				    </select>
					<span class="final_mail_ck">이메일을 입력해주세요.</span>
					<input type="hidden" id="totalEmail" name="member_email" value="">
				</div>				
				<div id="memberPhone-container">
					<label for="exampleDataList" class="form-label">전화번호</label>
					<input type="tel" class="form-control" placeholder="전화번호 (예:01012345678)" name="member_phone" id="member_phone" maxlength="11" required>
				</div>
				<div id="memberAddr-container">
					<label for="exampleDataList" class="form-label">주소</label>
					<div class="form-group">                   
						<input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="member_addr1" id="member_addr1" type="text" disabled="disabled" >
					    <button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>                               
					</div>
					<div class="form-group">
					    <input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="member_addr2" id="member_addr2" type="text" disabled="disabled" />
					</div>
					<div class="form-group">
					    <input class="form-control" placeholder="상세주소" name="member_addr3" id="member_addr3" type="text"  />
					</div>
					<span class="final_addr_ck">주소를 입력해주세요.</span>
				</div>
				<div id="memberGender-container">
					<label for="exampleDataList" class="form-label">성별</label>
					<div class="form-check">
					  <input class="form-check-input" type="radio" name="member_gender" value="남">
					  <label class="form-check-label" for="flexRadioDefault1">
					    남자
					  </label>
					</div>
					<div class="form-check">
					  <input class="form-check-input" type="radio" name="member_gender" value="여">
					  <label class="form-check-label" for="flexRadioDefault2">
					    여자
					  </label>
					</div>
					<span class="final_addr_ck">성별을 체크해주세요.</span>
				</div>				
				<div id="memberProfile-container">
					<label for="exampleDataList" class="form-label">프로필사진</label>
					<div class="mb-3">
					  <input class="form-control" type="file" id="member_profile" name="member_profile">
					</div>
				</div>
				<div id="image-container">
				</div>
				<div id="memberContent-container">
					<label for="exampleDataList" class="form-label">자기소개</label>
					<textarea class="form-control" name="boardContent" placeholder="자기소개를 입력해주세요..."></textarea>
				</div>
				
				<input type="submit" class="btn btn-outline-success" id="join" value="가입" >&nbsp;
				<input type="reset" class="btn btn-outline-success" value="취소">
			</form>
		</div>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function execPostCode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	// 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수
 
                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
 
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 주소변수 문자열과 참고항목 문자열 합치기
                    addr += extraAddr;
                
                } else {
                	addr += ' ';
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $("#member_addr1").val(data.zonecode);
	            //$("[name=member_addr1]").val(data.zonecode);    // 대체가능
	            $("#member_addr2").val(addr);
	            //$("[name=member_addr2]").val(addr);            // 대체가능
                
	        	// 상세주소 입력란 disabled 속성 변경 및 커서를 상세주소 필드로 이동한다.
	            $("#member_addr3").attr("readonly",false);
	            $("#member_addr3").focus();
	        }
        }).open()
	}
	
	//아이디 중복확인
	function checkId(){
        var id = $('#member_id').val(); //id값이 "id"인 입력란의 값을 저장
        $.ajax({
            url:'${path}/member/checkId.do', //Controller에서 인식할 주소
            type:'post', //POST 방식으로 전달
            data:{member_id:id},
            success:function(result){
            	if(result != 1){ //result가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
                    $('.id_ok').css("display","inline-block"); 
                    $('.id_error').css("display", "none");
                } else { // result가 1일 경우 -> 이미 존재하는 아이디
                    $('.id_error').css("display","inline-block");
                    $('.id_ok').css("display", "none");
                }
            },	
            error:function(){
                alert("에러입니다");
            }
        });
    };
    
	//닉네임 중복확인
	function checkNick(){
        var nick = $('#member_nick').val(); 
        $.ajax({
            url:'${path}/member/checkNick.do', 
            type:'post', 
            data:{member_nick:nick},
            success:function(result){
            	if(result != 1){  
                    $('.nick_ok').css("display","inline-block"); 
                    $('.nick_error').css("display", "none");
                } else { 
                    $('.nick_error').css("display","inline-block");
                    $('.nick_ok').css("display", "none");
                }
            },	
            error:function(){
                alert("에러입니다");
            }
        });
    };
    
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
    		  	$('#pwCheckFF').html("<font color='#70AD47'>패스워드 확인이 일치 합니다.</font>");
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
	
	//이메일
	$("#email_1").blur(function(){
		email();	
	});
	
	$("#email_3").change(function(){
		email();	
	});

	function email() {
		const email = $("#email_1").val();
		const address = $("#email_3").val();
		if(email != "" && address != "") {
			$("#totalEmail").val(email+"@"+address);
		}
	};
	
	$(document).ready(function(){
		$("#email_3").change(function(){
			var email_3 = $(this).val(); 
			if(email_3 == "etc") { //직접입력일때
				$("input[name='email_2']").val('');  //이메일 도메인입력박스 초기화.
				$("input[name='email_2']").attr('readonly', false); //직접입력 가능하도록 readonly막기
			}
			else {
				$("input[name='email_2']").val(email_3); //이메일 도메인 입력박스에 선택된 호스트등록.
				$("input[name='email_2']").attr('readonly', true); //readonly로 직접입력 막기.
			}
		});
	});
	
	//유효성검사
	$(document).ready(function(){
		
		//가입버튼 누를시
		$("#join").click(function(){
			
			//입력값 변수
			var id = $('#member_id').val(); 			// id 입력란
			var pw = $('#member_pw').val();				// 비밀번호 입력란
			var pwck = $('#member_pw2').val();			// 비밀번호 확인 입력란
			var name = $('#member_name').val();			// 이름 입력란
			var nick = $('#member_nick').val();			// 닉네임 입력란
			var birth = $('#member_date').val();		// 생년월일 입력란
			var phone = $('#member_phone').val();		// 전화번호 입력란
			var mail = $('#tatalEmail').val();		// 이메일 입력란
			var addr = $('#member_addr3').val();		// 주소 입력란
			
			//유효성 검사 통과유무 변수
			var idCheck=false;		//아이디
			var pwCheck=false;		//비번
			var pwckCheck=false;	//비번확인
			var nameCheck=false;	//이름
			var nickCheck=false;	//닉네임
			var birthCkeck=false;	//생년월일
			var phoneCkeck=false;	//전화번호
			var mailCheck=false;	//이메일
			var addressCheck=false;	//주소
			
			//아이디 유효성검사
		    if(id == ""){
		        $('.final_id_ck').css('display','block');
		        idCheck = false;
		    }else{
		        $('.final_id_ck').css('display', 'none');
		        idCheck = true;
		    }
			
		    //비밀번호 유효성 검사
		    if(pw == ""){
		        $('.final_pw_ck').css('display','block');
		        pwCheck = false;
		    }else{
		        $('.final_pw_ck').css('display', 'none');
		        pwCheck = true;
		    }
		    
		    //비밀번호 확인 유효성 검사
		    if(pwck == ""){
		        $('.final_pwck_ck').css('display','block');
		        pwckCheck = false;
		    }else{
		        $('.final_pwck_ck').css('display', 'none');
		        pwckCheck = true;
		    }
		    
		    //닉네임 유효성 검사
		    if(nick == ""){
		        $('.nick_pwck_ck').css('display','block');
		        nickCheck = false;
		    }else{
		        $('.nick_pwck_ck').css('display', 'none');
		        nickCheck = true;
		    }
		    
		    //이름 유효성 검사
		    if(name == ""){
		        $('.final_name_ck').css('display','block');
		        nameCheck = false;
		    }else{
		        $('.final_name_ck').css('display', 'none');
		        nameCheck = true;
		    }
		    
		    //생년월일 유효성 검사
		    if(birth == ""){
		        $('.final_birth_ck').css('display','block');
		        nameCheck = false;
		    }else{
		        $('.final_birth_ck').css('display', 'none');
		        nameCheck = true;
		    }
		    
		    //이메일 유효성 검사
		    if(mail == ""){
		        $('.final_mail_ck').css('display','block');
		        mailCheck = false;
		    }else{
		        $('.final_mail_ck').css('display', 'none');
		        mailCheck = true;
		    }
		    
		    //전화번호 유효성 검사
		    if(phone == ""){
		        $('.final_phone_ck').css('display','block');
		        mailCheck = false;
		    }else{
		        $('.final_phone_ck').css('display', 'none');
		        mailCheck = true;
		    }
		    
		    //주소 유효성 검사
		    if(addr == ""){
		        $('.final_addr_ck').css('display','block');
		        addressCheck = false;
		    }else{
		        $('.final_addr_ck').css('display', 'none');
		        addressCheck = true;
		    }
		    
		    //최종 유효성 검사
		    if(idCheck&&pwCheck&&pwckCheck&&nickCheck&&nameCheck&&birthCheck&&mailCheck&&phoneCheck&&addressCheck ){
		    	$("#joinFrm").attr("action", "/member/join.do");
				$("#joinFrm").submit();				
			}		
			return false;  
			
		})
	})
	
	//이미지 업로드
	/* $("input[type='file']").on("change", function(e){
		
		
		
		let formData = new FormData();
		let fileInput = $('input[name="member_profile"]');
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];
		
		console.log("fileList : " + fileList);
		console.log("fileName : " + fileObj.name);
		console.log("fileSize : " + fileObj.size);
		console.log("fileType(MimeType) : " + fileObj.type);
		
		if(!fileCheck(fileObj.name, fileObj.size)){
			return false;
		}
		
		formData.append("member_profile", fileObj);		
		
		$.ajax({
	    	type : "POST",
			url: "${path}/member/profileUpload.do",
	    	processData : false,
	    	contentType : false,
	    	data : formData,
	    	dataType : 'json'
		});
	});
	//var, method related with attachFile
	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 1048576; //1MB	
	
	function fileCheck(fileName, fileSize){

		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
			  
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		
		return true;		
		
	} */
	
	
	
	
	//이미지 미리보기
	$("#target").click(e=>{
   		$("input[name=member_profile]").click();
   	});
   	$("input[name=member_profile]").change(e=>{
   		if(e.target.files[0].type.includes("image")){
   			let reader=new FileReader();
   			reader.onload=(e)=>{
   				const img=$("<img>").attr({
   					src:e.target.result,
   					width:"100px",
   					height:"100px"
   				});
   				$("#image-container").append(img);
   				$("#target").attr("src",e.target.result);
   			}
   			reader.readAsDataURL(e.target.files[0]);
   		}
   	})
	
	
</script>		

</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
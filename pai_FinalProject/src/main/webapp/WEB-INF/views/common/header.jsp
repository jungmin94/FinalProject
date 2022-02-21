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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<title>PAI</title>
<style>
body {  
	min-height: 100vh; display: grid; grid-template-rows: auto 1fr auto; 
} 

header {
    position: relative; 
	top: 0;
	width: 100%;
}

.header-nav {
	background-color: black;
	color: white;
	display: flex;
	width: 100%;
	table-layout: fixed;
}

.nav-lists {
	display: flex;
	margin-left: 0.4rem;
	margin-right: 16rem;
	flex-grow: 0;
	
}

#nav-menu {
	display: flex;
	justify-content: center;
	margin: 0 auto;
}

#nav-menu a {
	text-decoration: none;
}

.nav-menu a:link {
	text-decoration: none;
	color: inherit;
}

.menu-bar {
	width: 130px;
	padding: 1.5rem;
	text-align: center;
}

a .menu-bar {
	text-decoration: none;
	color: white;
}

.menu-bar:hover {
	background-color: rgb(34, 44, 182);
	transition: 0.3s;
}

#login-box {
	margin: 0;
	padding: 0;
	display: flex;
	align-items: center;
	position: absolute;
	right: 10px;
	top : 20px;
}

#mypage-icon {
	margin: 0;
	padding: 0;
	display: flex;
	align-items: center;
	position: absolute;
	right: 10px;
	top : 20px;
}

#nav-img {
	padding-left: 50px;
	position: absolute;
	left : 10px;
}

.login-area {
	padding-right: 10px;
}

#login-button {
	background-color: black;
	border: 2px solid rgb(34, 44, 182);
	color: white;
	width: 5rem;
	height: 1.7rem;
}

#login-button:hover {
	background-color: rgb(34, 44, 182);
	transition: 0.3s;
}

#enroll-button {
	background-color: rgb(34, 44, 182);
	border: 1px solid rgb(34, 44, 182);
	color: white;
	width: 5rem;
	height: 1.7rem;
}

#message-arrived {
	font-size: 12px;
	padding-right: 10px;
	color: white;
}

#sub-menu-bar {
	text-align: center;
	position: absolute;
	right: 0.55%;
	display: inline-block;
	background-color: rgb(85, 85, 85);
	color: white;
	width: 10%;
	visibility: hidden;
}

#sub-menu-bar a {
	text-decoration: none;
}

a .sub-menu-detail {
	color: white;
}

.sub-menu-detail {
	padding: 20px;
}

.sub-menu-detail:hover {
	background-color: rgb(34, 44, 182);
}

#message-icon {
	position: absolute;
	right: 26%;
	top: 30%;
}

#message-count {
	position: absolute;
	right: 29%;
	top: 31%;
	font-size: 9px;
}
</style>
</head>
<body>
<header>
	<nav>
		<div class="header-nav">
		<c:if test="${loginMember.member_black!=1}">
			<div class="nav-lists" id="nav-img">
				<a href="${path}/"><img src="${path }/resources/images/member/logo_black.jpg" width="60px" height="60px"></a>
			</div>
			<div id="nav-menu">
				<a href="${path}/board/boardList.do"><div class="menu-bar">게시판</div></a>
				<a href="${path}/market/mainView.do"><div class="menu-bar">MBTI 마켓</div></a>
				<a href="${path }/chatting/toSeeMyChatroomInfo.do"><div class="menu-bar">채팅</div></a>
				<c:if test="${loginMember eq null}"> 
	            	<a href="${path }/" onclick="msg();"><div class="menu-bar">친구찾기</div></a>
	            </c:if>
	            <c:if test="${loginMember ne null }">
	            	<a href="${path }/taste/taste.do"><div class="menu-bar">친구찾기</div></a>
	            </c:if>
				<c:if test="${loginMember!=null&&loginMember.member_id eq 'admin'}"> 
					<a href="${path}/admin/adminView.do"><div class="menu-bar">회원관리</div></a>
				</c:if>
			</div>
			<c:if test="${loginMember==null }">
			<!-- 만약 로그인하지 않은 상태라면 하단의 div #login-box출력 -->
		        <div id="login-box">
		            <span class="login-area"><button id="login-button" onclick="location.assign('${path}/member/loginMember.do')">로그인</button></span>
		            <span class="login-area"><button id="enroll-button" onclick="location.assign('${path}/member/enrollMember.do')">회원가입</button></span>
		        </div>
			</c:if>
		</c:if>
			<c:if test="${loginMember!=null }">
				<div class="nav-lists" id="mypage-icon">
					<!-- 만약 받은 쪽지가 없을 경우 하단의 span #message-arrived는 보이지 않게 설정 필요 -->
					<span id="message-arrived"></span><br>
					<span id="loginMember"><c:out value="${loginMember.member_nick }님 접속을 환영합니다"/></span>
					<span class="login-area" onmouseover="dropDownMenu();">
					</span>
				</div>
			</c:if>
		</div>
		<div id="sub-menu-bar" onmouseleave="hideMenu();">
			<a href="${path }/member/memberView.do">
				<div class="sub-menu-detail" id="menu-mypage">내정보</div>
			</a>
			<!-- 만약 받은 쪽지가 없을 경우 하단의 span #message-icon 이미지 이 것 사용 <img src="https://i.ibb.co/4Z7wXR5/red-circle.png" width="13px"> -->
			<a href="javascript:fn_messageBox();">
				<div class="sub-menu-detail" id="menu-message">쪽지함
				<span class="badge bg-danger" id="msgCount"></span>
				</div>
				<form id="myIdData" action="${path}/message/messageBox.do" method="post" target="msgBox">
				  <input type="hidden" name="memberId" value="${loginMember.member_id}" id="memberId">
				</form>
			</a>
			<a href="${path}/board/myboardView.do?memberId=${loginMember.member_id}">
				<div class="sub-menu-detail" id="menu-myboard">내 게시글</div>
			</a>
			<a href="${path}/member/logout.do }">
				<div class="sub-menu-detail" id="menu-logout">로그아웃</div>
			</a>
		</div>
		<script>
        dropDownMenu = () => {
            let subMenuBar = document.getElementById('sub-menu-bar');
            subMenuBar.style.visibility = 'visible';

        }
        hideMenu = () => {
            document.getElementById('sub-menu-bar').style.visibility = 'hidden';
        }
		
        
        /* 부트스트랩 모달 추가 */
        var myModal = document.getElementById('myModal');
        var myInput = document.getElementById('myInput');
          
		
        if(myModal!=null && myInput!=null){
          myModal.addEventListener('shown.bs.modal', function () {
          myInput.focus();
          })
        }
        
        //쪽지함 새창으로 열기
        const fn_messageBox=()=>{
        	 $('#myIdData').attr("target", "msgBox");
        	 open("", "msgBox", "height=800, width=800, menubar=no, scrollbars=yes, resizable=no, toolbar=no, status=no, left=50, top=50");
        	$("#myIdData").submit();
		}
        
        
        

        //소켓 전역변수
        var socket = null;
        
        //로그인시 connectSocket함수 실행
		//$(document).ready(function(){
			if(${loginMember.member_id != null}){
				connectSocket();
			}
		//});
		
        //웹소켓 연결
	 	function connectSocket(){
			var sock = "http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/message";
			socket = new SockJS(sock);
			
			socket.onopen = onOpen;
			socket.onmessage = onMessage;
		
		 }; 
        
        
        

        
     // toast생성 및 추가
         function onMessage(evt){
        		//$("#liveToastBtn").click();
        		//$("#alimData").val(evt.data);
        		//$("#message-arrived").text(evt.data);
        		//alert(evt);
             var data = JSON.parse(evt.data);
            switch(data.type){
            
            case "message":
            	
            	//toast
                let toast = "<div class='position-fixed bottom-0 end-0 p-3' style='z-index: 11'>";
                toast += "<div id='liveToast' class='toast' role='alert' aria-live='assertive' aria-atomic='true'>";
                toast += "<div class='toast-header'><img width='30px' height='30px' src='data:image/png;base64,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' class='rounded me-2' alt='...'><strong class='me-auto'>알림</strong><small>just now</small><button type='button' class='btn-close' data-bs-dismiss='toast' aria-label='Close'></button></div>";
                toast += "<div class='toast-body' id='alimData'>"+data.sendNick+"님이 쪽지를 보냈습니다."+"</div></div></div>";
                $("#msgStack").append(toast);   // msgStack div에 생성한 toast 추가
                $(".toast").toast({"animation": true, "autohide": false});
                $('.toast').toast('show'); 
            
                let img1 = $("<img src='https://i.ibb.co/4Z7wXR5/2022-01-20-10-00-48.png' width='50px'>");
                $(".login-area").html("");
        		$(".login-area").append(img1);
				break;
            
            }
        };
        
        
        
        function onOpen(){
        	console.log('open');
        }
        
        
    	
        
        
       //로그인시 쪽지 갯수
	        if(${loginMember.member_id != null}){
	        	let img1 = $("<img src='https://i.ibb.co/4Z7wXR5/2022-01-20-10-00-48.png' width='50px'>");
	        	let img2 = $("<img src='https://i.ibb.co/vxM4TDk/2022-01-18-17-51-35.png' width='50px'>");
		        $.ajax({
		        	url:"${path}/message/msgCount.do",
		        	data:{"memberId":'${loginMember.member_id}'},
		        	dataType:"json",
		        	type:"post",
		        	success:data=>{
		        	 	if(data !=0) {
		        		$("#msgCount").text(data);
		        		$(".login-area").append(img1);

		        		} else {
		        			$(".login-area").append(img2);
		        		} 
		        	}
		        	
		        })
        	}
       
	        function msg(){
   				alert("로그인 후 이용가능합니다.");
	        };
   			
	    
        
    </script>
	</nav>
	
	 <div id="msgStack"></div>
	 
<!-- 	<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
	  <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
	    <div class="toast-header">
	      <img src="..." class="rounded me-2" alt="...">
	      <strong class="me-auto">알림</strong>
	      <small>just now</small>
	      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
	    </div>
	    <div class="toast-body" id="alimData">
	    </div>
	  </div>
	</div> -->
	
</header>



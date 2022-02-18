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
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
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
		<c:if test="${loginMember.member_black!=1 }">
		<div class="header-nav">
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
					<!-- 만약 받은 쪽지가 없을 경우 하단의 span .login-area의 이미지 주소는 https://i.ibb.co/vxM4TDk/2022-01-18-17-51-35.png 사용 필요 -->
					<span id="message-arrived"></span><br>
					<span id="loginMember"><c:out value="${loginMember.member_nick }님 접속을 환영합니다"/></span>
					<span class="login-area" onmouseover="dropDownMenu();">
						<img src="https://i.ibb.co/4Z7wXR5/2022-01-20-10-00-48.png" width="50px">
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
			/* open("${path}/message/messageBox.do","_blank","width=800,height=800"); */
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
		
			/* sock.onopen = function() {
		 		console.log('open');
		 	};  */
		 	//sock.onmessage = onMessage;
		 }; 
        
        
        

        
     // toast생성 및 추가
         function onMessage(evt){
        		console.log('onmessage');
        		alert(evt.data);
        		//alert(evt);
         /*    var data = evt.data;
            console.log(data);
            // toast
            let toast = "<div class='toast' role='alert' aria-live='assertive' aria-atomic='true'>";
            toast += "<div class='toast-header'><i class='fas fa-bell mr-2'></i><strong class='mr-auto'>알림</strong>";
            toast += "<small class='text-muted'>just now</small><button type='button' class='ml-2 mb-1 close' data-dismiss='toast' aria-label='Close'>";
            toast += "<span aria-hidden='true'>&times;</span></button>";
            toast += "</div> <div class='toast-body'>" + data + "</div></div>";
            $("#msgStack").append(toast);   // msgStack div에 생성한 toast 추가
            $(".toast").toast({"animation": true, "autohide": false});
            $('.toast').toast('show'); */
        };
        
        function onOpen(){
        	console.log('open');
        }
        
   /*      function onMessage(message){
        	console.log('onMessage'+message.data);
        	let socketAlert = $('span#message-arrived');
    		socketAlert.html(message.data)
    		socketAlert.css('display', 'block');
    		
    		setTimeout(function(){
    			$socketAlert.css('display','none');
    			
    		}, 5000);
        }; */
        
    	
    	
   /*  	sock.onclose = function() {
    	    console.log('close');
     	}; */
        
        
        
       //로그인시 쪽지 갯수
	        if(${loginMember.member_id != null}){
		        $.ajax({
		        	url:"${path}/message/msgCount.do",
		        	data:{"memberId":'${loginMember.member_id}'},
		        	dataType:"json",
		        	type:"post",
		        	success:data=>{
		        		$("#msgCount").text(data);
		        	}
		        	
		        })
		        $("#friendsSearch").on("click")
        	}
       
	        function msg(){
   				alert("로그인 후 이용가능합니다.");
	        };
   			
	    
        
    </script>
	</nav>
	
	 <div id="msgStack"></div>
	
</header>



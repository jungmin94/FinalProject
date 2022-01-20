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
<title>PAI</title>
<style>
header {
	position: absolute;
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
	margin-right: 8rem;
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
}

#mypage-icon {
	margin: 0;
	padding: 0;
	display: flex;
	align-items: center;
}

#nav-img {
	padding-left: 50px;
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
<header>
	<nav>
		<div class="header-nav">
			<div class="nav-lists" id="nav-img">
				<a href=""><img src="https://i.ibb.co/7kh6Yz5/Kakao-Talk-Photo-2022-01-15-17-58-47.jpg" width="60px" height="60px"></a>
			</div>

			<div id="nav-menu">
				<a href="${path}/board/boardList.do"><div class="menu-bar">게시판</div></a> 
				<a href=""><div class="menu-bar">MBTI 마켓</div></a>
				<a href=""><div class="menu-bar">채팅</div></a>
				<a href=""><div class="menu-bar">친구찾기</div></a>
			</div>
			<c:if test="${loginMember==null }">
			<!-- 만약 로그인하지 않은 상태라면 하단의 div #login-box출력 -->
		        <div id="login-box">
		            <span class="login-area"><button id="login-button" onclick="location.assign('${path}/views/member/loginMember')">로그인</button></span><span class="login-area"><button
		                    id="enroll-button">회원가입</button></span>
		        </div>
			</c:if>
			<c:if test="${!loginMember==null }">
				<div class="nav-lists" id="mypage-icon">
					<!-- 만약 받은 쪽지가 없을 경우 하단의 span #message-arrived는 보이지 않게 설정 필요 -->
					<!-- 만약 받은 쪽지가 없을 경우 하단의 span .login-area의 이미지 주소는 https://i.ibb.co/vxM4TDk/2022-01-18-17-51-35.png 사용 필요 -->
					<span id="message-arrived">쪽지가 도착했습니다!</span>
					<span class="login-area" onmouseover="dropDownMenu();">
						<img src="https://i.ibb.co/4Z7wXR5/2022-01-20-10-00-48.png" width="50px">
					</span>
				</div>
			</c:if>
		</div>
		<div id="sub-menu-bar" onmouseleave="hideMenu();">
			<a href="">
				<div class="sub-menu-detail" id="menu-mypage">내정보</div>
			</a>
			<!-- 만약 받은 쪽지가 없을 경우 하단의 span #message-icon 이미지 이 것 사용 <img src="https://i.ibb.co/4Z7wXR5/red-circle.png" width="13px"> -->
			<a href="">
				<div class="sub-menu-detail" id="menu-message">쪽지함
				<span id="message-icon"><img src="https://i.ibb.co/ZT0XhL5/2022-01-20-10-00-48.png" width="13px"></span><span id="message-count">1</span>
				</div>
			</a>
			<a href="">
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
        
    </script>
	</nav>
</header>
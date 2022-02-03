<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
#chat-list {
	background-color: rgb(2, 0, 92);
	width: 13%;
	min-height: 80.6%;
	position: absolute;
}

#chat-list a:link {
	text-decoration: none;
}

.chat-list-detail {
	padding-top: 30px;
	padding-bottom: 30px;
	color: white;
	text-align: center;
}

.chat-list-detail:hover {
	background-color: black;
}

.chat-list a {
	text-decoration: none;
}

#chat-info {
	text-align: center;
	position: absolute;
	top: 40%;
	left: 45%;
}

#chat-detail-info {
	margin-bottom: 10px;
}

button {
	width: 90px;
	height: 35px;
	border: 1px solid rgb(34, 44, 182);
	background-color: rgb(34, 44, 182);
	color: white;
	margin-top: 15px;
}
</style>
<section>
	<div>
		<div id="chat-list">
			<a href="${path }/chatting/toSeeChatroomInfo.do">
				<div class="chat-list-detail">MY MBTI CHAT</div>
			</a> <a href="">
				<div class="chat-list-detail">EVERY MBTI CHAT</div>
			</a>
		</div>
		<div id="chat-info">
			<div id="chat-detail-info">${loginMember.member_mbti}의, ${loginMember.member_mbti}에 의한, ${loginMember.member_mbti}를 위한 채팅방입니다.</div>
			<div>비속어를 사용 할 경우 경고 1회. 경고 3회 누적 시 강퇴입니다.</div>
			<div>
				<button onclick="location='${path}/chatting/toEnterChatroom.do'">채팅방 입장</button>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
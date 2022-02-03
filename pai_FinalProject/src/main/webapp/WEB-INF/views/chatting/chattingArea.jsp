<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>  
<style>
#chat-total-area {
	display: flex;
}

#chat-list {
	background-color: rgb(2, 0, 92);
	/* width: 13%; */
	/* min-height: 80.6%; */
	/* position: absolute; */
	flex: 0.6;
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

#chat-total-area {
	height: 650px;
}

#chat-every-area {
	flex-grow: 2;
}

#chat-area {
	/* flex-wrap: wrap; */
	/* position: fixed; */
	/*            
            display: inline;
            width: 100%;
            height: 50%;
            left: 20%; */
	/* position: sticky; */
	align-self: flex-start;
	width: 100%;
	height: 86%;
	overflow: scroll;
}

.chat-enter-message {
	/* width: 280%; */
	left: 0;
	flex-basis: 100%;
	text-align: center;
	padding: 20px;
}

.chat-box {
	text-align: left;
	background-color: rgb(240, 240, 240);
	padding: 12px;
	border-radius: 5px;
}

.chat-id-mbti {
	font-size: 13px;
	padding-bottom: 5px;
}

.chat-time {
	font-size: 13px;
	align-self: flex-end;
	padding: 5px;
}

.total-chat-box {
	display: flex;
	padding-bottom: 20px;
	padding-left: 9%;
}

.my-total-chat-box {
	display: flex;
	padding-bottom: 20px;
	padding-right: 9%;
}

.dm-total-chat-box {
	display: flex;
	padding-bottom: 20px;
	padding-left: 9%;
}

.dm-my-total-chat-box {
	display: flex;
	padding-bottom: 20px;
	padding-right: 9%;
}

.dm-msg {
	color: red;
	font-size: 12px;
	padding-left: 5px;
}

.my-chat-box {
	margin-left: auto;
	text-align: left;
	background-color: rgb(228, 236, 255);
	padding: 12px;
	border-radius: 5px;
}

#message-area {
	padding-top: 15px;
	padding-left: 9%;
}

#user {
	height: 23px;
	border-radius: 5px;
	border: 1px solid black;
}

#chat-uploadfile {
	margin-bottom: -7px;
	padding: 0;
}

#upload-file {
	display: none;
}

input:focus {
	outline: none;
}

::placeholder {
	color: gray;
	font-size: 12px;
}

#message-div {
	border: 1px solid black;
	margin-left: 5px;
	border-radius: 5px;
	height: 23px;
	width: 100%;
}

#send-div {
	margin-left: 5px;
}

#message {
	border: 0;
	margin-left: 5px;
	border-radius: 5px;
	height: 18px;
	width: 95%;
}

#message-option {
	padding-bottom: 10px;
}

#message-send-option {
	padding-right: 7px;
}

#chat-message-input {
	display: flex;
	width: 90%;
}

#send-message-btn {
	width: 60px;
	height: 27px;
	border-radius: 5px;
	border: none;
	background-color: rgb(221, 221, 221);
}

#chat-attendence-list {
	/* width: 13%; */
	right: 0.6%;
	background-color: rgb(240, 240, 240);
	text-align: center;
	flex: 0.6;
	overflow: scroll;
}

#chat-attendence-head {
	padding: 12px;
	margin-top: 10px;
}

.chat-attendence {
	padding: 5px;
}

.chat-attendence a {
	text-decoration: none;
	color: rgb(34, 44, 182);
}

.contextmenu {
	display: none;
	position: absolute;
	width: 100px;
	margin: 0;
	padding: 0;
	background: #FFFFFF;
	border-radius: 5px;
	list-style: none;
	box-shadow: 0 15px 35px rgba(50, 50, 90, 0.1), 0 5px 15px
		rgba(0, 0, 0, 0.07);
	overflow: hidden;
	z-index: 999999;
}

.contextmenu li {
	border-left: 3px solid transparent;
	transition: ease .2s;
}

.contextmenu li a {
	display: block;
	padding: 10px;
	color: black;
	font-size: 13px;
	text-decoration: none;
	transition: ease .2s;
}

.contextmenu li:hover {
	background: rgb(34, 44, 182);
	border-left: 3px solid rgb(2, 0, 92);
}

.contextmenu li:hover a {
	color: #FFFFFF;
}

.selected-id {
	display: none;
}
</style>
<section>
	<div id="chat-total-area">
		<div id="chat-list">
			<a href="">
				<div class="chat-list-detail">MY MBTI CHAT</div>
			</a> <a href="">
				<div class="chat-list-detail">EVERY MBTI CHAT</div>
			</a>
		</div>
		<div id="chat-every-area">
			<div id="chat-area">
				<!-- <div class="chat-enter-message">ddubi 님이 입장하였습니다. 모두 환영해주세요!</div>
				<div class="total-chat-box">
					<div class="chat-box">
						<div class="chat-id-mbti">boradori / ISFP</div>
						<div>안녕하세요 뚜비님?</div>
					</div>
					<div class="chat-time">15:59</div>
				</div>

				<div class="my-total-chat-box">
					<div class="my-chat-box">
						<div class="chat-id-mbti">ddubi / ISFP</div>
						<div>반가워요~~~</div>
					</div>
					<div class="chat-time">15:59</div>
				</div> -->
				<!-- <div class="dm-total-chat-box">
					<div class="chat-box">
						<div class="chat-id-mbti">
							boradori / ISFP<span class="dm-msg">(귓속말)</span>
						</div>
						<div>안녕하세요 뚜비님?</div>
					</div>
					<div class="chat-time">15:59</div>
				</div>
				<div class="dm-my-total-chat-box">
					<div class="my-chat-box">
						<div class="chat-id-mbti">
							ddubi / ISFP<span class="dm-msg">(귓속말)</span>
						</div>
						<div>반가워요~~~</div>
					</div>
					<div class="chat-time">15:59</div>
				</div> -->




			</div>

			<div id="message-area">
				<div id="message-option">
					<span id="message-send-option"> <span>받는 사람 : </span> <select
						name="messageUser" id="user">
							<option value="everyone">모두에게</option>
							<!-- <option value="boradori">boradori</option>
							<option value="ddubi">ddubi</option>
							<option value="nana">nana</option> -->
					</select>
					</span> <span id="chat-uploadfile"> <label for="upload-file">
							<img id="upload-file-img"
							src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeBtr7ihSssh94yDpW4xXAu5LKwD9EL-Mgwpc5ygTkD3IA0Bh4PH8dKGgfdSSw3ts6Lhg&usqp=CAU"
							width="17px" height="17px">
					</label> <input type="file" id="upload-file">
					</span> <span id="file-name-preview"> </span>
				</div>
				<div id="chat-message-input">
					<div id="message-div">
						<input type="text" id="message" placeholder="여기에 메시지 입력...">
					</div>
					<div id="send-div">
						<button id="send-message-btn" onclick="javascript:sendMsg()">전송</button>
					</div>
				</div>


			</div>
		</div>

		<div id="chat-attendence-list">
			<div id="chat-attendence-head">채팅방 접속자</div>
			<!-- <div class="chat-attendence">
				<a href="javascript:subMenu()" class="showSubMenu">boradori</a>
			</div>
			<div class="chat-attendence">
				<a href="#" class="showSubMenu">nana</a>
			</div>
			<div class="chat-attendence">
				<a href="#" class="showSubMenu">ddubi</a>
			</div> -->
		</div>
		<ul class="contextmenu">
			<li><a href="#">귓속말</a></li>
			<li><a href="#">신고하기</a></li>
		</ul>
		<input type="text" id="member-mbti" value="${loginMember.member_mbti}" style="display:none">
		<input type="text" id="member-id" value="${loginMember.member_id}" style="display:none">
	</div>

</section>
<script>
    //첨부이미지 파일 이름 보여주기
    const imagesPreview = function (input, placeToInsertImagePreview, id) {
        if (input.files) {
            var filesAmount = input.files.length;
            for (i = 0; i < 1; i++) {
                var reader = new FileReader();
                reader.onload = function (event) {
                    $($.parseHTML($("#" + id).val().replace(/.*(\/|\\)/, ''))).appendTo(placeToInsertImagePreview)
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    };

    $("input#upload-file").on('change', function () {
        imagesPreview(this, '#file-name-preview', 'upload-file');
    });
    let userMbti = $('#member-mbti').val();
    let userId = $('#member-id').val();
    
        window.onload=()=>{
            $('#chat-area').scrollTop($('#chat-area')[0].scrollHeight);
	        //Show contextmenu:
	        $('section').on('click', '.showSubMenu', function (e) {
	       
	        if (e.target.innerText != userId) {
	        	//Get window size:
	            var winWidth = $(document).width();
	            var winHeight = $(document).height();
	            //Get pointer position:
	            var posX = e.pageX;
	            var posY = e.pageY;
	            //Get contextmenu size:
	            var menuWidth = $(".contextmenu").width();
	            var menuHeight = $(".contextmenu").height();
	            //Security margin:
	            var secMargin = 10;
	            //Prevent page overflow:
	            if (posX + menuWidth + secMargin >= winWidth
	                && posY + menuHeight + secMargin >= winHeight) {
	                //Case 1: right-bottom overflow:
	                posLeft = posX - menuWidth - secMargin + "px";
	                posTop = posY - menuHeight - secMargin + "px";
	            }
	            else if (posX + menuWidth + secMargin >= winWidth) {
	                //Case 2: right overflow:
	                posLeft = posX - menuWidth - secMargin + "px";
	                posTop = posY + secMargin + "px";
	            }
	            else if (posY + menuHeight + secMargin >= winHeight) {
	                //Case 3: bottom overflow:
	                posLeft = posX + secMargin + "px";
	                posTop = posY - menuHeight - secMargin + "px";
	            }
	            else {
	                //Case 4: default values:
	                posLeft = posX + secMargin + "px";
	                posTop = posY + secMargin + "px";
	            };
	            //Display contextmenu:
	            $(".contextmenu").css({
	                "left": posLeft,
	                "top": posTop
	            }).show();
	            let userId = e.target.innerText;
	            let userIdLi = $(".contextmenu").append("<li class='selected-id'>"+userId+"</li>");
	            return false;	
	        }
            
        });
        //Hide contextmenu:
        $(document).click(function () {
            $(".contextmenu").hide();
        });
    };
    $('section').on('click','.contextmenu', function(e) {
        let target = e.target.parentNode.parentNode.children;
        let i = target.length;
        let ul = target[i - 1].innerText;
        $('span#message-send-option select').val(ul).change();
    });

    
    const socket=new SockJS("http://localhost:9090${pageContext.request.contextPath}/chatting");
    
	socket.onopen=e=>{
		const urlArray = socket._transport.url.split('/');
		const index = urlArray.length - 2;
		sessionid = urlArray[index];

		let enterMsg = {
				chatType:'enter',
				senderId:userId,
    			receiverId:"",
    			uploadFile:"",
    			chatTime:new Date(),
    			chatMessage:userId+' 님이 입장하였습니다.',
    			senderMbti:userMbti,
    			chatRoomName:userMbti
		}
		socket.send(JSON.stringify(enterMsg));
		
		$.post ({
				url : '/spring/chatting/getAttendenceList.do',
				data : {
					chatroomUser : userId,
					chatroomName : userMbti,
					chatUserMbti : userMbti
				},

				success : function(data) {
				   for (let i = 0; i < data.length; i++) {
					   let addDiv2 = "<div class='chat-attendence'><a href='#' class='showSubMenu'>"+data[i]+"</a></div>"
			        	$('#chat-attendence-list').append(addDiv2);
			    		
			    		
					   if (data[i] != userId) {
						   $('#user').append($('<option>', {
				    		    value: data[i],
				    		    text: data[i]
				    		})); 
					   }
					   
				   }
				}
		});
			
	
	}
	
    const sendMsg=()=>{
    	var inputMsg = document.getElementById("message").value;
    	let dm = $('#user').val();
    	
    	if (dm == 'everyone') {
    		const msg = {
        			chatType:'msgEveryone',
        			senderId:userId,
        			receiverId:"",
        			uploadFile:"",
        			chatTime:new Date(),
        			msg:inputMsg,
        			senderMbti:userMbti,
        			chatRoomName:userMbti
        			
        	}
        	socket.send(JSON.stringify(msg));	
    	} else {
    		const msg = {
        			chatType:'msgDm',
        			senderId:userId,
        			receiverId:dm,
        			uploadFile:"",
        			chatTime:new Date(),
        			msg:inputMsg,
        			senderMbti:userMbti,
        			chatRoomName:userMbti
        			
        	}
        	socket.send(JSON.stringify(msg));
    	}
    	
    }
    
    socket.onmessage = function(event) {
    	let msg = JSON.parse(event.data);
    	let msgTime = new Date();
    	if (msg.chatType=='enter') {//입장 시 
    		let addDiv = "<div class='chat-enter-message'>"+msg.chatMessage+"</div>"
        	$('#chat-area').append(addDiv);
        	$('#chat-area').scrollTop($('#chat-area')[0].scrollHeight);
    		
    	} else if (msg.chatType=='msgEveryone' && msg.senderId==userId) {//내가 모두에게 보내는 메시지
    		let addDiv = "<div class='my-total-chat-box'><div class='my-chat-box'><div class='chat-id-mbti'>"+msg.senderId+" / "+userMbti+"</div><div>"+msg.msg+"</div></div><div class='chat-time'>"+msgTime.getHours()+":"+msgTime.getMinutes()+"</div></div>"
        	$('#chat-area').append(addDiv);
        	$('#chat-area').scrollTop($('#chat-area')[0].scrollHeight);
    	} else if (msg.chatType=='msgDm' && msg.senderId==userId){//내가 귓속말로 보내는 메시지
    		let addDiv = "<div class='dm-my-total-chat-box'><div class='my-chat-box'><div class='chat-id-mbti'>"+msg.senderId+" / "+userMbti+"<span class='dm-msg'>(귓속말)</span></div><div>"+msg.msg+"</div></div><div class='chat-time'>"+msgTime.getHours()+":"+msgTime.getMinutes()+"</div></div>"
    		$('#chat-area').append(addDiv);
        	$('#chat-area').scrollTop($('#chat-area')[0].scrollHeight);
    	} else if (msg.chatType=='exit') {//퇴장 시
    		let addDiv = "<div class='chat-enter-message'>"+msg.senderId+" 님이 퇴장하였습니다.</div>"
        	$('#chat-area').append(addDiv);
    		$('#chat-area').scrollTop($('#chat-area')[0].scrollHeight);
    		 $.post ({
				url : '/spring/chatting/removeAttendenceList.do',
				data : {
					chatroomUser : msg.senderId,
					chatroomName : msg.chatRoomName,
					chatUserMbti : msg.chatRoomName
				},

				success : function(data) {
					
					$('#chat-attendence-head').siblings().remove();
					$('#user').children().remove();
					 $('#user').append($('<option>', {
			    		    value: 'everyone',
			    		    text: '모두에게'
			    		})); 
					
				   for (let i = 0; i < data.length; i++) {
					   let addDiv2 = "<div class='chat-attendence'><a href='#' class='showSubMenu'>"+data[i]+"</a></div>"
			        	$('#chat-attendence-list').append(addDiv2);
			    		
			    		if (data[i] != userId) {
						   $('#user').append($('<option>', {
				    		    value: data[i],
				    		    text: data[i]
				    		})); 
					   }   
				   }
				}
		});
    		
    	} else if (msg.chatType=='msgDm' && msg.senderId!=userId){//내가 귓속말을 받았을 때
    		let addDiv = "<div class='dm-total-chat-box'><div class='chat-box'><div class='chat-id-mbti'>"+msg.senderId+" / "+userMbti+"<span class='dm-msg'>(귓속말)</span></div><div>"+msg.msg+"</div></div><div class='chat-time'>"+msgTime.getHours()+":"+msgTime.getMinutes()+"</div></div>"
    		$('#chat-area').append(addDiv);
        	$('#chat-area').scrollTop($('#chat-area')[0].scrollHeight);
    	} else { //내가 전체 메시지를 받았을 때
    		let addDiv = "<div class='total-chat-box'><div class='chat-box'><div class='chat-id-mbti'>"+msg.senderId+" / "+userMbti+"</div><div>"+msg.msg+"</div></div><div class='chat-time'>"+msgTime.getHours()+":"+msgTime.getMinutes()+"</div></div>"
        	$('#chat-area').append(addDiv);
        	$('#chat-area').scrollTop($('#chat-area')[0].scrollHeight);
    	}
    	
    	
    }
    	
    
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
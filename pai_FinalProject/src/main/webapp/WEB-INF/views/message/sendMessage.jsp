<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지보내기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
<form id="sendMessage" action="" method="post">
  <div class="mb-3 row">
  	<h2>쪽지 보내기</h2>
    <label for="msg_title" class="col-sm-2 col-form-label badge bg-secondary">제목</label>
    <div class="col-sm-10">
      <input type="text" name="msgTitle" class="form-control" id="msgTitle">
    </div>
  </div>
  
  <div class="mb-3 row">
  <label for="send_nick" class="col-sm-2 col-form-label badge bg-secondary">보낸사람</label>
    <div class="col-sm-10">
      <input type="text" class="form-control-plaintext" id="sendNick" value="${loginMember.member_nick}" readonly>
      <input type="hidden" name="sendId" id="sendId" value="${loginMember.member_id}">
    </div>
  </div>
  
  <div class="mb-3 row">
    <label for="recv_nick" class="col-sm-2 col-form-label badge bg-secondary">받는사람</label>
    <div class="col-sm-10">
      <input type="text" class="form-control-plaintext" id="recvNick" value="${param.member_nick }" readonly>
      <input type="hidden" name="recvId" id="recvId" value="${param.member_id }"/>
    </div>
  </div>
    
  <div class="mb-3 row">
    <label for="msg_content" class="col-sm-12 col-form-label badge bg-secondary">내용</label>
    <div class="col-sm-12">
      <textarea class="form-control" name="msgContent" id="msgContent" rows="5" cols="30">디자인은 나중에 수정예정</textarea>
    </div>
  </div>

	<button class="btn btn-primary" id="btnSend">보내기</button>
	<div id="container">
	</div>

</form>

	
<script>
//전역변수 설정
var socket  = null;
$(document).ready(function(){
    // 웹소켓 연결
    sock = new SockJS("http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/message");
    socket = sock;

    // 데이터를 전달 받았을때 
    sock.onmessage = onMessage; // toast 생성
    ...
});



//toast생성 및 추가
function onMessage(evt){
    var data = evt.data;
    // toast
    let toast = "<div class='toast' role='alert' aria-live='assertive' aria-atomic='true'>";
    toast += "<div class='toast-header'><i class='fas fa-bell mr-2'></i><strong class='mr-auto'>알림</strong>";
    toast += "<button type='button' class='ml-2 mb-1 close' data-dismiss='toast' aria-label='Close'>";
    toast += "<span aria-hidden='true'>&times;</span></button>";
    toast += "</div> <div class='toast-body'>" + $("#sendNick")님에게 쪽지가 도착했습니다. + "</div></div>";
    $("#msgStack").append(toast);   // msgStack div에 생성한 toast 추가
    $(".toast").toast({"animation": true, "autohide": false});
    $('.toast').toast('show');
};

function sendMsg(){
		var msg = {
			type:"message",
			sendId:"${loginMember.member_id}",
			recvId:"${param.member_id }",
			msgTitle:$("#msgTitle").val(),
			msgContent:$("#msgContent").val()
		};
		socket.send(JSON.stringify(msg));
	}


 	const socket;
 	var memberId = "${loginMember.member_id}"; // sendId
 	
 	function connect(){
 		socket = new SockJS("http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/message");
 		
 		socket.onopen = function(){
 			console.log("open");
 			register();
 		};
 		
 		socket.onmessage = function(e){
 			console.log("onmessage");
			var data = e.data;
			addMsg(data);
 			
 		};
 		
 		socket.onclose = function(){
 			console.log("close");
 		};
 		
 		
 		function register(){
 			var msg = {
 					type:"register",
 					sendId:"${loginMember.member_id}"
 			};
 			socket.send(JSON.stringify(msg));
 		}
 		
 		function sendMsg(){
 			var msg = {
				type:"message",
				target:"${param.member_id }",
				message:$("#msgContent").val()
 			};
 			socket.send(JSON.stringify(msg));
 		}
 		
 		$(function(){
 			connect();
 			$('#btnSend').on("click",function()){
 				var chat 
 			}
 		});
 		
 		
 	}
 	

	
	
	


	
</script>

</body>
</html>
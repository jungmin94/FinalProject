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
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>

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

	<button class="btn btn-primary" onclick="sendMsg();">보내기</button>
	<div id="container">
	</div>

</form>

	
<script>
 	const socket = new SockJS("http://localhost:9090${pageContext.request.contextPath}/message");	
	socket.onopen=e=>{
	 	console.log(e);
	}
	const sendMsg=()=>{
		socket.send(JSON.stringify({"sendId":'${loginMember.member_id}',"recvId":$("#recvId").val(),
				"msgTitle":$("#msgTitle").val(), "msgContent":$("#msgContent").val()}));
	}
	socket.onmessage=message=>{
		console.log(message.data);

		
	} 
/* 	var socket = null;
	function connect(){
		var ws = new WebSocket("ws://localhost:9090{pageContext.request.contextPath}/message");
		socket = ws;
	
	
	    ws.onopen = function () {
	        console.log('Info: connection opened.');
	    };
	
	
	    ws.onmessage = function (event) {
	        console.log(event.data+'\n');
	    };
	
	
	    ws.onclose = function (event) { 
	    	console.log('Info: connection closed.'); 
	        //setTimeout( function(){ connect(); }, 1000); // retry connection!!
	    };
	    ws.onerror = function (err) { console.log('Error: ', err); };
			
	}
    
    $('#btnSend').on('click', function(evt) {
	  evt.preventDefault();
  if (socket.readyState !== 1) return;
    	  let msg = $('input#msg').val();
    	  ws.send(msg);
    }); */

	
</script>

</body>
</html>
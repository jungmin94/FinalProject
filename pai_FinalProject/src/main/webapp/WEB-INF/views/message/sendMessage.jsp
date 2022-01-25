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
  <div class="mb-3 row">
  	<h2>쪽지 보내기</h2>
    <label for="msg_title" class="col-sm-2 col-form-label badge bg-secondary">제목</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="msg_title">
    </div>
  </div>
  
  <div class="mb-3 row">
  <label for="send_nick" class="col-sm-2 col-form-label badge bg-secondary">보낸사람</label>
    <div class="col-sm-10">
      <input type="text" readonly class="form-control-plaintext" id="send_nick" value="${loginMember.member_nick}">
    </div>
  </div>
  
  <div class="mb-3 row">
    <label for="recv_nick" class="col-sm-2 col-form-label badge bg-secondary">받는사람</label>
    <div class="col-sm-10">
      <input type="text" readonly class="form-control-plaintext" id="recv_nick" value="받는사람 닉네임">
    </div>
  </div>
    
  <div class="mb-3 row">
    <label for="msg_content" class="col-sm-12 col-form-label badge bg-secondary">내용</label>
    <div class="col-sm-12">
      <textarea class="form-control" id="msg_content" rows="5" cols="30"></textarea>
    </div>
  </div>

	<button class="btn btn-primary" onclick="sendMsg();">보내기</button>
	<div id="container">

<!-- 	<div class="well">
		<input type="text" id="msg" value="1212" class="form-control"/>
		<button id="btnSend" class="btn btn-primary">send message</button>
	</div> -->
	
	
	</div>
	
<!-- 	<div class="container">
<h3 class=" text-center">Messaging</h3>
<div class="messaging">
      <div class="inbox_msg">

        <div class="mesgs">
          <div class="msg_history">
            <div class="incoming_msg">
              <div class="incoming_msg_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
              <div class="received_msg">
                <div class="received_withd_msg">
                  <p>Test which is a new approach to have all
                    solutions</p>
                  <span class="time_date"> 11:01 AM    |    June 9</span></div>
              </div>
            </div>
            <div class="outgoing_msg">
              <div class="sent_msg">
                <p>Test which is a new approach to have all
                  solutions</p>
                <span class="time_date"> 11:01 AM    |    June 9</span> </div>
            </div>
            <div class="incoming_msg">
              <div class="incoming_msg_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
              <div class="received_msg">
                <div class="received_withd_msg">
                  <p>Test, which is a new approach to have</p>
                  <span class="time_date"> 11:01 AM    |    Yesterday</span></div>
              </div>
            </div>
            <div class="outgoing_msg">
              <div class="sent_msg">
                <p>Apollo University, Delhi, India Test</p>
                <span class="time_date"> 11:01 AM    |    Today</span> </div>
            </div>
            <div class="incoming_msg">
              <div class="incoming_msg_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
              <div class="received_msg">
                <div class="received_withd_msg">
                  <p>We work directly with our designers and suppliers,
                    and sell direct to you, which means quality, exclusive
                    products, at a price anyone can afford.</p>
                  <span class="time_date"> 11:01 AM    |    Today</span></div>
              </div>
            </div>
          </div>
          <div class="type_msg">
            <div class="input_msg_write">
              <input type="text" class="write_msg" placeholder="Type a message" />
              <button class="msg_send_btn" type="button"><i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>
            </div>
          </div>
        </div>
      </div>
    </div></div> -->



<!-- 
<script>
$(document).ready(	function() {
	// var $boxFooter = $("section.content div.box-footer");
	$('#btn-remove-read').on('click', function() {
		if (confirm("Are u sure??")) {
			self.location.href = "/board/remove${criteria.makeQuery()}&bno=${board.bno}";
		}
	});
	
	listPage(1, '${board.bno}'); // QQQ
	gBno = '${board.bno}';
	gBoardWriter = '${board.writer}';
	//$('#myModal').modal('show');
	
    showAttaches(${board.bno});	
    
    gIsDirect = true;
    
    $('#btnSend').on('click', function(evt) {
    	evt.preventDefault();
    	if (socket.readyState !== 1) return;
    	
   	    let msg = $('input#msg').val();
   	    socket.send(msg);
   	});
    connect();
    
});
</script> -->
	
	
<script>
 	const socket = new SockJS("http://localhost:9090${pageContext.request.contextPath}/message");	
	socket.onopen=e=>{
	 	console.log(e);
	}
	const sendMsg=()=>{
		socket.send(JSON.stringify({"발신인":'${loginMember.member_id}',"제목":$("#msg_title").val(), "내용":$("#msg_content").val()}));
	}
	socket.onmessage=message=>{
		console.log(message.data);
		console.log(message.timeStamp);
		$("#container").append($("<h4>").html(message.data+"<sub>"+new Date(message.timeStamp)+"</sub>"));
		
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
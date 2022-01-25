<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지보내기</title>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
	<input id="msg" type="text"/><button onclick="sendMsg();">전송</button>
	<div id="container">
	<input id="memberId">
<!-- 	<table>
		<tbody>
			<tr><th>쪽지 보내기</th></tr>
			<tr><td>제목 : </td><td><input id="msgTitle" name="msgTitle" type="text"/></td></tr>
			<tr><td>보낸사람 : </td><td></td></tr>
			<tr><td>받는사람 : </td><td></td></tr>
		</tbody>
	</table> -->
	<div class="well">
		<input type="text" id="msg" value="1212" class="form-control"/>
		<button id="btnSend" class="btn btn-primary">send message</button>
	</div>
	
	
	</div>

<script type="text/x-handlebars-template" class="modal fade" id="myModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">댓글 {{#if gIsEdit}}수정{{else}}등록{{/if}}</h4>
      </div>
      <div class="modal-body">
        <div>
            작성자
            <input type="text" name="replyer" id="replyer" onkeyup="checkEdit()"
             value="{{replyer}}" {{#if gIsEdit}}readonly{{/if}} class="form-control" readonly />
        </div>
        <div class="mt10">
            내용<textarea name="replytext" id="replytext" onkeyup="checkEdit()" rows="3" class="form-control">{{replytext}}</textarea>
        </div>
      </div>
      <div class="modal-footer">
        <button onclick="save()" id="btnModReply" class="btn btn-primary">
          {{#if gIsEdit}}
            수정
          {{else}}
            등록
          {{/if}}
        </button>
        {{#if gIsEdit}}
            <button onclick="removeReply()" id="btnDelReply" class="btn btn-danger">삭제</button>
        {{/if}}
        <button onclick="closeMod()" id="btnCloseReply" class="btn btn-default">닫기</button>
      </div>
    </div>
  </div>
</script>


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
</script>
	
	
<script>
/* 	const socket = new SockJS("http://localhost:9090${pageContext.request.contextPath}/message");	
	socket.onopen=e=>{
	 	console.log(e);
		$("#container").append($("<h3>").html("쪽지 보내기"));
		
	}
	const sendMsg=()=>{
		socket.send(JSON.stringify({"발신인":'${loginMember.member_id}',"내용":$("#msg").val()}));
	}
	socket.onmessage=message=>{
		console.log(message.data);
		console.log(message.timeStamp);
		$("#container").append($("<h4>").html(message.data+"<sub>"+new Date(message.timeStamp)+"</sub>"));
		
	} */
	var socket = null;
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
    });

	
</script>

</body>
</html>
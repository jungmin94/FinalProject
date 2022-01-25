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
<!-- 	<table>
		<tbody>
			<tr><th>쪽지 보내기</th></tr>
			<tr><td>제목 : </td><td><input id="msgTitle" name="msgTitle" type="text"/></td></tr>
			<tr><td>보낸사람 : </td><td></td></tr>
			<tr><td>받는사람 : </td><td></td></tr>
		</tbody>
	</table> -->
	</div>
	
	
<script>
	const socket = new SockJS("http://localhost:9090${pageContext.request.contextPath}/message");	
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
		
	}
	
</script>

</body>
</html>
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
<title>쪽지함</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div id="header-container">		
		<h2>받은쪽지함</h2>
	</div>
	<div id="searchMessage">
	</div>
	<div id="recvMsg">
		<table class="table table-hover">
			<thead>
				<tr>
					<th scope="col">체크박스</th>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">보낸사람</th>
					<th scope="col">날짜</th>
				</tr>
			</thead>
			<tbody>
		 		<c:forEach var="m" items="${list }">	
					<tr onclick='recvMsgView(this);' style='text-align:center'>
						<td><input class="form-check-input" type="checkbox" value="" id="flexCheckDefault"></td>
						<td><c:out value="${m.MSGNO }"/></td>
						<td><c:out value="${m.MSGTITLE }"/></td>
						<td><c:out value="${m.SENDNICK}"/></td>
						<td><c:out value="${m.MSGSENDTIME}"/></td>
						<%-- <td><fmt:formatDate type="both" pattern="yyyy년 MM월 dd일 (E) hh:mm" value="${m.MSGSENDTIME}"/></td> --%>
					</tr>
				</c:forEach>

			</tbody>
		</table>
		 <div id="pageBar">
	        	${pageBar }
	     </div>
		</div>
		<div id="recvMsgDetail">
		</div>

</body>

<script>

function recvMsgView(e){
	$("#recvMsg").hide();
	let val = $(e).children();
	let msgNo = val.eq(1).text();
	$.ajax({
		url:"${path}/message/recvMsgDetail.do",
		type: "post",
		data: {"msgNo":msgNo},
		dataType: "json",
		success: data => {
			const table=$('<table>').attr("class","table");
			let thead=$("<thead>");
			let tbody=$('<tbody>');
			let tr=$("<tr>");
			let th1=$("<th>").html("제목").attr("scope","col");
			let msgTitle = $("<td>").html(data["MSGTITLE"]);
			
			let tr2=$("<tr>");
			let th2=$("<th>").html("보낸사람").attr("scope","col");
			let sendNick = $("<td>").html(data["SENDNICK"]);
			let sendId = $("<input>").attr({type:"hidden",name:"sendId",id:"sendId",value:data["SENDID"]});
			let th3=$("<th>").html("보낸시간").attr("scope","col");
			let msgSendTime = $("<td>").html(data["MSGSENDTIME"]);
			
			let tr3=$("<tr>");
			let th4=$("<th>").html("받는사람").attr("scope","col");
			let recvNick = $("<td>").html(data["RECVNICK"]);
			let th5=$("<th>").html("받은날짜").attr("scope","col");
			let msgReadCheck = $("<td>").html("읽지않음");
			let msgReadTime = $("<td>").html(data["MSGREADTIME"]);
			
			let msgContent = $("<td>").html(data["MSGCONTENT"]);
		/* 	if(data[MSGREADTIME]==null){
				msgReadTime = $("<input>").attr({type:"text",name:"msgReadTime",id:"msgReadTime",value:"읽지않음"});
			} else{
			} */
			
			let tr4=$("<tr>");
			thead.append(tr);
			tr.append(th1).append(msgTitle);
			thead.append(tr2);
			tr2.append(th2).append(sendNick);
			tr2.append(th3).append(msgSendTime);
			thead.append(tr3);
			tr3.append(th4).append(recvNick);
			if(data["MSGREADTIME"]==null){
				tr3.append(th5).append(msgReadCheck);
			} else{
				tr3.append(th5).append(msgReadTime);
			}
			tbody.append(msgContent);
			table.append(thead);
			table.append(tbody);
			$("#recvMsgDetail").html(table);
		}
	});
}

</script>
</html>
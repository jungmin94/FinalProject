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
		<ul class="nav">
			<li class="nav-item"><a class="nav-link active" aria-current="page" href="#" onclick="recvMsgBox();">받은쪽지함</a></li>
			<li class="nav-item"><a class="nav-link" href="#" onclick="sendMsgBox();">보낸쪽지함</a></li>
		</ul>
	</div>
	<div id="searchMessage">
		<form action="#">
			<select name="searchType">
				<option value="msg_title">제목</option>
				<option value="send_id">보낸사람</option>
			</select>
		
			<input type="text" name="keyword"/>

			<input type="date" id="startDate" name="startDate">~
			<input type="date" id="endDate" name="endDate">

			<input type="submit" value="검색"/>
		</form>
	</div>
	
	<div id="body-container">
		<%-- <table class="table table-hover">
			<thead>
				<tr style='text-align:center'>
					<th scope="col"><input class="form-check-input" type="checkbox" name="msgCheck" value='selectall' id="flexCheckDefault" onclick='selectAll(this)'></th>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">보낸사람</th>
					<th scope="col">날짜</th>
				</tr>
			</thead>
			<tbody>
		 		<c:forEach var="m" items="${list }" varStatus="status">
					<tr style='text-align:center'>
						<td><input class="form-check-input" type="checkbox" name="msgCheck" value="${m.MSGNO }" id="flexCheckDefault"></td>
						<td><c:out value="${status.count }"/></td>
						<td>
							<a onclick='recvMsgView(this);'>
							<c:out value="${m.MSGTITLE }"/>
							<input type="hidden" value="${m.MSGNO }">
	           				</a>
						</td>
						<td><c:out value="${m.SENDNICK}"/></td>
						<td><c:out value="${m.MSGSENDTIME}"/></td>
						<td><fmt:formatDate type="both" pattern="yyyy년 MM월 dd일 (E) hh:mm" value="${m.MSGSENDTIME}"/></td>
					</tr>
				</c:forEach>
		 		<c:if test="${empty list}">
					<tr>
						<td colspan="5" style="text-align:center;"><p>받은쪽지가 없습니다.</p></td>
					</tr>
				</c:if>	

			</tbody>
		</table> --%>
		</div>
		
     		<div id="pageNavContainer" style="display: flex; justify-content: center; margin-top: 15px; ">
     		</div>
			<div id="deleteMsg">
			</div>
		<div id="recvMsgDetail">
		</div>
	
	<!-- 받은편지 삭제 -->
	<form action="${path}/message/deleteRecvMsg.do" method="post" id="delete_recvMsg_frm">
		<div id="exampleModal" class="modal" tabindex="-1">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">정말 삭제하시겠습니까?</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary">예</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
		      </div>
		    </div>
		  </div>
		</div>
	</form>
</body>

<script>

$(document).ready(()=>{
	recvMsgBox();
});


//보낸편지함 전체선택
function selectAllSendMsg(e)  {
	  const checkboxes = document.getElementsByName('sendMsgCheck');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = e.checked;
	  })
};

//받은편지함 전체선택
function selectAllRecvMsg(e)  {
	  const checkboxes = document.getElementsByName('recvMsgCheck');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = e.checked;
	  })
};



//받은편지함 전체조회
function recvMsgBox(cPage){
	//$("#sendMsg").hide();
	//$("#recvMsgDetail").hide();
	//$("#pageNavContainer").hide();
	//$("#recvMsg").show();
	var num=1;

	$.ajax({
		url:"${path}/message/recvBox.do",
		type: "post",
		data: {"memberId":"${param.memberId}", cPage:cPage},
		dataType: "json",
		success: data => {
			$("#pageNavContainer").html("");
			$("#body-container").html("");
			const recvMsgList = data["list"];
			
			const table=$('<table>').attr("class","table table-hover");
			let thead=$("<thead>");
			let tbody=$('<tbody>');
			let tr1=$("<tr>").css("text-align","center");
			let th1=$("<th>");
			let checkAll = $("<input>").attr({class:"form-check-input", type:"checkbox", name:"recvMsgCheck", onclick:'selectAllRecvMsg(this)'});
			let th2=$("<th>").html("번호").attr("scope","col");
			let th3=$("<th>").html("제목").attr("scope","col");
			let th4=$("<th>").html("보낸사람").attr("scope","col");
			let th5=$("<th>").html("날짜").attr("scope","col");
			
			table.append(thead);
			thead.append(tr1);
			tr1.append(th1).append(th2).append(th3).append(th4).append(th5);
			th1.append(checkAll);
			
			
			if(recvMsgList.length==0){
				let tr2 = $("<tr>").css("text-align","center");
				let ntd=$("<td>").html("받은쪽지가 없습니다.");
				ntd.attr("colspan","5");
				tr2.append(ntd);
				tbody.append(tr2);
				table.append(tbody);
			} else{
				
				for(let i=0; i<recvMsgList.length; i++){
					let tr2 = $("<tr>").css("text-align","center");
					let td1 = $("<td>");
					let check = $("<input>").attr({class:"form-check-input", type:"checkbox", name:"recvMsgCheck", value:recvMsgList[i]["MSGNO"]});
					//let msgNo = $("<td>").html(((cPage-1)*10)+i+1);
					let no = $("<td>").html(num++);
					if(cPage>=2){
						no = $("<td>").html(((cPage-1)*10)+i+1);
					}
			/* 		let a = $("<a>").on("click", function(){
						recvMsgView(this);
					}); */
					let msgTitle = $("<td onClick='recvMsgView(this);'>").html(recvMsgList[i]["MSGTITLE"]);
					let msgNo = $("<input>").attr({type:"hidden", value:recvMsgList[i]["MSGNO"]});
					msgTitle.append(msgNo);
					
					let sendNick = $("<td>").html(recvMsgList[i]["SENDNICK"]);
					let msgSendTime = $("<td>").html(recvMsgList[i]["MSGSENDTIME"]);
					tbody.append(tr2);
					table.append(tbody);
					tr2.append(td1).append(no).append(msgTitle).append(sendNick).append(msgSendTime);
					td1.append(check);
				}
				let del = $("<button>").attr({type:"button", id:"delRecvMsg", class:"btn btn-primary", 'data-bs-toggle':"modal", 'data-bs-target':"#exampleModal"}).html("삭제");
				table.append(del);
			}
			const div=$("<div style='text-align:center;'>").attr("id","pageBar3").html(data["pageBar"]);
			$("#pageNavContainer").append(div);
			$("#body-container").html(table);
			
			$("#delRecvMsg").click(){
				
			}
			//삭제,목록버튼 생성해야함
		}
	});
	
	
	
};

//보낸편지함
function sendMsgBox(cPage){
	//$("#recvMsg").hide();
	//$("#recvMsgDetail").hide();
	//$("#pageNavContainer").show();
	//$("#sendMsg").show();
	var num=1;
	
	$.ajax({
		url:"${path}/message/sendMsg.do",
		type: "post",
		data: {"sendId":"${param.memberId}", cPage:cPage},
		dataType: "json",
		success: data => {
			$("#body-container").html("");
			$("#pageNavContainer").html("");
			const sendMsgList = data["list"];
			
			const table=$('<table>').attr("class","table table-hover");
			let thead=$("<thead>");
			let tbody=$('<tbody>');
			let tr1=$("<tr>").css("text-align","center");
			let th1=$("<th>");
			let checkAll = $("<input>").attr({class:"form-check-input", type:"checkbox", name:"sendMsgCheck", onclick:'selectAllSendMsg(this)'});
			let th2=$("<th>").html("번호").attr("scope","col");
			let th3=$("<th>").html("제목").attr("scope","col");
			let th4=$("<th>").html("받는사람").attr("scope","col");
			let th5=$("<th>").html("날짜").attr("scope","col");
			
			table.append(thead);
			thead.append(tr1);
			tr1.append(th1);
			th1.append(checkAll);
			tr1.append(th2).append(th3).append(th4).append(th5);
			
			
			if(sendMsgList.length==0){
				let tr2 = $("<tr>").css("text-align","center");
				let ntd=$("<td>").html("보낸쪽지가 없습니다.");
				ntd.attr("colspan","5");
				tr2.append(ntd);
				tbody.append(tr2);
				table.append(tbody);
			} else{
				
				for(let i=0; i<sendMsgList.length; i++){
					let tr2 = $("<tr>").css("text-align","center");
					let td1 = $("<td>");
					let check = $("<input>").attr({class:"form-check-input", type:"checkbox", name:"sendMsgCheck", value:sendMsgList[i]["MSGNO"]});
					//let msgNo = $("<td>").html(sendMsgList[i]["MSGNO"]);
					let no = $("<td>").html(num++);
					if(cPage>=2){
						no = $("<td>").html(((cPage-1)*10)+i+1);
					}					
					let msgTitle = $("<td onClick='recvMsgView(this);'>").html(sendMsgList[i]["MSGTITLE"]);
					let msgNo = $("<input>").attr({type:"hidden", value:sendMsgList[i]["MSGNO"]});
					msgTitle.append(msgNo);
					
					let recvId = $("<td>").html(sendMsgList[i]["RECVNICK"]);
					let msgSendTime = $("<td>").html(sendMsgList[i]["MSGSENDTIME"]);
					tbody.append(tr2);
					table.append(tbody);
					tr2.append(td1).append(no).append(msgTitle).append(recvId).append(msgSendTime);
					td1.append(check);
				}
			}
			
			const pageBar=$("<div style='text-align:center;'>").attr("id","pageBar2").html(data["pageBar"]);
			$("#pageNavContainer").append(pageBar);
			//$("#pageNavContainer").show();
			$("#body-container").html(table);
			//삭제,목록버튼 생성해야함
		}
	});

};


//시작 날짜 
$("#startDate").change(e=>{
   startDate = $("#startDate").val();
   let startDateArr = startDate.split("-");
   let endDateArr = endDate.split("-");
	 
   let startDateCompare = new Date(startDateArr[0], parseInt(startDateArr[1])-1, startDateArr[2]);
   let endDateCompare = new Date(endDateArr[0], parseInt(endDateArr[1])-1, endDateArr[2]);
   if(startDateCompare.getTime() > endDateCompare.getTime()) {
       alert("시작날짜와 종료날짜를 확인해 주세요.");
       $("#startDate").val(new Date().toISOString().substring(0, 10));
       $("#startDate").focus();
       return false;
   }
});      

//마감 날짜

$("#endDate").change(e=>{
   endDate = $("#endDate").val();
   let startDateArr = startDate.split("-");
   let endDateArr = endDate.split("-");
	 
   let startDateCompare = new Date(startDateArr[0], parseInt(startDateArr[1])-1, startDateArr[2]);
   let endDateCompare = new Date(endDateArr[0], parseInt(endDateArr[1])-1, endDateArr[2]);
   if(startDateCompare.getTime() > endDateCompare.getTime()) {
       alert("시작날짜와 종료날짜를 확인해 주세요.");
       $("#endDate").val(new Date().toISOString().substring(0, 10));
       $("#endDate").focus();
       return false;
   }
});


//보낸편지 상세보기
function recvMsgView(e){
	//$("#recvMsg").hide();
	//let val = $(e).children();
	//let msgNo = val.eq(1).text();
	let msgNo = $(e).children().val();
	$.ajax({
		url:"${path}/message/recvMsgDetail.do",
		type: "post",
		data: {"msgNo":msgNo},
		dataType: "json",
		success: data => {
			$("#body-container").html("");
			$("#pageNavContainer").html("");
			
			const table=$('<table>').attr("class","table");
			let thead=$("<thead>");
			let tbody=$('<tbody>');
			let tr=$("<tr>");
			let th1=$("<th>").html("제목").attr({scope:"col", colspan:"2"});
			let msgTitle = $("<td>").html(data["MSGTITLE"]).attr("colspan","2");
			
			let tr2=$("<tr>");
			let th2=$("<th>").html("보낸사람").attr("scope","col");
			let sendNick = $("<td>").html(data["SENDNICK"]);
			let sendId = $("<input>").attr({type:"hidden",name:"sendId",id:"sendId",value:data["SENDID"]});
			let th3=$("<th>").html("보낸시간").attr("scope","col");
			let msgSendTime = $("<td>").html(data["MSGSENDTIME"]);
			let tr3=$("<tr>");
			let th4=$("<th>").html("받는사람").attr("scope","col");
			let recvNick = $("<td>").html(data["RECVNICK"]);
			let th5=$("<th>").html("받은시간").attr("scope","col");
			let msgReadCheck = $("<td>").html("읽지않음");
			let msgReadTime = $("<td>").html(data["MSGREADTIME"]);
			
			let tr4=$("<tr>");
			let msgContent = $("<td>").html(data["MSGCONTENT"]);
			
			thead.append(tr).append(tr2).append(tr3);
			
			tr.append(th1).append(msgTitle);
			
			tr2.append(th2).append(sendNick);
			tr2.append(th3).append(msgSendTime);
			
			tr3.append(th4).append(recvNick);
			if(data["MSGREADTIME"]==null){
				tr3.append(th5).append(msgReadCheck);
			} else{
				tr3.append(th5).append(msgReadTime);
			}
			tbody.append(tr4);
			tr4.append(msgContent);
			
			table.append(thead);
			table.append(tbody);
			$("#body-container").html(table);
			//답장,삭제,목록버튼 생성해야함
		}
	});
};

</script>
</html>
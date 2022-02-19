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
			<li class="nav-item"><a class="nav-link" href="#" onclick="saveMsgBox();">쪽지보관함</a></li>
		</ul>
	</div>
	<div id="searchMessage">
 		<form id="searchMsg" action="#">
			<select name="searchType">
				<option value="msg_title">제목</option>
				<option value="send_id">보낸사람</option>
			</select>
		
			<input type="text" name="keyword"/>

			<input type="date" id="startDate" name="startDate">~
			<input type="date" id="endDate" name="endDate">

			<!-- <input type="submit" value="검색"/> -->
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
			<div id="eventButton" style="display: inline-block; margin: 0 5px; float: right;">
			</div>
		<div id="recvMsgDetail">
		</div>
	
	<!-- 받은편지 삭제 -->
<%-- 	<form action="${path}/message/deleteRecvMsg.do" method="post" id="delete_recvMsg_frm">
		<div id="exampleModal" class="modal" tabindex="-1">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">정말 삭제하시겠습니까?</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      	<input type="text" id="selectRecvMsg" name="msgNo[]">
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary">예</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
		      </div>
		    </div>
		  </div>
		</div>
	</form> --%>
	
<!-- 답장보내기 모달창 -->
	<div class="modal fade" id="MsgForm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content ">
                <div class="modal-header">
                <h5 class="modal-title">쪽지 보내기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form class="msg_form" method="post">
                    <input type="hidden" id="flag" name="flag" value="insert"/>
                    <div class="modal-body fn-font">
                        <table>
                            <colgroup>
                                <col style="width:150px;"/>
                                <col style="width:px;"/>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>보낸 사람</th>
                                    <th>
                                    	<input type="text" class="form-control-plaintext" name="sendNick" id="sendNick" value="${loginMember.member_nick}" readonly/>
                                    	<input type="hidden" name="sendId" id="sendId" value="${loginMember.member_id}">
                                    </th>
                                </tr>
                                <tr>
                                    <th>받는 사람</th>
                                    <th>
                                    	<input type="text" class="form-control-plaintext" name="recvNick" id="recvNick" readonly/>
                                    	<input type="hidden" name="recvId" id="recvId">
                                   	</th>
                                </tr>
                                <tr>
                                    <th>제목</th>
                                    <th><input type="text" name="msgTitle" class="form-control" id="msgTitle"></th>
                                    
                                </tr>
                                <tr>
                                    <th>내용</th>
                                    <th><textarea class="form-control" name="msgContent" id="msgContent" rows="5" cols="30"></textarea></th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                <div class="modal-footer fn-font">
                    <input class="btn btn-primary" id="msgSend" type="button" value="보내기">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                </div>
                </form>
            </div>
        </div>
    </div>	
	
	
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

//쪽지보관함 전체선택
function selectAllSaveMsg(e)  {
	  const checkboxes = document.getElementsByName('saveMsgCheck');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = e.checked;
	  })
};




//받은편지함 전체조회
function recvMsgBox(cPage){

	var num=1;

	$.ajax({
		url:"${path}/message/recvBox.do",
		type: "post",
		data: {"memberId":"${param.memberId}", cPage:cPage},
		dataType: "json",
		success: data => {
			$("#pageNavContainer").html("");
			$("#body-container").html("");
			$("#eventButton").html("");
			$("#sendMsgSearch").remove();
			$("#saveMsgSearch").remove();
			$("#recvMsgSearch").remove();
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
			let th5=$("<th>").html("받은날짜").attr("scope","col");
			let th6=$("<th>").html("읽은날짜").attr("scope","col");

			
			table.append(thead);
			thead.append(tr1);
			tr1.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6);
			th1.append(checkAll);
			
			
			if(recvMsgList.length==0){
				let tr2 = $("<tr>").css("text-align","center");
				let ntd=$("<td>").html("받은쪽지가 없습니다.");
				ntd.attr("colspan","6");
				tr2.append(ntd);
				tbody.append(tr2);
				table.append(tbody);
			} else{
				
				for(let i=0; i<recvMsgList.length; i++){
					let tr2 = $("<tr>").css("text-align","center");
					console.log(recvMsgList[i]["MSGREADCHECK"])
					if(recvMsgList[i]["MSGREADCHECK"]=='N'){
						tr2.css({"color":"#0459c1","font-weight":"bold"});
					} else{
						tr2.css({"color":"#212529"});
					}
					let td1 = $("<td>");
					let check = $("<input>").attr({class:"form-check-input", type:"checkbox", name:"recvMsgCheck", value:recvMsgList[i]["MSGNO"]});
					//let msgNo = $("<td>").html(((cPage-1)*10)+i+1);
					let no = $("<td>").html(num++);
					if(cPage>=2){
						no = $("<td>").html(((cPage-1)*10)+i+1);
					}
					
					let msgTitle = $("<td onClick='recvMsgView(this);'>").html(recvMsgList[i]["MSGTITLE"]);
					let msgNo = $("<input>").attr({type:"hidden", value:recvMsgList[i]["MSGNO"]});
					msgTitle.append(msgNo);
					
					let sendNick = $("<td>").html(recvMsgList[i]["SENDNICK"]);
					let msgSendTime = $("<td>").html(recvMsgList[i]["MSGSENDTIME"]);
					let msgReadTime = $("<td>").html(recvMsgList[i]["MSGREADTIME"]);
					if(recvMsgList[i]["MSGREADTIME"]==null){
						msgReadTime = $("<td>").html("읽지않음");
					}
					tbody.append(tr2);
					table.append(tbody);
					tr2.append(td1).append(no).append(msgTitle).append(sendNick).append(msgSendTime).append(msgReadTime);
					td1.append(check);
				}
				
				let save = $("<button>").attr({type:"button", id:"saveMsg", class:"btn btn-primary"}).html("쪽지보관");
				let del = $("<button>").attr({type:"button", id:"delRecvMsg", class:"btn btn-secondary"}).html("삭제");
				$("#eventButton").append(save).append(del);
				//table.append($("#deleteMsg"));
			}
			let search = $("<button id='recvMsgSearch' type='submit' class='btn btn-secondary'>").html("검색");
			$("#searchMsg").append(search);
			
			
			const div=$("<div style='text-align:center;'>").attr("id","pageBar3").html(data["pageBar"]);
			$("#pageNavContainer").append(div);
			$("#body-container").html(table);
			
			//쪽지삭제
			$("#delRecvMsg").click(function(){
				var checkArr = [];
				if($("input:checkbox[name='recvMsgCheck']:checked").length === 0){
					alert("삭제할 항목을 선택해 주세요.");
				} else{
					$("input:checkbox[name='recvMsgCheck']:checked").each(function(e) {
						checkArr.push($(this).val());
					});
					$.ajax({
						url:"${path}/message/deleteRecvMsg.do",
						type:"post",
						data:{"checkArrTest" : checkArr},
						dataType:"json",
						success: result => {
							alert(result.result);
							location.reload();
						}
						
					});
				}
			});
			
			//쪽지보관
			$("#saveMsg").click(function(){
				var checkArr = [];
				if($("input:checkbox[name='recvMsgCheck']:checked").length === 0){
					alert("보관할 쪽지를 선택해 주세요.");
				} else{
					$("input:checkbox[name='recvMsgCheck']:checked").each(function(e) {
						checkArr.push($(this).val());
					});
					$.ajax({
						url:"${path}/message/saveMsgPut.do",
						type:"post",
						data:{"checkArrTest" : checkArr},
						dataType:"json",
						success: result => {
							alert(result.result);
							location.reload();
						}
						
					});
				}
			});
		
			//삭제,목록버튼 생성해야함
		}
	/* 	let form = $("<form>").attr({method:"post"});
		let select = $("<select>").attr({name:"searchType"});
		let option1 = $("<option>").value("msg_title").html("제목");
		let option2 = $("<option>").value("send_id").html("보낸사람");
		let keyword = $("<input>").attr({type:"text", name:"keyword"});
		let startDate = $("<input>").attr({type:"date", name:"startDate"});
		let endDate = $("<input>").attr({type:"date", name:"endDate"});
		let search = $("<button>").attr({type:"submit"}).html("검색");
		select.append(option1).append(option2);
		form.append(select).append(keyword).append(startDate).append(endDate).append(search);
		$("#searchMessage").append(form); */
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
			$("#eventButton").html("");
			$("#recvMsgSearch").remove();
			$("#saveMsgSearch").remove();
			$("#sendMsgSearch").remove();


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
			let th6=$("<th>").html("읽음여부").attr("scope","col");
			let th7=$("<th>").html("발송취소").attr("scope","col");
			
			table.append(thead);
			thead.append(tr1);
			tr1.append(th1);
			th1.append(checkAll);
			tr1.append(th2).append(th3).append(th4).append(th5).append(th6).append(th7);
			
			
			if(sendMsgList.length==0){
				let tr2 = $("<tr>").css("text-align","center");
				let ntd=$("<td>").html("보낸쪽지가 없습니다.");
				ntd.attr("colspan","7");
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
					let msgTitle = $("<td onClick='sendMsgView(this);'>").html(sendMsgList[i]["MSGTITLE"]);
					let msgNo = $("<input>").attr({type:"hidden", value:sendMsgList[i]["MSGNO"]});
					msgTitle.append(msgNo);
					
					let recvId = $("<td>").html(sendMsgList[i]["RECVNICK"]);
					let msgSendTime = $("<td>").html(sendMsgList[i]["MSGSENDTIME"]);
					let msgReadCheck = $("<td>");
					let cancelMsg = $("<td>");
					let cancelMsgNo = $("<input>").attr({type:"hidden", value:sendMsgList[i]["MSGNO"]});
					if(sendMsgList[i]["MSGREADCHECK"]=='N'){
						msgReadCheck.html("읽지않음");
						cancelMsg.append("<button type='button' class='btn btn-outline-secondary' onclick='cancelMsg(this);'>발송취소").append(cancelMsgNo);
					} else {
						msgReadCheck.html("읽음");
					}
					tbody.append(tr2);
					table.append(tbody);
					tr2.append(td1).append(no).append(msgTitle).append(recvId).append(msgSendTime).append(msgReadCheck).append(cancelMsg);
					td1.append(check);
					
				
					
				}
				let del = $("<button>").attr({type:"button", id:"delSendMsg", class:"btn btn-secondary"}).html("삭제");
				$("#eventButton").append(del);
			}
			let search = $("<button id='sendMsgSearch' type='submit' class='btn btn-secondary'>").html("검색");
			$("#searchMsg").append(search);
			
			const pageBar=$("<div style='text-align:center;'>").attr("id","pageBar2").html(data["pageBar"]);
			$("#pageNavContainer").append(pageBar);
			//$("#pageNavContainer").show();
			$("#body-container").html(table);
			
			$("#delSendMsg").click(function(){
				var checkArr = [];
				if($("input:checkbox[name='sendMsgCheck']:checked").length === 0){
					alert("삭제할 항목을 선택해 주세요.");
				} else{
					$("input:checkbox[name='sendMsgCheck']:checked").each(function(e) {
						checkArr.push($(this).val());
					});
					$.ajax({
						url:"${path}/message/deleteSendMsg.do",
						type:"post",
						data:{"checkArrTest" : checkArr},
						dataType:"json",
						success: result => {
							alert(result.result);
							location.reload();
						}
						
					});
				}
			});
		}
	});

};



//쪽지보관함
function saveMsgBox(cPage){

	var num=1;

	$.ajax({
		url:"${path}/message/saveMsgBox.do",
		type: "post",
		data: {"memberId":"${param.memberId}", cPage:cPage},
		dataType: "json",
		success: data => {
			$("#pageNavContainer").html("");
			$("#body-container").html("");
			$("#eventButton").html("");
			$("#sendMsgSearch").remove();
			$("#recvMsgSearch").remove();
			$("#saveMsgSearch").remove();

			const saveMsgList = data["list"];
			
			const table=$('<table>').attr("class","table table-hover");
			let thead=$("<thead>");
			let tbody=$('<tbody>');
			let tr1=$("<tr>").css("text-align","center");
			let th1=$("<th>");
			let checkAll = $("<input>").attr({class:"form-check-input", type:"checkbox", name:"saveMsgCheck", onclick:'selectAllSaveMsg(this)'});
			let th2=$("<th>").html("번호").attr("scope","col");
			let th3=$("<th>").html("제목").attr("scope","col");
			let th4=$("<th>").html("보낸사람").attr("scope","col");
			let th5=$("<th>").html("받은날짜").attr("scope","col");
			let th6=$("<th>").html("읽은날짜").attr("scope","col");
			
			table.append(thead);
			thead.append(tr1);
			tr1.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6);
			th1.append(checkAll);
			
			
			if(saveMsgList.length==0){
				let tr2 = $("<tr>").css("text-align","center");
				let ntd=$("<td>").html("보관된 쪽지가 없습니다.");
				ntd.attr("colspan","6");
				tr2.append(ntd);
				tbody.append(tr2);
				table.append(tbody);
			} else{
				
				for(let i=0; i<saveMsgList.length; i++){
					let tr2 = $("<tr>").css("text-align","center");
					console.log(saveMsgList[i]["MSGREADCHECK"])
					if(saveMsgList[i]["MSGREADCHECK"]=='N'){
						tr2.css({"color":"#0459c1","font-weight":"bold"});
					} else{
						tr2.css({"color":"#212529"});
					}
					let td1 = $("<td>");
					let check = $("<input>").attr({class:"form-check-input", type:"checkbox", name:"saveMsgCheck", value:saveMsgList[i]["MSGNO"]});
					let no = $("<td>").html(num++);
					if(cPage>=2){
						no = $("<td>").html(((cPage-1)*10)+i+1);
					}
					
					let msgTitle = $("<td onClick='saveMsgView(this);'>").html(saveMsgList[i]["MSGTITLE"]);
					let msgNo = $("<input>").attr({type:"hidden", value:saveMsgList[i]["MSGNO"]});
					msgTitle.append(msgNo);
					
					let sendNick = $("<td>").html(saveMsgList[i]["SENDNICK"]);
					let msgSendTime = $("<td>").html(saveMsgList[i]["MSGSENDTIME"]);
					let msgReadTime = $("<td>").html(saveMsgList[i]["MSGREADTIME"]);
					if(saveMsgList[i]["MSGREADTIME"]==null){
						msgReadTime = $("<td>").html("읽지않음");
					}
					tbody.append(tr2);
					table.append(tbody);
					tr2.append(td1).append(no).append(msgTitle).append(sendNick).append(msgSendTime).append(msgReadTime);
					td1.append(check);
				}
				let saveMsgExport = $("<button>").attr({type:"button", id:"saveMsgExport", class:"btn btn-primary"}).html("내보내기");
				let del = $("<button>").attr({type:"button", id:"delSaveMsg", class:"btn btn-secondary"}).html("삭제");
				$("#eventButton").append(saveMsgExport).append(del);
			}
			
			let search = $("<button id='saveMsgSearch' type='submit' class='btn btn-secondary'>").html("검색");
			$("#searchMsg").append(search);
			
			
			const div=$("<div style='text-align:center;'>").attr("id","pageBar3").html(data["pageBar"]);
			$("#pageNavContainer").append(div);
			$("#body-container").html(table);
			
			//보관쪽지 삭제
			$("#delSaveMsg").click(function(){
				var checkArr = [];
				if($("input:checkbox[name='saveMsgCheck']:checked").length === 0){
					alert("삭제할 항목을 선택해 주세요.");
				} else{
					$("input:checkbox[name='saveMsgCheck']:checked").each(function(e) {
						checkArr.push($(this).val());
					});
					$.ajax({
						url:"${path}/message/deleteSaveMsg.do",
						type:"post",
						data:{"checkArrTest" : checkArr},
						dataType:"json",
						success: result => {
							alert(result.result);
							location.reload();
						}
						
					});
				}
			});
			
			//보관쪽지 내보내기
			$("#saveMsgExport").click(function(){
				var checkArr = [];
				if($("input:checkbox[name='saveMsgCheck']:checked").length === 0){
					alert("보관할 쪽지를 선택해 주세요.");
				} else{
					$("input:checkbox[name='saveMsgCheck']:checked").each(function(e) {
						checkArr.push($(this).val());
					});
					$.ajax({
						url:"${path}/message/saveMsgExport.do",
						type:"post",
						data:{"checkArrTest" : checkArr},
						dataType:"json",
						success: result => {
							alert(result.result);
							location.reload();
						}
						
					});
				}
			});
		
			//삭제,목록버튼 생성해야함
		}
	/* 	let form = $("<form>").attr({method:"post"});
		let select = $("<select>").attr({name:"searchType"});
		let option1 = $("<option>").value("msg_title").html("제목");
		let option2 = $("<option>").value("send_id").html("보낸사람");
		let keyword = $("<input>").attr({type:"text", name:"keyword"});
		let startDate = $("<input>").attr({type:"date", name:"startDate"});
		let endDate = $("<input>").attr({type:"date", name:"endDate"});
		let search = $("<button>").attr({type:"submit"}).html("검색");
		select.append(option1).append(option2);
		form.append(select).append(keyword).append(startDate).append(endDate).append(search);
		$("#searchMessage").append(form); */
	});
	
	
	
};


//상대방이 읽기전 발송취소
function cancelMsg(e){
	let cancelNum = $(e).next().val();
	//let msgNo = $(e).parent().children().eq(1).val();
	console.log($(e).next().val());
 	$.ajax({
		url:"${path}/message/cancelSendMsg.do",
		type:"post",
		data:{"msgNo":cancelNum},
		dataType:"json",
		success: data =>{
			alert(data.result);
			location.reload();
			
		}
		
	}) 
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


//받은편지 상세보기
function recvMsgView(e){
	let msgNo = $(e).children().val();
	$.ajax({
		url:"${path}/message/recvMsgDetail.do",
		type: "post",
		data: {"msgNo":msgNo},
		dataType: "json",
		success: data => {
			$("#body-container").html("");
			$("#pageNavContainer").html("");
			$("#eventButton").html("");
			
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
			let msgContent = $("<td>").html(data["MSGCONTENT"]).attr({colspan:"4"});
			
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
			
			let list = $("<button>").attr({class:"btn btn-primary", type:"button", onclick:"location.reload();"}).html("목록");
			let del = $("<button>").attr({type:"button", id:"delRecvMsg", class:"btn btn-secondary"}).html("삭제");
			let answer = $("<button>").attr({type:"button", id:"answer", class:"btn btn-success"}).html("답장");
			$("#eventButton").append(answer).append(list).append(del);
			
			$("#body-container").html(table);
			//상세보기 페이지 삭제버튼
			$("#delRecvMsg").click(function(){
				$.ajax({
					url:"${path}/message/deleteRecvMsgOne.do",
					type:"post",
					data:{"msgNo" : data["MSGNO"]},
					dataType:"json",
					success: data => {
					console.log(msgNo);
						alert(data.result);
						location.reload();
					}
						
				});
			});
			
			//답장버튼
			$("#answer").click(function(){
				$('#recvNick').val(data["SENDNICK"]);
				$('#recvId').val(data["SENDID"]);
				$('#MsgForm').modal("show");
				connectSocket();
		
			});
		}
	});
};


//답장 보내기
$("#msgSend").click(e=>{
	
	//욕설 입력 금지
    var SlangList = new Array('10새','10새기','10새리','10세리','10쉐이','10쉑','10스','10쌔',
    		'10쌔기','10쎄','10알','10창','10탱','18것','18넘','18년','18노','18놈',
    		'18뇬','18럼','18롬','18새','18새끼','18색','18세끼','18세리','18섹','18쉑','18스','18아',
    		'c파','c팔','fuck',
    		'ㄱㅐ','ㄲㅏ','ㄲㅑ','ㄲㅣ','ㅅㅂㄹㅁ','ㅅㅂ','ㅅㅐ','ㅆㅂㄹㅁ','ㅆㅍ','ㅆㅣ','ㅆ앙','ㅍㅏ','凸',
    		'갈보','갈보년','강아지','같은년','같은뇬','개같은','개구라','개년','개놈',
    		'개뇬','개대중','개독','개돼중','개랄','개보지','개뻥','개뿔','개새','개새기','개새끼',
    		'개새키','개색기','개색끼','개색키','개색히','개섀끼','개세','개세끼','개세이','개소리','개쑈',
    		'개쇳기','개수작','개쉐','개쉐리','개쉐이','개쉑','개쉽','개스끼','개시키','개십새기',
    		'개십새끼','개쐑','개씹','개아들','개자슥','개자지','개접','개좆','개좌식','개허접','걔새',
    		'걔수작','걔시끼','걔시키','걔썌','걸레','게색기','게색끼','광뇬','구녕','구라','구멍',
    		'그년','그새끼','냄비','놈현','뇬','눈깔','뉘미럴','니귀미','니기미','니미','니미랄','니미럴',
    		'니미씹','니아배','니아베','니아비','니어매','니어메','니어미','닝기리','닝기미','대가리',
    		'뎡신','도라이','돈놈','돌아이','돌은놈','되질래','뒈져','뒈져라','뒈진','뒈진다','뒈질',
    		'뒤질래','등신','디져라','디진다','디질래','딩시','따식','때놈','또라이','똘아이','똘아이',
    		'뙈놈','뙤놈','뙨넘','뙨놈','뚜쟁','띠바','띠발','띠불','띠팔','메친넘','메친놈','미췬',
    		'미췬','미친','미친넘','미친년','미친놈','미친새끼','미친스까이','미틴','미틴넘','미틴년',
    		'미틴놈','바랄년','병자','뱅마','뱅신','벼엉신','병쉰','병신','부랄','부럴','불알','불할','붕가',
    		'붙어먹','뷰웅','븅','븅신','빌어먹','빙시','빙신','빠가','빠구리','빠굴','빠큐','뻐큐',
    		'뻑큐','뽁큐','상넘이','상놈을','상놈의','상놈이','새갸','새꺄','새끼','새새끼','새키',
    		'색끼','생쑈','세갸','세꺄','세끼','섹스','쇼하네','쉐','쉐기','쉐끼','쉐리','쉐에기',
    		'쉐키','쉑','쉣','쉨','쉬발','쉬밸','쉬벌','쉬뻘','쉬펄','쉽알','스패킹','스팽','시궁창','시끼',
    		'시댕','시뎅','시랄','시발','시벌','시부랄','시부럴','시부리','시불','시브랄','시팍',
    		'시팔','시펄','신발끈','심발끈','심탱','십8','십라','십새','십새끼','십세','십쉐','십쉐이','십스키',
    		'십쌔','십창','십탱','싶알','싸가지','싹아지','쌉년','쌍넘','쌍년','쌍놈','쌍뇬','쌔끼',
    		'쌕','쌩쑈','쌴년','썅','썅년','썅놈','썡쇼','써벌','썩을년','썩을놈','쎄꺄','쎄엑',
    		'쒸벌','쒸뻘','쒸팔','쒸펄','쓰바','쓰박','쓰발','쓰벌','쓰팔','씁새','씁얼','씌파','씨8',
    		'씨끼','씨댕','씨뎅','씨바','씨바랄','씨박','씨발','씨방','씨방새','씨방세','씨밸','씨뱅',
    		'씨벌','씨벨','씨봉','씨봉알','씨부랄','씨부럴','씨부렁','씨부리','씨불','씨붕','씨브랄',
    		'씨빠','씨빨','씨뽀랄','씨앙','씨파','씨팍','씨팔','씨펄','씸년','씸뇬','씸새끼','씹같','씹년',
    		'씹뇬','씹보지','씹새','씹새기','씹새끼','씹새리','씹세','씹쉐','씹스키','씹쌔','씹이','씹자지',
    		'씹질','씹창','씹탱','씹퇭','씹팔','씹할','씹헐','아가리','아갈','아갈이','아갈통',
    		'아구창','아구통','아굴','얌마','양넘','양년','양놈','엄창','엠병','여물통','염병','엿같','옘병',
    		'옘빙','오입','왜년','왜놈','욤병','육갑','은년','을년','이년','이새끼','이새키','이스끼',
    		'이스키','임마','자슥','잡것','잡넘','잡년','잡놈','저년','저새끼','접년','젖밥','조까',
    		'조까치','조낸','조또','조랭','조빠','조쟁이','조지냐','조진다','조찐','조질래','존나','존나게','존니','존만',
    		'존만한','좀물','좁년','좁밥','좃까','좃또','좃만','좃밥','좃이','좃찐','좆같','좆까','좆나',
    		'좆또','좆만','좆밥','좆이','좆찐','좇같','좇이','좌식','주글','주글래','주데이','주뎅',
    		'주뎅이','주둥아리','주둥이','주접','주접떨','죽고잡','죽을래','죽통','쥐랄','쥐롤',
    		'쥬디','지랄','지럴','지롤','지미랄','짜식','짜아식','쪼다','쫍빱','찌랄','창녀','캐년',
    		'캐놈','캐스끼','캐스키','캐시키','탱구','팔럼','퍽큐','호로','호로놈','호로새끼',
    		'호로색','호로쉑','호로스까이','호로스키','후라들','후래자식','후레','후뢰');
    //제목, 내용 모두 빈값이나 비속어 사용 불가
    var TmpTitle;
    var TmpContent;
    for(i=0 ; i<SlangList.length ; i++){
    	TmpTitle = $("#msgTitle").val().toLowerCase().indexOf(SlangList[i]);
        if(TmpTitle >= 0){
            alert('비속어는 입력할 수 없습니다. 제목을 다시 입력해주세요');
            $("#msgTitle").focus();
            return false;
        }
        TmpContent = $("#msgContent").val().toLowerCase().indexOf(SlangList[i]);
        if(TmpContent >= 0){
            alert('비속어는 입력할 수 없습니다. 내용을 다시 입력해주세요');
            $("#msgContent").focus();
            return false;
        }
    }
    //쪽지 제목 미입력시 포커스
  	if($("#msgTitle").val().trim().length == 0){
       $("#msgTitle").focus();
       return false;
    }
    //쪽지 내용 미입력시 포커스
  	if($("#msgContent").val().trim().length == 0){
       $("#msgContent").focus();
       return false;
    }  
    
    let sendId=$("#sendId").val();
    let sendNick=$("#sendNick").val();
    let recvId=$("#recvId").val();
    let recvNick=$("#recvNick").val();
    let msgTitle=$("#msgTitle").val();
    let msgContent=$("#msgContent").val();
    
    const sendData = {
    		type:"message",
    		sendId:sendId,
    		sendNick:sendNick,
    		recvId:recvId,
    		recvNick:recvNick,
    		msgTitle:msgTitle,
    		msgContent:msgContent,
    }
    
    
    socket.send(JSON.stringify(sendData));
    $('#MsgForm').modal("hide");
  
    
});


//보낸편지 상세보기
function sendMsgView(e){
	let msgNo = $(e).children().val();
	$.ajax({
		url:"${path}/message/sendMsgDetail.do",
		type: "post",
		data: {"msgNo":msgNo},
		dataType: "json",
		success: data => {
			$("#body-container").html("");
			$("#pageNavContainer").html("");
			$("#eventButton").html("");
			
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
			
			let tr4=$("<tr>")
			let msgContent = $("<td>").html(data["MSGCONTENT"]).attr({colspan:"4"});
			
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
			
			let list = $("<button>").attr({class:"btn btn-primary", type:"button", onclick:"location.reload();"}).html("목록");
			let del = $("<button>").attr({type:"button", id:"delSendMsg", class:"btn btn-secondary"}).html("삭제");
			$("#eventButton").append(list).append(del);
			
			$("#body-container").html(table);
			//답장,삭제,목록버튼 생성해야함
			$("#delSendMsg").click(function(){
				$.ajax({
					url:"${path}/message/deleteSendMsgOne.do",
					type:"post",
					data:{"msgNo" : data["MSGNO"]},
					dataType:"json",
					success: data => {
					console.log(msgNo);
						alert(data.result);
						location.reload();
					}
						
				});
			});
			
		}
	});
};

//보관쪽지 상세보기
function saveMsgView(e){
	let msgNo = $(e).children().val();
	$.ajax({
		url:"${path}/message/saveMsgDetail.do",
		type: "post",
		data: {"msgNo":msgNo},
		dataType: "json",
		success: data => {
			$("#body-container").html("");
			$("#pageNavContainer").html("");
			$("#eventButton").html("");
			
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
			let msgContent = $("<td>").html(data["MSGCONTENT"]).attr({colspan:"4"});
			
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
			
			let list = $("<button>").attr({class:"btn btn-primary", type:"button", onclick:"location.reload();"}).html("목록");
			let del = $("<button>").attr({type:"button", id:"delRecvMsg", class:"btn btn-secondary"}).html("삭제");
			let answer = $("<button>").attr({type:"button", id:"answer", class:"btn btn-success"}).html("답장");
			$("#eventButton").append(answer).append(list).append(del);
			
			$("#body-container").html(table);
			//상세보기 페이지 삭제버튼 -> 여기서는 삭제시 보관유무 n으로도 변경되어야함 -> 그래야 나중에 시간 지난 쪽지 스케쥴러에서 자동삭제
			$("#delRecvMsg").click(function(){
				$.ajax({
					url:"${path}/message/deleteSaveMsgOne.do",
					type:"post",
					data:{"msgNo" : data["MSGNO"]},
					dataType:"json",
					success: data => {
					console.log(msgNo);
						alert(data.result);
						location.reload();
					}
						
				});
			});
			
			//답장버튼
			$("#answer").click(function(){
				$('#recvNick').val(data["SENDNICK"]);
				$('#recvId').val(data["SENDID"]);
				$('#MsgForm').modal("show");
				connectSocket();
		
			});
		}
	});
};
var socket = null;

function connectSocket(){
	var sock = "http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/message";
	socket = new SockJS(sock);
	
	socket.onopen = onOpen;
	socket.onmessage = onMessage;

 }; 

</script>
</html>
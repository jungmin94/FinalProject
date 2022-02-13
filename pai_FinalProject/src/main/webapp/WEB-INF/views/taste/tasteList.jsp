<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	

<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> 
<style>
#mssage_send_btn {
    float : left;
    margin-top : -50px;
    margin-left : 10px;
    height :35px;
}
 
.msg_form .modal-body table tbody tr {
    margin-bottom : 20px;
}
</style>

 <section> 


	  <div style="text-align: center;">
		<span class="badge bg-success">친구찾기 리스트</span>
	  </div>
		<br>
		<div class="row" style="text-align: center;">
			<div class="col">
					
			</div>
			
			<c:forEach var="t" items="${list }">
				<c:if test="${loginMember.member_id ne t.member_id.member_id }">
				  <div class="col">
					<div class="card" style="width: 18rem;">
						<%-- <img src="${t.member_id.member_profile }" class="card-img-top" alt="..." style="height: 170px;"> --%>
						<div class="card-body">
						  <p class="card-text"><c:out value="${t.member_id.member_id }"/></p>
						  <p class="card-text"><c:out value="${t.member_id.member_nick }"/></p>
						  <p class="card-text"><c:out value="${t.member_id.member_date }"/></p>
						  <p class="card-text"><c:out value="${t.member_id.member_gender }"/></p>
						  <p class="card-text"><c:out value="${t.member_id.member_mbti }"/></p>
						  <button onclick="sendMessage(this);" class="btn btn-primary">쪽지 보내기</button>
						</div>
					  </div>
				  </div>
			  </c:if>
			</c:forEach>


			<div class="col">
					
			</div>
			
		</div>	 
		
		<br>
		<br>
<%-- 		<form id="sendData" action="${path}/message/sendMessage" method="post">
			<input type="hidden" name="member_id" id="member_id" >
			<input type="hidden" name="member_nick" id="member_nick">
			<input type="hidden" name="member_date" id="member_date">
			<input type="hidden" name="member_gender" id="member_gender">
			<input type="hidden" name="member_mbti" id="member_mbti">
		</form> --%>
		
		
		<div class="modal fade" id="MsgForm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content ">
                <div class="modal-header">
                <h5 class="modal-title">쪽지 보내기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form class="msg_form">
                    <input type="hidden" id="flag" name="flag" value="insert"/>
                    <input type="hidden" name="member_id" id="member_id" >
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
                                    	<input type="text" class="form-control-plaintext" name="send_nick" id="send_nick" value="${loginMember.member_nick}" readonly/>
                                    	<input type="hidden" name="send_id" id="send_id" value="${loginMember.member_id}">
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
                                    <th><textarea class="form-control" name="msgContent" id="msgContent" rows="5" cols="30">디자인은 나중에 수정예정</textarea></th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </form>
                <div class="modal-footer fn-font">
                    <button class="btn btn-primary" id="msgSend">보내기</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
		
		

</section> 

<script>

const sendMessage=(e)=>{
 	 var recvId = e.parentElement.children[0].innerText;
	 var recvNick = e.parentElement.children[1].innerText;
	 var sendDate = e.parentElement.children[2].innerText;
	 var memberGender = e.parentElement.children[3].innerText;
	 var memberMbti = e.parentElement.children[4].innerText;
	 $("#recvId").val(recvId);
	 $("#recvNick").val(recvNick);
	 $("#member_date").val(sendDate);
	 $("#member_gender").val(memberGender);
	 $("#member_mbti").val(memberMbti);
	
	$('#MsgForm').modal("show");
	    
	/*  $('#sendData').attr("target", "formInfo");
	 open("", "formInfo", "height=600, width=600, menubar=no, scrollbars=yes, resizable=no, toolbar=no, status=no, left=50, top=50");
	 $("#sendData").submit(); */
};


$("#msgSend").click(function(){
    var msg= "쪽지를 보낼래?";
    
    if(!confirm(msg))
        return false;
    
    $.ajax({
        url : "/message/message_proc.do",
        dataType : "json",
        type : "post",
        data : $(".msg_form").serialize(),
        success:function(data){
            alert("쪽지를 보냈습니다.");                
        }
    })
});


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
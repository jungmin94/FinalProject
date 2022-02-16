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
                    <button class="btn btn-primary" id="msgSend" type="submit">보내기</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                </div>
                </form>
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


$("#msgSend").click(e=>{
	
	//욕설 입력 금지
    var SlangList = new Array('10새','10새기','10새리','10세리','10쉐이','10쉑','10스','10쌔',
    		'10쌔기','10쎄','10알','10창','10탱','18것','18넘','18년','18노','18놈',
    		'18뇬','18럼','18롬','18새','18새끼','18색','18세끼','18세리','18섹','18쉑','18스','18아',
    		'c파','c팔','fuck',
    		'ㄱㅐ','ㄲㅏ','ㄲㅑ','ㄲㅣ','ㅅㅂㄹㅁ','ㅅㅐ','ㅆㅂㄹㅁ','ㅆㅍ','ㅆㅣ','ㅆ앙','ㅍㅏ','凸',
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
 /*      var msg= "정말 발송하시겠습니까?";
    
    if(!confirm(msg))
        return false; */
    //족지 제목 미입력시 포커스
  	if($("#msgTitle").val().trim().length == 0){
       $("#msgTitle").focus();
       return false;
    }
    //쪽지 내용 미입력시 포커스
  	if($("#msgContent").val().trim().length == 0){
       $("#msgContent").focus();
       return false;
    }  
    
    $.ajax({
        url : "${path}/message/sendMessage.do",
        dataType : "json",
        type : "post",
        data : $(".msg_form").serialize(),
        success: data=>{
    		alert(data);
    		alert(sendData);
        	console.log(data);
            const sendData = {
            	"msgType":'sendMessage',
            	"sendId":data["sendId"],
            	"sendNick":data["sendNick"],
            	"recvId":data["recvId"],
            	"recvNick":data["recvNick"],
            	"msgTitle":data["msgTitle"],
            	"msgContent":data["msgContent"]
            }
            
            let jsonData = JSON.stringify(sendData)
            console.log(sendData);
    		socket.send(sendData);
			console.log('send');
        }
    })

 
    //modal.find('.modal-body textarea').val('');
});



</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
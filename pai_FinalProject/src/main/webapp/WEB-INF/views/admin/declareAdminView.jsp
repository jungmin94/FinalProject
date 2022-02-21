<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> 
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	.nav-link{
		font-size:25px;
		margin-bottom:20px;
		bolder:1px gray solid;
		text-align:center;
		width:130px;
		padding:0px;
		
	}
	.admin{
		font-size:50px;
		font-weight:bolder;
		text-align:center;
		background-color:cornflowerblue;
	}
	.text{ 
		height:600px;
		border-left: lightGray 2px solid;
	}
	
	.thead>td{
		text-align:center;
		border:1px gray solid;
		width:150px;
	}
	.tbody>td{ 
		height:50px;
		text-align:center;
		border-bottom:1px lightGray solid;	
	}
	.navi{
		width:150px;
		border-right: lightGray 2px solid;
	}
</style>
<section>
	<div class="container">
		<div class="admin">
			회원관리
		</div>
		 
		<div class="row" style="margin-top:50px;"> 
			<div class="navi col-2"> 
				<ul class="nav flex-column">
				  <li class="nav-item">
				    <a class="nav-link" aria-current="page" href="${path}/admin/adminView.do">홈</a>
				  </li>
				  <li class="nav-item dropdown">
			          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
			            신고내역
			          </a>
			          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
			            <li><a class="dropdown-item" href="${path}/admin/declareAdminView.do">게시글신고</a></li>
			            <li><a class="dropdown-item" href="${path}/admin/commentDeclare.do">댓글신고</a></li> 
			          </ul>
			        </li>  
				</ul>
			</div>
			
			<div class="col text">
				<div><h3>게시판신고접수현황</h3></div>
				<table> 
					<tr class="thead" style="background-color:lightGray;">
						<td style="width:60px;">번호</td>
						<td style="width:600px;">제목</td>
						<td style="widht:350px;">작성자</td>
						<td style="width:500px;">신고사유</td>
						<td>신고자</td>
						<td>신고일시</td>
						<td>처리현황</td>
					</tr> 
					<c:forEach var="b" items="${list}" varStatus="vs"> 
						<tr class="tbody" >
							<td ><c:out value="${b.boardNo}"/>
								<input type="hidden" name="boardNo" value="${b.boardNo}">
							</td>
							
							<td>
								<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${b.boardNo}&memberId=null">
									<c:out value="${b.boardTitle}"/>
								</a>
							</td>
							<td><c:out value="${b.boardWriter}"/></td>
							<td><c:out value="${b.declareContent}"/></td>
							<td><c:out value="${b.declareWriter }"/></td>
							<td><c:out value="${b.declareDate}"/></td>
							<c:if test="${b.declareResult==null}"> 
							<!-- <a href="${path}/admin/boardDeclareView.do?boardNo=${b.boardNo}&declareWriter=${b.declareWriter}"> -->
								<td><input type="button"  class="btn btn-primary"  data-bs-toggle="modal" data-bs-target="#updateDeclare${vs.index}" value="접수"></td>
							</c:if>
							<c:if test="${b.declareResult!=null}">
								<td><button type="button" class="btn btn-success"  data-bs-toggle="modal" data-bs-target="#declare${vs.index}">처리완료</button></td>
							</c:if>
						</tr>
						<!-- 게시글 신고 접수 Modal -->
						<div class="modal fade" id="updateDeclare${vs.index}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="staticBackdropLabel">게시글신고접수</h5>
						        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						      </div>
						      <form action="${path}/admin/updateBoardDeclare.do"> 
							      <div class="modal-body"> 
							      		<div>처리결과선택</div>
					  					<div class="form-check">
									        <input class="form-check-input" type="checkbox" name="declareResult"   value="작성자 경고 1회부여"  >
											<label class="form-check-label" for="inlineRadio2">작성자 경고 1회부여</label>
									    </div>
									    <div class="form-check">
									        <input class="form-check-input" type="checkbox" name="declareResult"  value="작성자 블랙리스트 등록">
											<label class="form-check-label" for="inlineRadio2">작성자 블랙리스트 등록</label>
									    </div>
									    <div class="form-check">
									        <input class="form-check-input" type="checkbox" name="declareResult"  value="해당게시글 삭제">
											<label class="form-check-label" for="inlineRadio2">해당게시글 삭제</label>
									    </div>  
									    <div class="form-check">
									        <input class="form-check-input" type="checkbox"  name="declareResult" value="신고무효(신고사유에 해당되지 않음)" id="others"  >
											<label class="form-check-label" for="inlineRadio2">신고무효(신고사유에 해당되지 않음)</label>
											<div id="target" style="display:none;"></div>
									     </div>
									     <div>
									     	<input type="hidden" name="boardNo" value="${b.boardNo}">
									     	<input type="hidden" name="boardWriter" value="${b.boardWriter}">  
									     	<input type="hidden" name="declareWriter" value="${b.declareWriter}">  
									     </div>
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							        <button type="submit" class="btn btn-primary">확인</button>
							      </div>
							   </form>   
						    </div>
						  </div>
						</div>
						
						<!-- 신고처리완료 모달 -->
						<div class="modal fade" id="declare${vs.index}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="staticBackdropLabel">신고처리결과</h5>
						        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						      </div> 
							      <div class="modal-body ">
					  				<div class="container-fluid">  
					  					<div class="declare-list"> 
											<label class="form-check-label" for="inlineRadio2"> 
												<p>${b.declareResult}</p>
											</label>
							      		</div>
							      		<div class="declare-list"> 
											<label class="form-check-label" for="inlineRadio2"> 
												<p>처리일시 : ${b.declareResultDate}</p>
											</label>
							      		</div>
							      	</div>
								  </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button> 
							      </div> 
						    </div>
						  </div>
						</div> 
					</c:forEach>  
				</table> 
			</div>
			<div>
				${pageBar}
			</div>
		</div>
		
		
		
		
	</div>
</section>
<script>
	const other=()=>{ 
		let others= $("#others").val();
		console.log(others);
 		var text = document.createElement("textarea"); 
 		text.setAttribute("name","declareResult");
 		document.getElementById("target").append(text);
 		document.getElementById("target").style.display = "block"; 
 		others=$("textarea").val(); 
 	}

	 
		
	$(()=>{
		$("#submitBtn").click(e=>{
			let boardNo=$("input[name=boardNo]");
			console.log(e.target);
			}) 
	})	 
	 
	
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
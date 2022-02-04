<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> 
<style>
	.nav-link{
		font-size:30px;
		bolder:1px gray solid;
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
				  <li class="nav-item">
				    <a class="nav-link" href="#">Link</a>
				  </li> 
				</ul>
			</div>
			
			<div class="col text">
				<div><h3>게시판신고접수현황</h3></div>
				<table> 
					<tr class="thead" style="background-color:lightGray;">
						<td style="width:100px;">번호</td>
						<td style="width:700px;">제목</td>
						<td style="width:700px;">신고사유</td>
						<td>신고자</td>
						<td>신고일시</td>
						<td>처리현황</td>
					</tr>
					<c:forEach var="b" items="${list}"> 
						<tr class="tbody" >
							<td><c:out value="${b.declareNo}"/></td>
							<td>
								<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${b.boardNo}&memberId=null">
									<c:out value="${b.boardTitle}"/>
								</a>
							</td>
							<td><c:out value="${b.declareContent}"/></td>
							<td><c:out value="${b.declareWriter}"/></td>
							<td><c:out value="${b.declareDate }"/></td>
							<c:if test="${b.declareResult==null}">
								<td><button type="button" class="btn btn-primary">접수</button></td>
							</c:if>
							<c:if test="${b.declareResult!=null}">
								<td><button type="button" class="btn btn-success">처리완료</button></td>
							</c:if>
						</tr>
					</c:forEach>
				</table>
			 
			</div>
			<div>
				${pageBar}
			</div>
		</div>
		
		
		
		
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
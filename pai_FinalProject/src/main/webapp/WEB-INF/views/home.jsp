<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=""/>
</jsp:include>
<style>
	.title{
		font-size:30px;
		font-weight:bolder;
		color:red;
		font-family:monospace;
	} 
	.contents{
		margin-top:10px;
		background-color: lavender ;
		width:600px;
		height:300px;
		/* border:black 1px solid; */
	}
	
	.mbti-title{
		font-size:30px;
		font-weight:bolder; 
		font-family: Geogia;
	}
	
	.main{
		margin-top:10px;
		background-color: lavender ;
		width:1250px;
		height:500px;
	}
	
	.main-table>td{
		height:50px;
		width:130px;
		background-color: palevioletred;
		font-size:20px;
		font-weight:bolder;
		text-align:center;
	}
	.main-content{
		text-align:center;
		border-bottom:lightgrey 1px solid;
		font-size:18px;
	    height:45px;
	}
</style>
<section>
	<%-- <div class="container" style="margin-top:30px;"> 
		<!-- 종합인기글, 인기정보글 -->
		<div class="row">
			<div class="col title">
				<img src="${path}/resources/images/board/star.png" style="width:50px;height:50px;"/>
				종합인기글 TOP5
			</div>
			<div class="col title">
				<img src="${path}/resources/images/board/fire.png" style="width:50px;height:50px;"/>
				인기정보글 TOP5	
			</div>
		</div>
		
		 <div class="row">
		 <!-- 종합인기글 -->
		    <div class="col">
		      <div class="contents">
		      <table style="width:590px;"> 
					<c:forEach var="t" items="${top}">
						<tr style="border-bottom: lightgrey 1px solid; height:60px;">
							<td style="font-size:20px;   font-weight:bolder;font-family: Georgia">[<c:out value="${t.boardCategory}"/>]</td>
							<td style="font-size:20px;"> 
							<c:if test="${loginMember==null}"> 
								<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${t.boardNo}&memberId=null">
									<c:out value="${t.boardTitle}"/>
									<span style="font-weight:bolder;">[<c:out value="${t.commentCount}"/>]</span>
								</a> 
							</c:if>	
							<c:if test="${loginMember!=null}"> 
								<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${t.boardNo}&memberId=${loginMember.member_id}">
									<c:out value="${t.boardTitle}"/>
									<span style="font-weight:bolder;">[<c:out value="${t.commentCount}"/>]</span>
								</a> 
							</c:if>
							</td>
							<td style="width:50px;color:#004080;font-size:20px;text-align:right;"><c:out value="${t.recommendCount}"/></td> 
						</tr>
					</c:forEach>
				</table>
		      </div>
		    </div>
		    <!-- 정보인기글 -->
		    <div class="col">
		      <div class="contents">
		      	<table style="width:590px;"> 
					<c:forEach var="i" items="${info}">
						<tr style="border-bottom: lightgrey 1px solid; height:60px;">
							<td style="font-size:20px;   font-weight:bolder;font-family: Georgia">[<c:out value="${i.boardCategory}"/>]</td>
							<td style="font-size:20px;"> 
							<c:if test="${loginMember==null }">
								<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${i.boardNo}&memberId=null">
									<c:out value="${i.boardTitle}"/>
									<span style="font-weight:bolder;">
										[<c:out value="${i.commentCount}"/>]
									</span>
								</a> 
							</c:if>	
							<c:if test="${loginMember!=null }">
								<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${i.boardNo}&memberId=${loginMember.member_id}">
									<c:out value="${i.boardTitle}"/>
									<span style="font-weight:bolder;">
										[<c:out value="${i.commentCount}"/>]
									</span>
								</a> 
							</c:if>	
							</td>
							<td style="width:50px;color:#004080;font-size:20px;text-align:right;"><c:out value="${i.recommendCount}"/></td> 
						</tr>
					</c:forEach>
				</table> 
		      </div>
		    </div> 
		  </div>
		  
		  <!-- MBTI별 인기글 조회 -->
			<!-- Example single danger button -->
			<div class="row" style="margin-top:10px;">
			  <div class="col mbti-title">
				  <img src="${path}/resources/images/board/best.png" style="width:50px;height:50px;"/>
				  	MBTI별 인기글 TOP10
			  </div>
			  <div class="col-1" style="padding:0px;margin-right:10px;">  
			  <form name="searchMainBoard"> 
					<select id="category" name="category" style="height: 40px;  "> 
						<option value="INTJ" ${category eq "INTJ"?"selected":""}>INTJ</option>
						<option value="INTP" ${category eq "INTP"?"selected":""}>INTP</option>
						<option value="ENTJ" ${category eq "ENTJ"?"selected":""}>ENTJ</option>
						<option value="ENTP" ${category eq "ENTP"?"selected":""}>ENTP</option>
						<option value="INFJ" ${category eq "INFJ"?"selected":""}>INFJ</option>
						<option value="INFP" ${category eq "INFP"?"selected":""}>INFP</option>
						<option value="ENFJ" ${category eq "ENFJ"?"selected":""}>ENFJ</option>
						<option value="ENFP" ${category eq "ENFP"?"selected":""}>ENFP</option>
						<option value="ISTJ" ${category eq "ISTJ"?"selected":""}>ISTJ</option>
						<option value="ISFJ" ${category eq "ISFJ"?"selected":""}>ISFJ</option>
						<option value="ESTJ" ${category eq "ESTJ"?"selected":""}>ESTJ</option>
						<option value="ESFJ" ${category eq "ESFJ"?"selected":""}>ESFJ</option>
						<option value="ISTP" ${category eq "ISTP"?"selected":""}>ISTP</option>
						<option value="ISFP" ${category eq "ISFP"?"selected":""}>ISFP</option>
						<option value="ESTP" ${category eq "ESTP"?"selected":""}>ESTP</option>
						<option value="ESFP" ${category eq "ESFP"?"selected":""}>ESFP</option>
						<option value="INFO" ${category eq "INFO"?"selected":""}>정보</option>
					</select> 
			  </form>  
			  </div>
			</div> 
			<div class="main">
				<table>
					<tr class="main-table">
						<td>카테고리</td>
						<td style="width:600px; ">제목</td>
						<td>작성자</td>
						<td>등록일</td>
						<td>조회수</td>
						<td>추천수</td>
					</tr>
					 
				<c:forEach var="b" items="${list}">
					<tr class="main-content"> 
						<td><c:out value="${b.boardCategory}"/></td>
						<td>
							<c:if test="${loginMember!=null }"> 
								<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${b.boardNo}&memberId=${loginMember.member_id}">
									<c:out value="${b.boardTitle}"/><span style="font-weight:bolder;">[<c:out value="${b.commentCount}"/>]</span>
								</a>
							</c:if>
							<c:if test="${loginMember==null }"> 
								<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${b.boardNo}&memberId=null">
									<c:out value="${b.boardTitle}"/><span style="font-weight:bolder;">[<c:out value="${b.commentCount}"/>]</span>
								</a>
							</c:if>
						</td>
						<td><c:out value="${b.boardWriter.member_nick}"/></td>
						<td><c:out value="${b.boardEnrollDate}"/></td>
						<td><c:out value="${b.boardReadCount}"/></td>
						<td><c:out value="${b.recommendCount}"/></td>
					</tr>
				</c:forEach>	
				</table>
			</div>
	
	
	</div> --%>
</section>

<script>
/* 	$("#category").change(e=>{
		searchMainBoard.action="${path}/searchMainBoard.do";
		searchMainBoard.category.value=$("#category").val();
		searchMainBoard.submit();
	}) */

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> 
<style>
.main-box{
	margin: 0px auto;
	padding-top: 30px;
}
.left-top{
	background-color: red;
	margin-right: 29px;
	border-start-end-radius: 30px;
	border-top-left-radius: 30px;
}
.right-top{
	background-color: orange; 
	border-start-end-radius: 30px;
	border-top-left-radius: 30px;
}
.left-box{
	border: red 4px solid;
	margin-right: 30px;
	border-end-start-radius: 30px;
	border-end-end-radius: 30px;
}
.right-box{
	border: orange 4px solid;
	border-end-start-radius: 30px;
	border-end-end-radius: 30px;
}
section>*{
	font-family: sans-serif;
 
}
.form-check{
	margin: 0px;
}
.right-box2 {
  float: right;
}
#main-table>*{
	text-decoration: none;
	text-align:center;
}
 
</style>
 <section> 
	<div class="container">
		<div class="main-box">
		
		 	<div class="row">
			    <div class="col left-top" >
			     <h2 style="font-weight: bolder;">조회수 인기글</h2>
			    </div>
			    <div class="col right-top">
			      <h2 style="font-weight: bolder;">추천수 인기글</h2>
			    </div>
		    </div>
		   	<div class="row">
			    <div class="col left-box" >
					<table style="width:600px;"> 
					<c:forEach var="r" items="${readList}">
						<tr>
							<td style="font-size:20px; font-weight:bolder;color:blue;"> <c:out value="${r.boardCategory}"/></td>
							<td style="font-size:20px;">
								<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${r.boardNo}&memberId=${loginMember.member_id}">
									<c:out value="${r.boardTitle}"/>
									<span style="font-weight:bolder;">[<c:out value="${r.comment.size()}"/>]</span>
								</a>
							</td>
							<td style="width:50px;color:#004080;font-size:20px;text-align:right;"><c:out value="${r.boardReadCount}"/></td> 
						</tr>
					</c:forEach>
					</table> 
			    </div>
			    <div class="col right-box">
			    	<table style="width:600px;"> 
					<c:forEach var="like" items="${likeList}">
						<tr>
							<td style="font-size:20px; font-weight:bolder;color:blue;"> <c:out value="${like.boardCategory}"/></td>
							<td style="font-size:20px;">
								<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${like.boardNo}&memberId=${loginMember.member_id}">
									<c:out value="${like.boardTitle}"/>
									<span style="font-weight:bolder;">[<c:out value="${like.comment.size()}"/>]</span>
								</a>
							</td>
							<td style="width:50px;color:#004080;font-size:20px;text-align:right;"><c:out value="${like.recommendCount}"/></td> 
						</tr>
					</c:forEach>
					</table> 
		    </div>
	    </div>
	</div>

	<div class="middle-box" style="margin-top: 30px;">
		<table id="main-table"> 
			<tr>
				<td colspan="5" style="text-align:left;">
					<img src="http://www.todayhumor.co.kr/board/images/topmenu_total.gif" style="height: 20px;">
				</td>
				<td colspan="3">
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1" onclick="location.assign('${path}/board/boardList.do')" ${select==null?'checked':''}>
						<label class="form-check-label" for="inlineRadio1">최신순</label>
				    </div>
			    	<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2" onclick="location.assign('${path}/board/clickRead.do?select=read')" ${select eq "read"?"checked":""}>
						<label class="form-check-label" for="inlineRadio2">조회순</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option3" onclick="location.assign('${path}/board/clickLike.do?select=like')" ${select eq "like"?"checked":""}>
						<label class="form-check-label" for="inlineRadio3">추천순</label>
				    </div>
				</td>
				
			</tr>
			<tr>
				<td style="width:48px;color:#004080;font-size:16px;text-align:center; background:url(http://www.todayhumor.co.kr/board/images/bar_left_back.gif)">번호</td>
				<td style="width:100px;color:#004080;font-size:16px;text-align:center;background:url(http://www.todayhumor.co.kr/board/images/bar_back.gif);">카테고리</td>
				<td style="color:#004080;font-size:16px;text-align:center;background:url(http://www.todayhumor.co.kr/board/images/bar_back.gif);"></td>
				<td style="width:700px;color:#004080;font-size:16px;text-align:center;background:url(http://www.todayhumor.co.kr/board/images/bar_back.gif);">제목</td>
				<td style="width:120px;color:#004080;font-size:16px;text-align:center;background:url(http://www.todayhumor.co.kr/board/images/bar_back.gif);">이름</td>
				<td style="width:150px;color:#004080;font-size:16px;text-align:center;background:url(http://www.todayhumor.co.kr/board/images/bar_back.gif);">날짜</td>
				<td style="width:50px;color:#004080;font-size:16px;text-align:center;background:url(http://www.todayhumor.co.kr/board/images/bar_back.gif);">조회</td>
				<td style="width:50px;color:#004080;font-size:16px;text-align:center; background:url(http://www.todayhumor.co.kr/board/images/bar_right_back.gif) no-repeat -17px 0px;">추천</td> 
			</tr>
			<c:forEach var="b" items="${list}">
				<tr style="border-bottom:1px gray solid; height:40px;">
					<td><c:out value="${b.boardNo}"/></td>
					<td><c:out value="${b.boardCategory}"/></td>
					<td>
						<c:if test="${b.attachFile.size()>0}">
							<img src="${path}/resources/images/board/file.png" style="width:30px; height:30px;">
						</c:if>
					</td>
					<td style="text-align:left; text-decoration:none;">
							<a style="text-decoration:none; color:black;" href="${path}/board/boardView.do?boardNo=${b.boardNo}&memberId=${b.boardWriter.member_id}">
								<c:out value="${b.boardTitle}"/>
								<span style="font-weight:bolder;">[<c:out value="${b.comment.size()}"/>]</span> 
							</a>
					</td>
					<td>
						<a style="text-decoration:none; color:black;" href="${path}/board/myboardView.do?memberId=${b.boardWriter.member_id}">
						<c:out value="${b.boardWriter.member_nick}"/>
						</a>
					</td>
					<td><c:out value="${b.boardEnrollDate}"/></td>
					<td><c:out value="${b.boardReadCount}"/></td>
					<td><c:out value="${b.recommendCount}"/></td>  
				</tr>
			</c:forEach> 
			<c:if test="${empty list}">
					<tr>
						<td colspan="8" style="text-align:center;"><p>조회된 게시물이 없습니다.</p></td>
					</tr>
				</c:if>
			<tr>
				<td colspan="8" style="height:40px; text-align:center">${pageBar}</td>
			</tr>
		</table>	
	</div>
	 
	<div class="row">
	    <div class="col-10" style="display: inline-block; text-align: center;">
			<form action="${path}/board/searchBoard.do">
				<span>
					<select name="category" style="height: 30px;">						
						<option value="">MBTI</option>
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
						<option value="info" ${category eq "info"?"selected":""}>정보</option>
					</select>
				</span>
				<span>
					<select name="searchType" style="height: 30px;">
						<option value="board_title" >제목</option>
						<option value="member_nick" ${searchType eq "member_nick"?"selected":""}>닉네임</option>
					</select>
				</span>
				<span>
					<input type="text" name="keyword" value="${keyword!=null?keyword:''}" >
				</span>
				<span>
					<button type="submit" class="btn btn-outline-primary">검색</button>
				</span>
			</form>
		</div>
	    <div class="col-2">
	    	<button type="button" class="btn btn-primary" onclick="location.assign('${path}/board/insertBoard.do')">글쓰기</button>
	    </div>
	</div>
	
	
	
	 
</div>
	
</section> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
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
section{
	font-family: 굴림체;
}
.form-check{
	margin: 0px;
}
.right-box2 {
  float: right;
}
 
</style>
 <section> 
	<div class="container">
		<div class="main-box">
		
		 	<div class="row">
			    <div class="col left-top" >
			     <h2 style="font-weight: bolder;">주간 조회수 인기글</h2>
			    </div>
			    <div class="col right-top">
			      <h2 style="font-weight: bolder;">주간 추천수 인기글</h2>
			    </div>
		    </div>
		   	<div class="row">
			    <div class="col left-box" >
					리스트으 <br>
					리스트으 <br>
					리스트으 <br>
					리스트으 <br>
					리스트으 <br>
			        리스트으 <br>
				    리스트으 <br>
			        리스트으 <br>
				    리스트으 <br>
			        리스트으 <br>
			    </div>
			    <div class="col right-box">
			    	리스트으 <br>
					리스트으 <br>
					리스트으 <br>
					리스트으 <br>
					리스트으 <br>
			        리스트으 <br>
				    리스트으 <br>
			        리스트으 <br>
				    리스트으 <br>
			        리스트으 <br>
		    </div>
	    </div>
	</div>

	<div class="middle-box" style="margin-top: 30px;">
		<table> 
			<tr>
				<td colspan="5">
					<img src="http://www.todayhumor.co.kr/board/images/topmenu_total.gif" style="height: 20px;">
				</td>
				<td colspan="3">
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1" checked>
						<label class="form-check-label" for="inlineRadio1">최신순</label>
				    </div>
			    	<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
						<label class="form-check-label" for="inlineRadio2">댓글순</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option3">
						<label class="form-check-label" for="inlineRadio3">추천순</label>
				    </div>
				</td>
				
			</tr>
			<tr>
				<td style="width:48px;color:#004080;font-size:16px;text-align:center; background:url(http://www.todayhumor.co.kr/board/images/bar_left_back.gif)">번호</td>
				<td style="width:100px;color:#004080;font-size:16px;text-align:center;background:url(http://www.todayhumor.co.kr/board/images/bar_back.gif);">카테고리</td>
				<td style="color:#004080;font-size:16px;text-align:center;background:url(http://www.todayhumor.co.kr/board/images/bar_back.gif);">첨부파일</td>
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
					<td>파일</td>
					<td><c:out value="${b.boardTitle}"/></td>
					<td><c:out value="${b.boardWriter.member_nick}"/></td>
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
	    <div class="col-11" style="display: inline-block; text-align: center;">
			<form action="${path}/board/searchBoard.do">
				<span>
					<select name="category" style="height: 30px;">						
						<option value="">MBTI</option>
						<option value="INTJ">INTJ</option>
						<option value="INTP">INTP</option>
						<option value="ENTJ">ENTJ</option>
						<option value="ENTP">ENTP</option>
						<option value="INFJ">INFJ</option>
						<option value="INFP">INFP</option>
						<option value="ENFJ">ENFJ</option>
						<option value="ENFP">ENFP</option>
						<option value="ISTJ">ISTJ</option>
						<option value="ISFJ">ISFJ</option>
						<option value="ESTJ">ESTJ</option>
						<option value="ESFJ">ESFJ</option>
						<option value="ISTP">ISTP</option>
						<option value="ISFP">ISFP</option>
						<option value="ESTP">ESTP</option>
						<option value="ESFP">ESFP</option>
						<option value="info">정보</option>
					</select>
				</span>
				<span>
					<select name="searchType" style="height: 30px;">
						<option value="board_title">제목</option>
						<option value="member_nick">닉네임</option>
					</select>
				</span>
				<span>
					<input type="text" name="keyword" >
				</span>
				<span>
					<button type="submit" class="btn btn-outline-primary">검색</button>
				</span>
			</form>
		</div>
	    <div class="col-1">
	    	<button type="button" class="btn btn-primary" onclick="location.assign('${path}/board/insertBoard.do')">글쓰기</button>
	    </div>
	</div>
	
	
	
	 
</div>
	
</section> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
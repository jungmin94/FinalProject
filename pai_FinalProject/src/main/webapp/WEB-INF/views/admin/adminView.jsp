<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> 
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
		height:700px; 
		/* margin-top:50px; */
	} 
	.navi{
		width:150px;
		border-right: lightGray 2px solid;
	}
	table>*{
		text-align:center;
	}
 	thead>tr>th{
		width:150px;
		font-size:20px;
	}  
	.select{
		margin-left:500px;
		margin-bottom:20px;
	}
	.select>div{
		display:inline;
	}
</style>
<section>
	<div class="container">
		<div class="admin">
			회원관리
		</div>
		<div class="row" style="margin-top:20px;"> 
		  <form action="${path}/admin/searchMember.do"> 
			<div class="select">
				<select id="selectType" name="searchType">
					<option value="member_id" ${searchType eq "member_id"?"selected":""}>아이디</option>
					<option value="member_name" ${searchType eq "member_name"?"selected":""}>이름</option>
					<option value="member_nick" ${searchType eq "member_nick"?"selected":""}>닉네임</option>
					<option value="member_gender" ${searchType eq "member_gender"?"selected":""}>성별</option>
				</select>
					<c:if test="${searchType ne 'member_gender'}"> 
							<div> 
							<input id="search-user" name="keyword" type="text" value="${keyword!=null?keyword:''}">
							</div>
							<div id="search-gender" style="display:none;"> 
								<label><input type="radio" name="gender" value="남" ${keyword==null&&gender eq "남"?"checked":""}>남</label>
								<label><input type="radio" name="gender" value="여" ${keyword==null&&gender eq "여"?"checked":""}>여</label>
							</div>
					</c:if>
					<c:if test="${searchType eq 'member_gender'}">  
							<div> 
							<input id="search-user" name="keyword" type="text" style="display:none;"> 
							</div>
							<div id="search-gender"> 
								<label><input type="radio" name="gender" value="남" ${gender eq "남"?"checked":""}>남</label>
								<label><input type="radio" name="gender" value="여" ${gender eq "여"?"checked":""}>여</label>
							</div>
					</c:if> 
				<button type="submit">Search</button>
			</div>
		  </form>
			<div class="navi col-2"> 
				<ul class="nav flex-column">
				  <li class="nav-item">
				    <a class="nav-link active" aria-current="page" href="${path}/admin/adminView.do">홈</a>
				  </li>
				  <li class="nav-item dropdown">
			          <a class="nav-link dropdown-toggle"  id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
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
				<table>
					<thead>
						<tr style="border-bottom:2px black solid;">
							<th style="width:100px;">아이디</th>
							<th style="width:300px;">이름</th>
							<th style="width:400px;">닉네임</th>
							<th style="width:500px;">생년월일</th>
							<th style="width:300px;">성별</th>
							<th>이메일</th>
							<th style="width:700px;">주소</th>
							<th>휴대폰</th>
							<th>MBTI</th>
							<th style="width:500px;">가입일</th>
							<th style="width:300px;">경고</th>
							<th style="width:300px;">블랙</th>
						</tr>
					</thead>
					<tbody> 
					
						<c:if test="${empty list}">
							<tr>
								<td colspan="12">검색된 결과가 없습니다.</td>
							</tr>
						</c:if>
						<c:forEach var="m" items="${list}">
							<c:if test="${m.member_black==0}"> 
								<tr style="border-bottom:1px lightGray solid;">
							</c:if>	
							<c:if test="${m.member_black==1}"> 
								<tr style="border-bottom:1px lightGray solid; background-color:lightpink;">
							</c:if>	
									 <td><c:out value="${m.member_id}"/></td> 
									 <td><c:out value="${m.member_name}"/></td> 
									 <td><c:out value="${m.member_nick}"/></td> 
									 <td><c:out value="${m.member_date}"/></td> 
									 <td><c:out value="${m.member_gender}"/></td> 
									 <td><c:out value="${m.member_email}"/></td> 
									 <td><c:out value="${m.member_addr}"/></td> 
									 <td><c:out value="${m.member_phone}"/></td> 
									 <td><c:out value="${m.member_mbti}"/></td> 
									 <td><c:out value="${m.member_enroll}"/></td> 
									 <td><c:out value="${m.member_police}"/></td> 
									 <c:if test="${m.member_black==0}"> 
										 <td>N</td>
										 <!-- <td><button  class="btn btn-outline-primary">등록</button></td>  -->
									 </c:if> 
									 <c:if test="${m.member_black==1}"> 
									 	<td>Y</td>
										 <!-- <td><button  class="btn btn-danger">해제</button></td>  -->
									 </c:if>
						 		</tr>
						</c:forEach>
					</tbody>
				</table>
			</div> 
		</div>
			<div style="margin-top:30px;">
				${pageBar}
			</div>
	</div>
</section>

<script>
	$("#selectType").change(e=>{
		const value=$(e.target).val();
		console.log(value);
		if(value=='member_gender'){
			$("#search-user").css("display","none");
			$("#search-gender").css("display","inline-block");
		}else{
			$("#search-user").css("display","inline-block");
			$("#search-gender").css("display","none");
		}
	})


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
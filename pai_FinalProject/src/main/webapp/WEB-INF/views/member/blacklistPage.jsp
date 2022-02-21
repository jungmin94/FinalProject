<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<c:set var="path" value="${pageContext.request.contextPath }"/> 
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.blacklist {
	  width: 30%;
	  height: 700px;
	  background: red;
	  border-radius: 20px;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  flex-direction: column;
	}
	.wrap {
	  width: 100%;
	  height: 100vh;
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  background: red;
	}
</style>
<title>블랙리스트</title>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section>
	<div class="wrap">
		<div class="blacklist">
			<div>
				<img src="${path }/resources/images/member/blacklist.jpg" style=width:400px;,height:400px;>
			</div>
			<div>
				<h1>
					회원님께서는 다수의 신고<br>접수로 인해서 현재 <br>블랙리스트 상태입니다.
				</h1>
				<h3>		
					블랙리스트에 등록된 회원일 경우 저희<br>PAI의 모든 서비스를 이용하실 수 없습니다.<br>
					이용 신청 혹은 신고 관련 문의는 <br>pai2022@gmail.com<br>으로 문의 주시기 바랍니다.
				</h3>
			</div>
		</div>
	</div>
		
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
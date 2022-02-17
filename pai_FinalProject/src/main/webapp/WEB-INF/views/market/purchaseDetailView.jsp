<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section>
<div class="container">
<br>
<form action="${path}/market/pay.do">
 <div style="text-align: center; font-size:20px; color: blueviolet;">구매자 정보</div>
  이름<input type="text"  id="name_ro" name="ordererName" class="form-control" value="${loginMember.member_name}" readonly><br>
  이메일<input type="text" id="email_ro" name="ordererEmail" class="form-control" value="${loginMember.member_email}" readonly><br>
  휴대폰 번호<input type="text" id="phone_ro" name="ordererPhone" class="form-control" value="${loginMember.member_phone}" readonly><br>
  <input type="hidden" id="addr_ro" name="" class="form-control" value="${loginMember.member_addr}" readonly><br>

  <div style="text-align: center; font-size:20px; color: blueviolet;">받는사람 정보<br><br>
	<button type="button" id="equalInfoBtn" class="btn btn-outline-info">구매자 정보와 동일</button>
  </div>
  이름<input type="text"  id="name_in" name="receiverName" class="form-control" value=""><br>
  배송주소<input type="text" id="addr_in" name="receiverAddress" class="form-control" value=""><br>
  연락처<input type="text" id="phone_in" name="receiverPhone" class="form-control" value=""><br>
  <br>

  <!-- 주문한 상품 내역 (반복문) -->
  <div style="text-align: center; font-size:20px; color: blueviolet;">주문내역</div>
 <table class="table align-middle" style="text-align: center;">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">상품명</th>
      <th scope="col">색상</th>
      <th scope="col">사이즈</th>
      <th scope="col">MBTI 로고</th>
	  <th scope="col">수량</th>
	  <th scope="col">가격</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">1</th>
      <td>${orderDetail.goodsName}</td>
      <td>${orderDetail.orderColor}</td>
      <td>${orderDetail.orderSize}</td>
      <td>${orderDetail.mbtiLogo}</td>
      <td>${orderDetail.orderCount}</td>
      <td>${orderDetail.orderPrice}</td>
    </tr>
  </tbody>
</table>
 <input type="hidden"  name="member_id" class="form-control" value="${loginMember.member_id}" readonly>
 <input type="hidden"  name="goodsNo" class="form-control" value="${orderDetail.goodsNo}" readonly>
 <input type="hidden"  name="goodsName" class="form-control" value="${orderDetail.goodsName}" readonly>
 <input type="hidden"  name="orderColor" class="form-control" value="${orderDetail.orderColor}" readonly>
 <input type="hidden"  name="orderSize" class="form-control" value="${orderDetail.orderSize}" readonly>
 <input type="hidden"  name="mbtiLogo" class="form-control" value="${orderDetail.mbtiLogo}" readonly>
 <input type="hidden"  name="orderCount" class="form-control" value="${orderDetail.orderCount}" readonly>
 <input type="hidden"  name="orderPrice" class="form-control" value="${orderDetail.orderPrice}" readonly>
 
<br>
  
  <div style="text-align: center; font-size:20px; color: blueviolet;">결제금액</div>
  	총 상품금액<input type="text"  id="" name="totalOrderPrice" class="form-control" value="${orderDetail.orderPrice}" readonly><br>
  	<button type="submit" class="btn btn-outline-primary" >결제</button>
	<button type="button" class="btn btn-outline-secondary">취소</button>
  </form>
  <br>
  <br>
	 
</div>
</section>

<script>
$(document).on("click", "#equalInfoBtn", function () { 
	
	$('#name_in').val($('#name_ro').val());
	$('#addr_in').val($('#addr_ro').val());
	$('#phone_in').val($('#phone_ro').val());
	
});


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
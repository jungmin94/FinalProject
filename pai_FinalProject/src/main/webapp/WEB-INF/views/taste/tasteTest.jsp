<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> 

<style>
article{
    display:flex;
    flex-direction:column;
}

.exam{
    display:none;
}

/* .result{
    display: none;
} */
</style>

 <section> 
	<div class="container">
		<article class="start">
			<h2 class="mt-5 text-center">취향 테스트</h2>
	        <button type="button" class="btn btn-primary mt-5" onclick='start();'>테스트 시작하여 친구찾기</button>
	        <button type="button" class="btn btn-primary mt-5" onclick="">기존테스트로 친구찾기</button>
		</article>
		
		<article class="exam">
			<div class="progress mt-5">
				<div class="progress-bar" role="progressbar" style="width: calc(100/5*1%)"></div>
			</div>
			<h2 id="title" class="text-center mt-5">문제</h2>
			<input id="type" type="hidden" value="exam01">
			<button id="A" type="button" class="btn btn-primary mt-5">A</button>
			<button id="B" type="button" class="btn btn-primary mt-5">B</button>
		</article>
		
		<!-- <article class="result">
			결과로 친구리스트 가져와야함
		</article> -->
	<form id="taste_form" action="${path}/taste/insertTaste.do" method="post">
		<input type="hidden" name="exam01" id="exam01" value="0">
		<input type="hidden" name="exam02" id="exam02" value="0">
		<input type="hidden" name="exam03" id="exam03" value="0">
		<input type="hidden" name="exam04" id="exam04" value="0">
		<input type="hidden" name="exam05" id="exam05" value="0">
	</form>
		
	</div>
	
	<script>
		var num=1;
		var exam = {
				1:{"title":"문제 1번", "type":"exam01", "A":"짜장면" ,"B":"짬뽕"},
				2:{"title":"문제 2번", "type":"exam02", "A":"부먹" ,"B":"찍먹"},
				3:{"title":"문제 3번", "type":"exam03", "A":"물냉면" ,"B":"비빔냉면"},
				4:{"title":"문제 4번", "type":"exam04", "A":"민초파" ,"B":"반민초파"},
				5:{"title":"문제 5번", "type":"exam05", "A":"물복" ,"B":"딱복"}
		}
		
		
		function start() {
			$(".start").hide();
			$(".exam").show();
			  next();
		}
		
        $("#A").click(e=>{
            var type = $("#type").val();
            var preValue = $("#"+type).val();
            $("#"+type).val(parseInt(preValue)+1);
            next();
        });
        $("#B").click(e=>{
       	 	next();
        });
        
        function next() {
        	if(num == 6) {
        		 $(".question").hide();
                 $(".result").show();
                 var taste = "";  
                 ($("#exam01").val()==1) ? $("#exam01").val("짜장면") : $("#exam01").val("짬뽕");
                 ($("#exam02").val()==1) ? $("#exam02").val("부먹") : $("#exam02").val("찍먹");
                 ($("#exam03").val()==1) ? $("#exam03").val("물냉면") : $("#exam03").val("비빔냉면");
                 ($("#exam04").val()==1) ? $("#exam04").val("민초파") : $("#exam04").val("반민초파");
                 ($("#exam05").val()==1) ? $("#exam05").val("물복") : $("#exam05").val("딱복");
                console.log($("#exam01").val());
                console.log($("#exam02").val());
                console.log($("#exam03").val());
                console.log($("#exam04").val());
                console.log($("#exam05").val());
                $("#taste_form").submit();
        	} else{
        		$(".progress-bar").attr('style','width: calc(100/5*'+num+'%)');
        		$("#title").html(exam[num]["title"]);
        		$("#type").val(exam[num]["type"]);
        		$("#A").html(exam[num]["A"]);
                $("#B").html(exam[num]["B"]);
                num++;
      
        	}
        }
		
	</script>
</section> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
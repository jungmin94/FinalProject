<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="게시판"/>
</jsp:include>
<style>
    article {
        display: flex;
        flex-direction: column; 
    }
    .question {
        display: none;
    }
    .result{
        display: none;
    }
    #img{
        width: 300px;
        height: 300px;
        margin: 0 auto;
    }
</style>
<body class="container">
    <article class="start"> 
        <h1 class="mt-5 text-center">나랑 꼭 닮은 세렝게티 동물은?</h1>
        <button type="button" class="btn btn-primary mt-5" onclick='start();'>테스트 시작하기</button>
    </article>
    <article class="question">
        <div class="progress mt-5">
            <div class="progress-bar" role="progressbar" style="width: calc(100/12*1%)"></div>
        </div>
        <h2 id="title" class="text-center mt-5">문제</h2>
        <input id="type" type="hidden" value="EI">
        <button id="A" type="button" class="btn btn-primary mt-5">Primary</button>
        <button id="B" type="button" class="btn btn-primary mt-5">Primary</button>
    </article>
    <article class="result">
        <img id="img" class="rounded-circle mt-5" src="lion.jpg" alt="animal">
        <h2 id="animal" class="text-center mt-5">동물이름</h2>
        <h3 id="explain"class="text-center mt-5">설명</h3>
    </article>
    <input type="hidden" id="EI" value="0">
    <input type="hidden" id="SN" value="0">
    <input type="hidden" id="TF" value="0">
    <input type="hidden" id="JP" value="0">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    <script>
        var num=1;
        var q={
            1: {"title":"문제 1번","type":"EI","A":"E","B":"I"},
            2: {"title":"문제 2번","type":"EI","A":"E","B":"I"},
            3: {"title":"문제 3번","type":"EI","A":"E","B":"I"},
            4: {"title":"문제 4번","type":"SN","A":"S","B":"N"},
            5: {"title":"문제 5번","type":"SN","A":"S","B":"N"},
            6: {"title":"문제 6번","type":"SN","A":"S","B":"N"},
            7: {"title":"문제 7번","type":"TF","A":"T","B":"F"},
            8: {"title":"문제 8번","type":"TF","A":"T","B":"F"},
            9: {"title":"문제 9번","type":"TF","A":"T","B":"F"},
            10: {"title":"문제 10번","type":"JP","A":"J","B":"P"},
            11: {"title":"문제 11번","type":"JP","A":"J","B":"P"},
            12: {"title":"문제 12번","type":"JP","A":"J","B":"P"}
        }
        var result={
            "ISTJ" : {"animal":"하마","explain":"하마 설명","img":"lion.jpg"},
            "ISTP" : {"animal":"사자","explain":"사자 설명","img":"lion.jpg"},
            "ISFJ" : {"animal":"코끼리","explain":"코끼리 설명","img":"lion.jpg"},
            "ISFP" : {"animal":"고릴라","explain":"고릴라 설명","img":"lion.jpg"},
            "INTJ" : {"animal":"치타","explain":"치타 설명","img":"lion.jpg"},
            "INTP" : {"animal":"가젤","explain":"가젤 설명","img":"lion.jpg"},
            "INFJ" : {"animal":"코뿔소","explain":"코뿔소 설명","img":"lion.jpg"},
            "INFP" : {"animal":"원숭이","explain":"원숭이 설명","img":"lion.jpg"},
            "ESTJ" : {"animal":"표범","explain":"표범 설명","img":"lion.jpg"},
            "ESTP" : {"animal":"물소","explain":"물소 설명","img":"lion.jpg"},
            "ESFJ" : {"animal":"기린","explain":"기린 설명","img":"lion.jpg"},
            "ESFP" : {"animal":"오랑우탄","explain":"오랑우탄 설명","img":"lion.jpg"},
            "ENTJ" : {"animal":"재규어","explain":"재규어 설명","img":"lion.jpg"},
            "ENTP" : {"animal":"침팬치","explain":"침팬치 설명","img":"lion.jpg"},
            "ENFJ" : {"animal":"하이에나","explain":"하이에나 설명","img":"lion.jpg"},
            "ENFP" : {"animal":"독수리","explain":"독수리 설명","img":"lion.jpg"},

        }
        function start() {
            $(".start").hide();
            $(".question").show();
            next();
        }
        $("#A").click(function(){
            var type=$("#type").val();
            var preValue=$("#"+type).val();
            $("#"+type).val(parseInt(preValue)+1)
            next();
        });
        $("#B").click(function(){
            next();
        });
        function next(){
            if(num==13){
                $(".question").hide();
                $(".result").show();
                var mbti="";
                ($("#EI").val()<2) ? mbti+="I" : mbti+="E";
                ($("#SN").val()<2) ? mbti+="N" : mbti+="S";
                ($("#TF").val()<2) ? mbti+="F" : mbti+="T";
                ($("#JP").val()<2) ? mbti+="P" : mbti+="J";
                alert(mbti);
                $("#img").attr("src",result[mbti]["img"]);
                $("#animal").html(result[mbti]["animal"]);
                $("#explain").html(result[mbti]["explain"]);
            }else{
                $(".progress-bar").attr('style','width: calc(100/12*'+num+'%)');
                $("#title").html(q[num]["title"]);
                $("#type").val(q[num]["type"]);
                $("#A").html(q[num]["A"]);
                $("#B").html(q[num]["B"]);
                num++;
            }
        }
    </script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
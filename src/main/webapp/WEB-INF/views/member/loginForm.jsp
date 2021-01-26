<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html >
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <c:if test='${not empty message }'>
        <script>
            window.onload = function () {
                result();
            }

            function result() {
                alert("아이디나  비밀번호가 틀립니다. 다시 로그인해주세요");
            }
        </script>
    </c:if>

    <style>
        body {
            width: 100vw;
            height: 100vh;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-div {
            max-width: 430px;
            padding: 35px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .logo {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin: 0 auto;
    </style>

    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

</head>
<body>
<div class="login-div">
    <form action="${contextPath}/member/login.do" method="post">

        <div class="row center-align">
            <h1>BOOKTOPIA</h1>
        </div>

        <div class="row center-align">
            <h5>Sign in</h5>
            <h6>Use your Account</h6>
        </div>


        <div class="row">
            <div class="input-field col s12">
                <td class="fixed_join">Account</td>
                <td><input name="member_id" type="text" size="20"></td>
            </div>
        </div>
        <div class="row">
            <div class="input-field col s12">
                <td class="fixed_join">password</td>
                <td><input name="member_pw" type="password" size="20"></td>
            </div>
        </div>

        <div class="row"></div>
        <div class="row">
            <div class="col s6"><a href="${contextPath}/member/memberForm.do">Create account</a></div>
            <div class="col s6 right-align">
                <input type="submit" value="Login" class="waves-effect waves-light btn"></div>
        </div>

        <br><br>


        <Br><br>
        <a href="#">아이디 찾기</a> |
        <a href="#">비밀번호 찾기</a> |
        <a href="#">고객 센터</a>
    </form>
</div>
</body>
</html>
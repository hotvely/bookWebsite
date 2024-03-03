<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Insert title here</title>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    </head>
    <body>
        <h1>회원가입</h1>

        <div class="form-el">
            아이디 : <input type="text" name="username" id="username" placeholder="아이디를 입력해 주세요" required />
        </div>

        <div class="form-el">
            비밀번호 :
            <input type="text" name="password" id="password" placeholder="비밀번호를 입력해 주세요" required />
        </div>

        <div class="form-el">
            이메일 : <input type="text" name="email" id="email" placeholder="이메일을 입력해 주세요" required />
        </div>

        <div class="form-el">
            전화번호 : <input type="text" name="phone" id="phone" placeholder="전화 번호를 입력해 주세요" required />
        </div>

        <div class="form-el">
            닉네임 : <input type="text" name="nickname" id="nickname" placeholder="닉네임을 입력해 주세요" required />
        </div>

        <br />

        <button id="registerBtn" onclick="register()">가입</button>
        <!-- <button onclick="registerAdmin()">관리자 가입</button> -->

        <!-- 일반유저 회원가입 -->
        <script>
            $(document).ready(function () {
                // 현재 URL이 /member/register/admin인 경우에만 registerAdmin 버튼을 추가
                if (window.location.pathname === "/member/register/admin") {
                    $("body").append('<button id="registerAdminBtn" onclick="registerAdmin()">관리자 가입</button>');
                    $("#registerBtn").hide();
                }
            });
            const register = () => {
                let member = {
                    username: $("#username").val(),
                    password: $("#password").val(),
                    email: $("#email").val(),
                    phone: $("#phone").val(),
                    nickname: $("#nickname").val(),
                };
                $.ajax({
                    url: "/member/register",
                    type: "POST",
                    data: member,
                    success: function (response) {
                        console.log(response);
                        if (response != null) {
                            alert("회원가입 성공");
                            window.location.href = "/";
                            console.log(member);
                        }
                    },
                    error: function (error) {
                        console.log("회원가입 에러");
                    },
                });
            };

            //   <!-- 관리자 회원가입 -->

            const registerAdmin = () => {
                let member = {
                    username: $("#username").val(),
                    password: $("#password").val(),
                    email: $("#email").val(),
                    phone: $("#phone").val(),
                    nickname: $("#nickname").val(),
                    admin: true,
                };

                $.ajax({
                    url: "/member/register/admin",
                    type: "POST",
                    data: member,
                    success: function (response) {
                        console.log(response);
                        if (response != null) {
                            alert("관리자가입 성공");
                            window.location.href = "/";
                            console.log(member);
                        }
                    },
                    error: function (error) {
                        console.log("관리자가입 에러");
                    },
                });
            };
        </script>
    </body>
</html>

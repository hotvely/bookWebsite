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
            <button id="idCheckBtn" onclick="checkId()">중복체크</button>
        </div>

        <div class="form-el">
            비밀번호 :
            <input type="text" name="password" id="password" placeholder="비밀번호를 입력해 주세요" required />
            <!-- <div id="pwdWarning" class="warning-message"></div> -->
        </div>

        <div class="form-el">
            닉네임 : <input type="text" name="nickname" id="nickname" placeholder="닉네임을 입력해 주세요" required />
            <button id="nickCheckBtn" onclick="checkNick()">중복체크</button>
        </div>

        <div class="form-el">
            이메일 : <input type="text" name="email" id="email" placeholder="이메일을 입력해 주세요" required />
            <!-- <div id="emailWarning" class="warning-message"></div> -->
        </div>

        <div class="form-el">
            전화번호 : <input type="text" name="phone" id="phone" placeholder="전화 번호를 입력해 주세요" required />
            <!-- <div id="phoneWarning" class="warning-message"></div> -->
        </div>

        <br />

        <button id="registerBtn" onclick="register()">가입</button>

        <script>
            let isUserId = false;
            let isNick = false;

            // const warningMessage = (id, message) => {
            //     $(`#${id}`).text(message);
            // };

            $(document).ready(function () {
                // 현재 URL이 /member/register/admin인 경우에만 registerAdmin 버튼을 추가
                if (window.location.pathname === "/member/register/admin") {
                    $("body").append('<button id="registerAdminBtn" onclick="registerAdmin()">관리자 가입</button>');
                    $("#registerBtn").hide();
                }
            });

            // 아이디 중복 체크 로직
            const checkId = () => {
                let username = $("#username").val();
                const idRegExp = /^[a-zA-z0-9]{4,12}$/;

                if ((username.length < 4 || username.length > 12) && !idRegExp.test(username)) {
                    alert("아이디는 4-12글자 사이로 대소문자 또는 숫자만 입력해 주세요.");
                    return;
                }

                $.ajax({
                    url: "/member/idCheck?username=" + username,
                    type: "GET",
                    success: function (response) {
                        if (response) {
                            alert("사용 가능한 아이디 입니다.");
                            isUserId = true;
                        } else {
                            alert("이미 사용중인 아이디 입니다.");
                            isUserId = false;
                        }
                    },
                });
            };

            // 닉네임 중복 체크 로직
            const checkNick = () => {
                let nickname = $("#nickname").val();
                if (nickname.length < 2 || nickname.length > 8) {
                    alert("닉네임은 2글자 이상 8글자 이하로 입력해주세요.");
                    return;
                }
                $.ajax({
                    url: "/member/nickCheck?nickname=" + nickname,
                    type: "GET",
                    success: function (response) {
                        if (response) {
                            alert("사용 가능한 닉네임 입니다.");
                            isNick = true;
                        } else {
                            alert("이미 사용중인 닉네임 입니다.");
                            isNick = false;
                        }
                    },
                });
            };

            // 아이디 닉네임 중복 체크후 가입 로직 실행
            const register = () => {
                let member = {
                    username: $("#username").val(),
                    password: $("#password").val(),
                    email: $("#email").val(),
                    phone: $("#phone").val(),
                    nickname: $("#nickname").val(),
                };

                if (!member.username || !member.password || !member.email || !member.password || !member.nickname) {
                    alert("모든 정보를 입력하세요.");
                    return;
                }

                if (!isUserId) {
                    alert("아이디 중복을 확인해주세요.");
                    return;
                }

                if (!isNick) {
                    alert("닉네임 중복을 확인해주세요.");
                    return;
                }

                const pwdRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
                if (!pwdRegExp.test(member.password)) {
                    // warningMessage("pwdWarning", "숫자+영문자+특수문자 사용해서 8자리 이상 입력해주세요.");
                    alert("숫자+영문자+특수문자 사용해서 8자리 이상 입력해주세요.");
                    return;
                }

                const emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
                if (!emailRegExp.test(member.email)) {
                    // warningMessage("emailWarning", "이메일 형식이 올바르지 않습니다.");
                    alert("이메일 형식이 올바르지 않습니다.");
                    return;
                }

                const phoneRegExp = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
                if (!phoneRegExp.test(member.phone)) {
                    // warningMessage("phoneWarning", "올바른 전화번호 형식이 아닙니다.");
                    alert("올바른 전화번호 형식이 아닙니다.");
                    return;
                }

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

            // 관리자 회원가입
            const registerAdmin = () => {
                if (isUserId) {
                    let member = {
                        username: $("#username").val(),
                        password: $("#password").val(),
                        email: $("#email").val(),
                        phone: $("#phone").val(),
                        nickname: $("#nickname").val(),
                        admin: true,
                    };

                    if (!member.username || !member.password || !member.email || !member.password || !member.nickname) {
                        alert("모든 정보를 입력하세요.");
                        return;
                    }

                    if (!isUserId) {
                        alert("아이디 중복을 확인해주세요.");
                        return;
                    }

                    const pwdRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
                    if (!pwdRegExp.test(member.password)) {
                        alert("숫자+영문자+특수문자 사용해서 8자리 이상 입력해주세요.");
                        return;
                    }

                    const emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
                    if (!emailRegExp.test(member.email)) {
                        alert("이메일 형식이 올바르지 않습니다.");
                        return;
                    }

                    const phoneRegExp = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
                    if (!phoneRegExp.test(member.phone)) {
                        alert("올바른 전화번호 형식이 아닙니다.");
                        return;
                    }

                    if (!isNick) {
                        alert("닉네임 중복을 확인해주세요.");
                        return;
                    }

                    $.ajax({
                        url: "/member/register/admin",
                        type: "POST",
                        data: member,
                        success: function (response) {
                            console.log(response);
                            if (response != null) {
                                alert("운영자 가입 성공");
                                window.location.href = "/";
                                console.log(member);
                            }
                        },
                        error: function (error) {
                            console.log("운영자 가입 에러");
                        },
                    });
                } else {
                    alert("아이디 중복을 확인해주세요.");
                }
            };
        </script>
        <style>
            .warning-message {
                display: none;
                color: red;
            }
        </style>
    </body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Insert title here</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
        />
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"
        ></script>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <!-- axios 사용하기 위한 스크립트... -->
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    </head>
    <body>
        <!-- <div class="form-el">
            아이디 : <input type="text" name="username" id="username" placeholder="아이디를 입력해 주세요" required />
            <button id="idCheckBtn" onclick="checkId()">중복체크</button>
        </div> -->

        <!-- <div class="form-el">
            비밀번호 :
            <input type="text" name="password" id="password" placeholder="비밀번호를 입력해 주세요" required />
        </div> -->

        <!-- <div class="form-el">
            닉네임 : <input type="text" name="nickname" id="nickname" placeholder="닉네임을 입력해 주세요" required />
            <button id="nickCheckBtn" onclick="checkNick()">중복체크</button>
        </div> -->

        <!-- <div class="form-el">
            이메일 : <input type="text" name="email" id="email" placeholder="이메일을 입력해 주세요" required />
        </div> -->

        <!-- <div class="form-el">
            전화번호 : <input type="text" name="phone" id="phone" placeholder="전화 번호를 입력해 주세요" required />
        </div> -->

        <div id="register-form">
            <h1>회원가입</h1>

            <div id="register-submit">
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="username" placeholder="name@example.com" />
                    <label for="floatingInput">아이디를 입력해 주세요</label>
                    <button id="nickCheckBtn" class="btn btn-secondary" onclick="checkId()">중복체크</button>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="password" placeholder="Password" />
                    <label for="floatingPassword">비밀번호를 입력해 주세요</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="nickname" placeholder="name@example.com" />
                    <button id="nickCheckBtn" class="btn btn-secondary" onclick="checkNick()">중복체크</button>
                    <label for="floatingInput">닉네임을 입력해 주세요</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="email" placeholder="name@example.com" />
                    <label for="floatingInput">이메일을 입력해 주세요</label>
                </div>

                <div class="form-floating mb-3" id="floating-3">
                    <input type="text" class="form-control" id="phone" placeholder="name@example.com" />
                    <label for="floatingInput">전화번호를 입력해 주세요</label>
                    <button id="registerBtn" onclick="register()" class="btn btn-secondary">가입</button>
                </div>
            </div>
        </div>

        <script>
            let isUserId = false;
            let isNick = false;

            $(document).ready(function () {
                // 현재 URL이 /member/register/admin인 경우에만 registerAdmin 버튼을 추가
                if (window.location.pathname === "/member/register/admin") {
                    $("#floating-3").append(
                        '<button id="registerAdminBtn" onclick="registerAdmin()" class="btn btn-secondary">관리자 가입</button>'
                    );
                    $("#registerBtn").hide();
                }
            });

            // 아이디 중복 체크 로직
            const checkId = async () => {
                let username = $("#username").val();
                const idRegExp = /^[a-zA-z0-9]{4,12}$/;

                if ((username.length < 4 || username.length > 12) && !idRegExp.test(username)) {
                    alert("아이디는 4-12글자 사이로 대소문자 또는 숫자만 입력해 주세요.");
                    return;
                }
                const response = await axios.post("/member/idCheck?username=" + username);

                if (response.data) {
                    alert("사용 가능한 아이디 입니다.");
                    isUserId = true;
                } else {
                    alert("이미 사용중인 아이디 입니다.");
                    isUserId = false;
                }
            };

            // 닉네임 중복 체크 로직
            const checkNick = async () => {
                let nickname = $("#nickname").val();
                if (nickname.length < 2 || nickname.length > 8) {
                    alert("닉네임은 2글자 이상 8글자 이하로 입력해주세요.");
                    return;
                }
                const response = await axios.post("/member/nickCheck?nickname=" + nickname);
                if (response.data) {
                    alert("사용 가능한 닉네임 입니다.");
                    isNick = true;
                } else {
                    alert("이미 사용중인 닉네임 입니다.");
                    isNick = false;
                }
            };

            // 아이디 닉네임 중복 체크후 가입 로직 실행
            const register = async () => {
                let member = new URLSearchParams({
                    username: $("#username").val(),
                    password: $("#password").val(),
                    email: $("#email").val(),
                    phone: $("#phone").val(),
                    nickname: $("#nickname").val(),
                });

                if (
                    !member.get("username") ||
                    !member.get("password") ||
                    !member.get("email") ||
                    !member.get("password") ||
                    !member.get("nickname")
                ) {
                    return alert("모든 정보를 입력하세요.");
                }

                if (!isUserId) {
                    return alert("아이디 중복을 확인해주세요.");
                }

                if (!isNick) {
                    return alert("닉네임 중복을 확인해주세요.");
                }

                const pwdRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
                if (!pwdRegExp.test(member.get("password"))) {
                    return alert("숫자+영문자+특수문자 사용해서 8자리 이상 입력해주세요.");
                }

                const emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
                if (!emailRegExp.test(member.get("email"))) {
                    return alert("이메일 형식이 올바르지 않습니다.");
                }

                const phoneRegExp = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
                if (!phoneRegExp.test(member.get("phone"))) {
                    return alert("올바른 전화번호 형식이 아닙니다.");
                }

                const response = await axios.post("/member/register", member);
                if (response != null) {
                    alert("회원가입 성공");
                    window.location.href = "/";
                }
            };

            // 관리자 회원가입
            const registerAdmin = async () => {
                if (isUserId) {
                    let member = new URLSearchParams({
                        username: $("#username").val(),
                        password: $("#password").val(),
                        email: $("#email").val(),
                        phone: $("#phone").val(),
                        nickname: $("#nickname").val(),
                        admin: true,
                    });

                    if (
                        !member.get("username") ||
                        !member.get("password") ||
                        !member.get("email") ||
                        !member.get("password") ||
                        !member.get("nickname")
                    ) {
                        return alert("모든 정보를 입력하세요.");
                    }

                    if (!isUserId) {
                        alert("아이디 중복을 확인해주세요.");
                        return;
                    }

                    const pwdRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
                    if (!pwdRegExp.test(member.get("password"))) {
                        return alert("숫자+영문자+특수문자 사용해서 8자리 이상 입력해주세요.");
                    }

                    const emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
                    if (!emailRegExp.test(member.get("email"))) {
                        return alert("이메일 형식이 올바르지 않습니다.");
                    }

                    const phoneRegExp = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
                    if (!phoneRegExp.test(member.get("phone"))) {
                        return alert("올바른 전화번호 형식이 아닙니다.");
                    }
                    if (!isNick) {
                        alert("닉네임 중복을 확인해주세요.");
                        return;
                    }

                    const response = await axios.post("/member/register/admin", member);
                    if (response != null) {
                        alert("관리자 가입 성공");
                        window.location.href = "/";
                    }
                } else {
                    alert("아이디 중복을 확인해주세요.");
                }
            };
        </script>
        <style>
            body {
                background-color: white;
            }
            h1 {
                text-align: center;
                padding-top: 5%;
                padding-bottom: 5%;
                color: lightslategray;
            }

            #register-form {
                background-color: antiquewhite;
                margin: 0 auto;
                margin-top: 5%;
                width: 50%;
                border-radius: 5px;
            }
            #register-submit {
                margin: 0 auto;
                width: 50%;
            }

            #registerBtn,
            #registerAdminBtn {
                margin-bottom: 5%;
            }

            .form-floating {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .form-floating button {
                margin-top: 10px;
            }
        </style>
    </body>
</html>

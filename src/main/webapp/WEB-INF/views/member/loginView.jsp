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
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    </head>
    <body>
        <div id="login-form">
            <h1>로그인</h1>

            <div id="login-submit">
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="username" placeholder="name@example.com" />
                    <label for="floatingInput">아이디를 입력해 주세요</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="password" placeholder="Password" />
                    <label for="floatingPassword">비밀번호를 입력해 주세요</label>
                    <button id="loginBtn" onclick="login()" class="btn btn-secondary">로그인</button>
                </div>
            </div>
        </div>
        <script>
            const login = async () => {
                let member = new URLSearchParams();
                member.append("username", $("#username").val());
                member.append("password", $("#password").val());

                const response = await axios.post("/member/login", member);

                if (response.data == "Y") {
                    alert("관리자 로그인");
                    window.location = "/";
                } else if (response.data == "N") {
                    alert("유저 로그인");
                    window.location = "/";
                } else {
                    alert("로그인 실패");
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

            #login-form {
                background-color: antiquewhite;
                margin: 0 auto;
                margin-top: 10%;
                width: 50%;
                border-radius: 5px;
            }

            #login-submit {
                margin: 0 auto;
                width: 50%;
            }

            #loginBtn {
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

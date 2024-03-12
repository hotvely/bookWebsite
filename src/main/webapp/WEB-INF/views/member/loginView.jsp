<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Insert title here</title>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    </head>
    <body>
        <h1>로그인</h1>

        <div class="form-login">
            아이디 : <input type="text" name="username" id="username" placeholder="아이디를 입력해 주세요" required />
        </div>

        <div class="form-login">
            비밀번호 :
            <input type="text" name="password" id="password" placeholder="비밀번호를 입력해 주세요" required />
        </div>

        <br />

        <button id="loginBtn" onclick="login()">로그인</button>

        <script>
            $(document).ready(function () {
                // 현재 URL이 /member/login/admin인 경우에만 loginAdmin 버튼을 추가
                if (window.location.pathname === "/member/login/admin") {
                    $("body").append('<button id="registerAdminBtn" onclick="adminLogin()">관리자 로그인</button>');
                    $("#loginBtn").hide();
                }
            });

            const login = async () => {
                let member = new URLSearchParams();
                member.append("username", $("#username").val());
                member.append("password", $("#password").val());
                const response = await axios.post("/member/login", member);
                if (response) {
                    window.location = "/";
                }
            };

            const adminLogin = async () => {
                let member = new URLSearchParams();
                member.append("username", $("#username").val());
                member.append("password", $("#password").val());
                member.append("admin", "Y");
                const response = await axios.post("/member/login/admin", member);
                if (response) {
                    alert("관리자 로그인");
                    window.location = "/";
                }
            };
        </script>
    </body>
</html>

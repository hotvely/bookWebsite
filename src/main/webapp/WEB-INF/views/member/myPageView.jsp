<%@page import="com.practice.semi.vo.Member"%> <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
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
        <!-- axios 사용하기 위한 스크립트... -->
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    </head>

    <body>
        <%@ include file="/WEB-INF/views/header.jsp" %>
        <div id="info">
            <div class="form-el">
                <ul class="list-group list-group-horizontal">
                    <li class="list-group-item">아이디 :</li>
                    <li class="list-group-item"><div name="m-username" id="m-username">${member.id}</div></li>
                </ul>

                <ul class="list-group list-group-horizontal">
                    <li class="list-group-item">이메일 :</li>
                    <li class="list-group-item"><div name="m-email" id="m-email">${member.email}</div></li>
                </ul>

                <ul class="list-group list-group-horizontal">
                    <li class="list-group-item">전화번호 :</li>
                    <li class="list-group-item"><div name="m-phone" id="m-phone">${member.phone}</div></li>
                </ul>

                <ul class="list-group list-group-horizontal">
                    <li class="list-group-item">닉네임 :</li>
                    <li class="list-group-item"><div name="m-nickname" id="m-nickname">${member.nickname}</div></li>
                </ul>
            </div>
            <button id="btn-open-modal" class="btn btn-secondary" style="margin-top: 20px">회원정보 수정</button>
        </div>

        <div id="updateModal">
            <div id="modal_body">
                <h3>회원수정</h3>

                <div class="form-floating mb-3">
                    <input type="hidden" id="usercode" value="${member.code}" />
                    <input type="hidden" id="username" value="${member.id}" />
                    <input type="text" class="form-control" id="password" placeholder="Password" />
                    <label for="floatingPassword">비밀번호를 입력해 주세요</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="email" placeholder="name@example.com" />
                    <label for="floatingInput">이메일을 입력해 주세요</label>
                </div>

                <div class="form-floating mb-3" id="floating-3">
                    <input type="text" class="form-control" id="phone" placeholder="name@example.com" />
                    <label for="floatingInput">전화번호를 입력해 주세요</label>
                    <input type="hidden" id="admin" value="${member.admin}" />
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="nickname" placeholder="name@example.com" />
                    <button style="margin-top: 10px" id="nickCheckBtn" class="btn btn-primary" onclick="checkNick()">
                        닉네임 중복체크
                    </button>
                    <label for="floatingInput">닉네임을 입력해 주세요</label>
                </div>

                <button class="btn btn-success" onclick="updateMember()">정보수정</button>
                <button class="btn btn-danger" onclick="deleteMembr()">회원탈퇴</button>
            </div>
        </div>

        <script>
            // 닉네임 중복 체크 로직
            let isNick = false;

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
            const updateMember = async () => {
                let member = new URLSearchParams({
                    code: $("#usercode").val(),
                    username: $("#username").val(),
                    password: $("#password").val(),
                    email: $("#email").val(),
                    phone: $("#phone").val(),
                    nickname: $("#nickname").val(),
                    admin: $("#admin").val(),
                });
                const response = await axios.put("/member/update", member);
                alert("정보 수정 성공");
                if (response != null) {
                    modal.style.display = "none";
                    window.location.href = "/";
                }
            };

            const deleteMembr = async () => {
                const code = $("#usercode").val();
                const response = await axios.delete("/member/delete?code=" + code);
                if (response != null) {
                    window.location.href = "/";
                }
            };

            const modal = document.querySelector("#updateModal");
            const btnOpenModal = document.querySelector("#btn-open-modal");

            btnOpenModal.addEventListener("click", () => {
                modal.style.display = "flex";
            });

            window.addEventListener("click", (event) => {
                if (event.target === modal) {
                    closeModal();
                }
            });

            function closeModal() {
                // input text 요소의 값을 비움
                document.getElementById("password").value = "";
                document.getElementById("email").value = "";
                document.getElementById("phone").value = "";
                document.getElementById("nickname").value = "";
                modal.style.display = "none";
            }
        </script>

        <style>
            #updateModal {
                position: absolute;
                display: none;
                justify-content: center;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;

                background-color: rgba(0, 0, 0, 0.4);
            }
            #modal_body {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                max-width: 80%;
                max-height: 80%;
                overflow: auto; /* 내용이 넘칠 경우 스크롤 생성 */
                padding: 50px;
                text-align: center;
                background-color: rgb(255, 255, 255);
                border-radius: 10px;
                box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
            }

            #info {
                display: flex;
                flex-direction: column;
                align-items: center;
            }
        </style>
    </body>
</html>

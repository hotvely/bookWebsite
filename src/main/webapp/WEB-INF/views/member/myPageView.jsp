<%@page import="com.practice.semi.vo.Member"%> <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Insert title here</title>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    </head>
    <body>
        <%@ include file="/WEB-INF/views/header.jsp" %>

        <h1>내 정보 ${member.id }</h1>
        <div id="info"></div>

        <div id="updateModal">
            <div id="modal_body">
                <h3>회원수정할꺼임?</h3>
                <div class="form-el">
                    <input type="hidden" id="usercode" value="${member.code}" />

                    <input type="hidden" id="username" value="${member.id}" />

                    비밀번호 :
                    <input type="text" name="password" id="password" placeholder="변경할 비밀번호를 입력하세요" />
                </div>

                <div class="form-el">
                    이메일 : <input type="text" name="email" id="email" placeholder="변경할 이메일을 입력하세요" />
                </div>

                <div class="form-el">
                    전화번호 : <input type="text" name="phone" id="phone" placeholder="변경할 전화번호를 입력하세요" />
                </div>

                <div class="form-el">
                    닉네임 :
                    <input type="text" name="nickname" id="nickname" placeholder="변경할 닉네임을 입력하세요" />
                </div>

                <input type="hidden" id="admin" value="${member.admin}" />

                <br />

                <button onclick="updateMember()">정보수정</button>

                <button onclick="deleteMembr()">회원탈퇴</button>
            </div>
        </div>
        <button id="btn-open-modal">정보 수정 모달</button>

        <div class="form-el">
            <div class="form-el">
                <div name="email" id="email">이메일 : ${member.email}</div>
            </div>

            <div class="form-el">
                <div name="phone" id="phone">전화번호 : ${member.phone}</div>
            </div>

            <div class="form-el">
                <div name="nickname" id="nickname">닉네임 : ${member.nickname}</div>
            </div>
        </div>

        <script>
            const updateMember = () => {
                let member = {
                    code: $("#usercode").val(),
                    username: $("#username").val(),
                    password: $("#password").val(),
                    email: $("#email").val(),
                    phone: $("#phone").val(),
                    nickname: $("#nickname").val(),
                    admin: $("#admin").val(),
                };
                $.ajax({
                    url: "/member/update",
                    type: "PUT",
                    data: member,
                    success: function (response) {
                        console.log(response);
                        alert("정보수정 성공");
                        if (response != null) {
                            modal.style.display = "none";
                            window.location.href = "/";
                        }
                    },
                    error: function (error) {
                        console.log("정보수정 에러");
                    },
                });
            };

            const deleteMembr = () => {
                const code = $("#usercode").val();
                $.ajax({
                    url: "/member/delete?code=" + code,
                    type: "DELETE",
                    success: function (response) {
                        console.log(response);
                        alert("회원탈퇴 성공");
                        if (response != null) {
                            window.location.href = "/";
                        }
                    },
                    error: function (error) {
                        console.log("회원탙퇴 에러");
                    },
                });
            };

            // $("#info").append("<div>${member.id}</div>");

            const modal = document.querySelector("#updateModal");
            const btnOpenModal = document.querySelector("#btn-open-modal");

            btnOpenModal.addEventListener("click", () => {
                modal.style.display = "flex";
            });
            window.addEventListener("click", (event) => {
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            });
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
                width: 300px;
                height: 300px;
                padding: 40px;
                text-align: center;
                background-color: rgb(255, 255, 255);
                border-radius: 10px;
                box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);

                transform: translateY(-50%);
            }
        </style>
    </body>
</html>

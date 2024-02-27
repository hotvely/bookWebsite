<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Insert title here</title>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    </head>
    <body>
        <script>
            console.log(`${member}`);
            const handlerMember = (data) => {
                console.log("handlerMember");
            };

            const handlerBook = (data) => {
                console.log("handlerMember");
            };
            const getMember = () => {
                try {
                    $.ajax({
                        url: "/header",
                        method: "POST",
                        success: function (data) {
                            handlerMember(data);

                            if (data.id != null) {
                                $("#header").append("지금은 로그인이 되어 있는 상태 입니다<br/>");
                                $("#header").append(
                                    '<a href="/member/myPage">마이페이지</a>  <a href="/member/logout" >로그아웃</a>'
                                );
                            } else {
                                $("#header").append("로그인 필요해요<br/>");
                                $("#header").append(
                                    '<a href="/member/register">회원가입</a>  <a href="/member/login">로그인</a>'
                                );
                            }
                        },
                    });
                } catch (error) {
                    console.error("Error: " + error);
                    throw error;
                }
            };

            // 초기 페이지 로딩 시 getMember 함수 호출
            getMember();

            const getBook = () => {
                try {
                    $.ajax({
                        url: "/book/show",
                        method: "POST",
                        data: { code: 1 },
                        success: function (data) {
                            console.log(data);
                            handlerBook(data);
                        },
                    });
                } catch (error) {
                    console.error("Error: " + error);
                    throw error;
                }
            };

            // 초기 페이지 로딩 시 getMember 함수 호출
            getBook();

            $("#logout").click(function () {
                $.ajax({
                    type: "POST",
                    url: "/member/logout",
                    success: function () {
                        console.log("로그아웃 성공");
                        alert("로그아웃 성공");
                    },
                    error: function () {
                        console.log("로그아웃 실패");
                    },
                });
            });
        </script>

        ${book.authority} ${member.nickname}
        <div id="header"></div>

        <!-- ${member} 서버 세션의 키값과 변수명 같아야함 -->
    </body>
</html>

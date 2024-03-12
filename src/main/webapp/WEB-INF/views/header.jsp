<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Insert title here</title>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script type="text/javascript" src="/javascript/Cookie.js"></script>
        <!-- axios 사용하기 위한 스크립트... -->
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    </head>

    <body>
        <script>
            let member = null;

            if ({ member } != null) member = { member }.member;

            const getMember = async () => {
                try {
                    const response = await axios.post("/header");
                    if (response.data != "") {
                        member = response.data;
                        $("#header").append("지금은 로그인이 되어 있는 상태 입니다<br/>");
                        $("#header").append(
                            '<a href="/member/myPage">마이페이지</a>' +
                                "<br/>" +
                                '<a href="/member/myCart">장바구니</a>' +
                                "<br/>" +
                                '<a href="/member/logout">a태그 로그아웃</a>' +
                                "<br/>" +
                                '<button onclick="logout()">로그아웃</button>'
                        );

                        // 일반 유저면 책 추가 버튼 숨김
                        if (member != null && member.admin === "Y") {
                            $("#addBooks").show();
                        } else {
                            $("#addBooks").hide();
                        }
                    } else {
                        $("#header").append("로그인 필요해요<br/>");
                        $("#header").append(
                            '<a href="/member/register">회원가입</a>  <a href="/member/login">로그인</a>'
                        );
                        // 항시 책 추가 버튼 숨김 비 로그인시에 안보이게 하기위해
                        $("#addBooks").hide();
                    }
                } catch (error) {
                    console.error("Error: " + error);
                    throw error;
                }
            };

            // 초기 페이지 로딩 시 getMember 함수 호출

            const logout = async () => {
                const response = await axios.post("/member/logout");
                console.log(response);
                if (response.data == true) {
                    console.log("로그아웃 성공");
                    alert("로그아웃 성공");
                    window.location.href = "/";
                } else {
                    console.log("로그아웃 실패");
                }
            };

            const getCategory = async () => {
                const response = await axios.get("/category/category");
                console.log(response);
                if (response.data != null) {
                    for (let data of response.data) {
                        $("#category").append("<div>" + data.category + "</div>");
                        $("#subcategory").append(`<div id=subcategory\${data.code}></div>`);
                    }
                }
            };

            const getSubCategory = async () => {
                const response = await axios.get("/category/subCategory");
                if (response.data != null) {
                    for (let data of response.data) {
                        $(`#subcategory\${data.categorycode}`).append(
                            `<a href=/book/showAll/subCategory?pageNum=1&scode=\${data.code}>\${data.subcategory}</a>`
                        );
                    }
                }
            };
            getMember();
            getCategory();
            getSubCategory();
        </script>

        <div id="home">
            <a href="/">홈</a>
        </div>
        <div id="header"></div>
        <div id="category"></div>
        <div id="subcategory"></div>

        <script>
            console.log(member);
        </script>
    </body>
</html>

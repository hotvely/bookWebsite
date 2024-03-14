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
                        $(".navbar-nav").append(
                            '<a class="nav-link active" aria-current="page" href="/member/myPage">마이페이지</a>' +
                                "<br/>" +
                                '<a class="nav-link" href="/member/myCart">장바구니</a>' +
                                "<br/>" +
                                '<button class="nav-link active" aria-current="page" onclick="logout()">로그아웃</button>'
                        );
                        // if (member == null) {
                        //     $("#addBooks").hide();
                        // }

                        // 일반 유저면 책 추가 버튼 숨김
                        if (member != null && member.admin == "Y") {
                            $("#addBooks").show();
                            // } else if (member == null) {
                            //     $("#addBooks").hide();
                        } else {
                            $("#addBooks").hide();
                        }
                    } else {
                        $(".navbar-nav").append(
                            '<a class="nav-link active" aria-current="page" href="/member/register">회원가입</a> <a class="nav-link active" aria-current="page" href="/member/login">로그인</a>'
                        );
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
                        $("#category").append(
                            ` <ul class="list-group list-group-horizontal-xxl">` +
                                `<li class="list-group-item">` +
                                data.category +
                                `</li>` +
                                `<li class="list-group-item"><div id="subcategory\${data.code}"></div></li>` +
                                `</ul>`
                        );
                        // $("#subcategory").append(`<div id=subcategory\${data.code}></div>`);
                    }
                }
            };

            const getSubCategory = async () => {
                const response = await axios.get("/category/subCategory");
                if (response.data != null) {
                    for (let data of response.data) {
                        $(`#subcategory\${data.categorycode}`).append(
                            `<a style="margin-right: 10px; color: gray;
    text-decoration: none;" href=/book/showAll/subCategory?pageNum=1&scode=\${data.code}>\${data.subcategory}</a>`
                        );
                    }
                }
            };
            getMember();
            getCategory().then(() => {
                // getCategory가 완료되면 getSubCategory 호출
                getSubCategory();
            });
        </script>

        <div id="nav-bar">
            <nav class="navbar navbar-expand-lg bg-body-tertiary">
                <div class="container-fluid" style="background-color: antiquewhite">
                    <a class="navbar-brand" href="/">홈</a>
                    <button
                        class="navbar-toggler"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#navbarNavAltMarkup"
                        aria-controls="navbarNavAltMarkup"
                        aria-expanded="false"
                        aria-label="Toggle navigation"
                    >
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                        <div class="navbar-nav"></div>
                    </div>
                </div>
            </nav>
        </div>

        <div id="categories">
            <div id="category"></div>
            <div id="subcategory"></div>
        </div>

        <style>
            #nav-bar {
                display: flex;
                flex-direction: column;
                align-items: center;
                background-color: antiquewhite;
            }
            #categories {
                margin-top: 20px;
                margin-bottom: 20px;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .bg-body-tertiary {
                background-color: inherit !important; /* nav-bar 배경색 상속 */
            }
        </style>
    </body>
</html>

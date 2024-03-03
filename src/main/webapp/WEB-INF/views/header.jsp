<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8"/>
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script type="text/javascript" src="/javascript/Cookie.js"></script>
</head>

<body>
	<div id="home"><a href="/">홈</a></div>
	<div id="header"></div>
	
	<script>
    console.log(`${member}`);
    let member = null;
   console.log(getCookie('cart'));
    
    
    const handlerMember = (data) => {
    	console.log(data);
    	member = data;
    	console.log(member);
        console.log("handlerMember");
    };

    const getMember = () => {
        try {
            $.ajax({
                url: "/header",
                method: "POST",
                success: function (data) {
                   

                    if (data.id != null) {
                    	 handlerMember(data);
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


    const logout = () => {
        $.ajax({
            type: "POST",
            url: "/member/logout",
            success: function (response) {
                if (response) {
                    console.log("로그아웃 성공");
                    alert("로그아웃 성공");
                }
                window.location.href = "/";
            },
            error: function () {
                console.log("로그아웃 실패");
            },
        });
    };		
    </script>
</body>
</html>

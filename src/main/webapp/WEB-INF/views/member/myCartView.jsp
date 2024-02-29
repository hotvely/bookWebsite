<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Insert title here</title>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    </head>
    <body>
        <%@ include file="/WEB-INF/views/header.jsp"%>

        <h2>장바구니 페이지 입니다</h2>

        <div id="cartList"></div>

        <button onclick="deleteCart('cart')">책 삭제</button>
        <button onclick="deleteAllCart()">장바구니 비우기</button>

        <script>
            const getCookie = (key) => {
                const cookies = document.cookie.split(";");

                for (let elem of cookies) {
                    let cookie = elem.trim();
                    if (cookie.startsWith(key + "=")) {
                        return decodeURIComponent(cookie.substring(key.length + 1));
                    }
                }
                return null;
            };

            // 특정 쿠키 삭제 이제 장바구니에 책이 여러개일때 처리할거 짜야함
            const deleteCart = (key) => {
                console.log(key);
                document.cookie = key + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
                location.reload();
            };

            // 쿠키 전체 삭제
            const deleteAllCart = () => {
                const cookies = document.cookie.split(";");

                for (const cookie of cookies) {
                    const trimmedCookie = cookie.trim();
                    const cookieName = trimmedCookie.split("=")[0];
                    document.cookie = cookieName + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
                    console.log(cookieName);
                }

                location.reload();
            };
            const myCart = () => {
                const cartInfo = JSON.parse(getCookie("cart"));
                console.log(cartInfo);

                const cartElement = $("#cartList");
                console.log(cartElement);

                if (cartInfo != null && cartInfo.length > 0) {
                    for (const item of cartInfo) {
                        const con = "";
                        cartElement.append(
                            `<img width="100px" alt="xxx" src="${
                                item.image != null ? item.image : "/images/basic.jpeg"
                            }"/>` +
                                `<br/>` +
                                ` <a href="/book/detail?code=\${item.code}">책 제목: \${item.title}</a>` +
                                `<br/>` +
                                `<div>글쓴이: \${item.authority}</div>` +
                                `<div>가격: \${item.price}</div>`
                        );
                    }
                } else {
                    cartElement.append("<div>장바구니가 비었습니다.</div>");
                }
            };
            myCart();
        </script>
    </body>
</html>

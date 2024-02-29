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

        <script>
            const myCart = () => {
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

                const cartInfo = JSON.parse(getCookie("cart"));
                console.log(cartInfo);

                const cartElement = $("#cartList");
                console.log(cartElement);

                if (cartInfo != null && cartInfo.length > 0) {
                    for (const item of cartInfo) {
                        cartElement.append(`<div>책 제목: ${item.title}, 가격: ${item.price}</div>`);
                    }
                } else {
                    cartElement.append("<div>장바구니가 비었습니다.</div>");
                }
            };
            myCart();

            // document.all.key.value = getCookie();
        </script>
    </body>
</html>

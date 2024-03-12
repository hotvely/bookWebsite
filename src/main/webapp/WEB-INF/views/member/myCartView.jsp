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

        <button onclick="deleteAllCart()">장바구니 비우기</button>
        <div id="cartList"></div>

        <script>
            // 특정 쿠키 삭제
            const deleteCartBook = (code) => {
                const cartItem = JSON.parse(getCookie("cart"));
                console.log(cartItem);

                const filterCartItem = cartItem.filter((item) => {
                    return item.code !== code;
                });
                document.cookie =
                    "cart=" + encodeURIComponent(JSON.stringify(filterCartItem)) + "; domain=localhost; path=/";
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

                if (cartInfo != null && cartInfo.length > 0) {
                    for (const item of cartInfo) {
                        // code로 쿠키찾아서 삭제
                        const deleteButton = `<button onclick="deleteCartBook(\${item.code})">책 삭제</button>`;

                        const totalPrice = item.count * item.price;
                        const itemHtml =
                            `<img width="100px" alt="xxx" src="${
                                item.image != null ? item.image : "/images/basic.jpeg"
                            }"/>` +
                            `<br/>` +
                            ` <a href="/book/detail?code=\${item.code}">책 제목: \${item.title}</a>` +
                            `<span> \${deleteButton}</span>` +
                            `<br/>` +
                            `<div>글쓴이: \${item.authority}</div>` +
                            `<div id=ip_\${item.code}>가격: \${totalPrice}</div>` +
                            `<div>수량: <button onclick="updateCart('\${item.code}','minus')">-</button>` +
                            `<span id="quantity_\${item.code}">\${item.count}</span>` +
                            `<button onclick="updateCart('\${item.code}','plus')">+</button></div>`;
                        cartElement.append(itemHtml);
                    }
                } else {
                    cartElement.append("<div>장바구니가 비었습니다.</div>");
                }
            };
            myCart();
            const updateCart = (code, action) => {
                const cartData = JSON.parse(getCookie("cart"));
                console.log(cartData);

                const findCartItem = cartData.filter((item) => item.code == code)[0];
                console.log(findCartItem);

                if (findCartItem != null) {
                    if (action === "plus") {
                        findCartItem.count += 1;
                    } else if (action === "minus" && findCartItem.count > 1) {
                        findCartItem.count -= 1;
                    }

                    const expires = new Date();
                    expires.setDate(expires.getDate() + 60);
                    const expiresDateString = expires.toUTCString();

                    // 쿠키에서 해당 책의 정보 업데이트
                    setCookie("cart", JSON.stringify(cartData), expiresDateString);

                    // HTML에서 수량 업데이트
                    const quantityElement = document.getElementById(`quantity_\${code}`);
                    const itemPrice = document.querySelector(`#ip_\${code}`);

                    if (quantityElement && itemPrice) {
                        console.log(findCartItem.count);
                        quantityElement.textContent = findCartItem.count;
                        itemPrice.innerHTML =
                            "<div id=ip_\${code}>가격: " + findCartItem.count * findCartItem.price + "</div>";
                    }
                }
            };
        </script>
    </body>
</html>

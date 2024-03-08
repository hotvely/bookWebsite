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
            let bookCount = 1;

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

            const countHandler = (count) => {};

            const myCart = () => {
                const cartInfo = JSON.parse(getCookie("cart"));
                console.log(cartInfo);

                const cartElement = $("#cartList");

                if (cartInfo != null && cartInfo.length > 0) {
                    for (const item of cartInfo) {
                        // code로 쿠키찾아서 삭제
                        const deleteButton = `<button onclick="deleteCartBook(\${item.code})">책 삭제</button>`;

                        const itemHtml =
                            `<img width="100px" alt="xxx" src="${
                                item.image != null ? item.image : "/images/basic.jpeg"
                            }"/>` +
                            `<br/>` +
                            ` <a href="/book/detail?code=\${item.code}">책 제목: \${item.title}</a>` +
                            `<span> \${deleteButton}</span>` +
                            `<br/>` +
                            `<div>글쓴이: \${item.authority}</div>` +
                            `<div>가격: \${item.price}</div>` +
                            `<div>수량: <button name="minus" onclick="updateCart('\${item.code}')">-</button>` +
                            `\${bookCount}` +
                            ` <button name="plus" onclick="updateCart('\${item.code}')">+</button></div>`;
                        cartElement.append(itemHtml);
                    }
                } else {
                    cartElement.append("<div>장바구니가 비었습니다.</div>");
                }
            };
            myCart();

            const updateCart = (code, action) => {
                const cartItems = JSON.parse(getCookie("cart"));
                const findCartItems = cartItems.find((item) => item.code == code);
                if (findCartItems) {
                    if (action === "plus") {
                        // html 값 변경 갯수 수량 가격
                        //
                        findCartItems.bookCount = findCartItems.bookCount + 1;
                    } else if (action === "minus") {
                        findCartItems.bookCount = findCartItems.bookCount - 1;
                    }
                    document.cookie = "cart=" + encodeURIComponent(JSON.stringify(cartItems));
                }
            };

            // const updateCart = (code, action) => {
            //     const cartItems = JSON.parse(getCookie("cart"));
            //     console.log(cartItems);
            //     const itemIndex = cartItems.findIndex((item) => item.code === code);
            //     if (itemIndex !== -1) {
            //         cartItems[itemIndex].count = cartItems[itemIndex].count || 1;
            //         console.log(cartItems[itemIndex].count);
            //         if (action === "plus") {
            //             cartItems[itemIndex].count += 1;
            //             console.log("더하기 : " + cartItems[itemIndex].count);
            //         } else if (action === "minus") {
            //             cartItems[itemIndex].count -= 1;
            //             console.log("빼기 : " + cartItems[itemIndex].count);
            //             if (cartItems[itemIndex].count < 1) {
            //                 cartItems.splice(itemIndex, 1);
            //             }
            //         }
            //     }
            //     document.cookie =
            //         "cart=" + encodeURIComponent(JSON.stringify(cartItems)) + "; domain=localhost; path=/";
            // };
        </script>
    </body>
</html>

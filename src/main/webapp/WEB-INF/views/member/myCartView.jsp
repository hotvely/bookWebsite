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
                        // 책 수량이 없으면 기본값으로 1 설정
                        if (item.bookCount === undefined) {
                            item.bookCount = 1;
                        }
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
                            `<div>수량: <button onclick="updateCart('\${item.code}','minus')">-</button>` +
                            `<span id="quantity_\${item.code}">\${item.bookCount}</span>` +
                            ` <button onclick="updateCart('\${item.code}','plus')">+</button></div>`;
                        cartElement.append(itemHtml);
                    }
                } else {
                    cartElement.append("<div>장바구니가 비었습니다.</div>");
                }
            };
            myCart();
            const updateCart = (code, action) => {
                const cartData = JSON.parse(getCookie("cart"));
                const findCartItem = cartData.find((item) => item.code === code);

                if (findCartItem) {
                    if (action === "plus") {
                        findCartItem.bookCount += 1;
                    } else if (action === "minus" && findCartItem.bookCount > 1) {
                        findCartItem.bookCount -= 1;
                    }

                    const expires = new Date();
                    expires.setDate(expires.getDate() + 60);
                    const expiresDateString = expires.toUTCString();

                    // 쿠키에서 해당 책의 정보 업데이트
                    setCookie("cart", JSON.stringify(cartData), expiresDateString);

                    // HTML에서 수량 업데이트
                    const quantityElement = document.getElementById(`quantity_${code}`);
                    if (quantityElement) {
                        quantityElement.textContent = findCartItem.bookCount;
                    }
                }
            };

            // const updateCart = (code, action) => {
            // //     const cartData = JSON.parse(getCookie("cart"));
            // //     if (cartData[code]) {
            // //         if (action) {
            // //             cartData[code] += 1;
            // //             bookCount[code] = bookCount[code] + 1;
            // //         } else {
            // //             cartData[code] = Math.max(0, cartData[code] - 1);
            // //             bookCount = Math.max(0, bookCount[code] - 1);
            // //         }
            // //         const expires = new Date();
            // //         expires.setDate(expires.getDate() + 60);
            // //         const expiresDateString = expires.toUTCString();
            // //         setCookie("cart", JSON.stringify(cartData), expiresDateString);
            // //     }
            // //     updateUI();
            // // };
            // // const updateUI = () => {
            // //     // 수량을 표시하는 DOM 업데이트
            // //     for (let code in bookCount) {
            // //         const quantityElement = document.getElementById("quantity");
            // //         if (quantityElement) {
            // //             quantityElement.innerText = bookCount[code];
            // //         }
            // //     }
            // // };
            // const findCartItems = cartItems.find((item) => item.code == code);
            // if (findCartItems) {
            //     if (action === "plus") {
            //         // html 값 변경 갯수 수량 가격
            //         findCartItems.bookCount = findCartItems.bookCount + 1;
            //     } else if (action === "minus") {
            //         findCartItems.bookCount = findCartItems.bookCount - 1;
            //     }
            //     document.cookie = "cart=" + encodeURIComponent(JSON.stringify(cartItems));
            // }
        </script>
    </body>
</html>

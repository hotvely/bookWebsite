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
    </head>
    <body>
        <%@ include file="/WEB-INF/views/header.jsp"%>

        <h3>
            내 장바구니
            <button id="clear-cart" class="btn btn-danger" onclick="deleteAllCart()">장바구니 비우기</button>
        </h3>

        <div id="cartList">
            <div id="cartItems"></div>
        </div>

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
                // const cartElement = $("#cartList");
                const cartElement = $("#cartItems");

                if (cartInfo != null && cartInfo.length > 0) {
                    for (const item of cartInfo) {
                        // code로 쿠키찾아서 삭제
                        const deleteButton = `<button class="btn btn-secondary" style="margin-top : 15px" onclick="deleteCartBook(\${item.code}) ">책 삭제</button>`;

                        const totalPrice = item.count * item.price;

                        const itemHtml =
                            `<div id="cartItem">` +
                            `<img width="100px" alt="xxx" src="${
                                item.image != null ? item.image : "/images/basic.jpeg"
                            }"/>` +
                            ` <a href="/book/detail?code=\${item.code}"> 제목: \${item.title}</a>` +
                            `<br> \${deleteButton}</br>` +
                            `<div id="writer">` +
                            `<div>글쓴이 : \${item.authority}</div>` +
                            `</div>` +
                            `<div id="price">` +
                            `<div id=ip_\${item.code}>가격 : \${totalPrice}</div>` +
                            `</div>` +
                            `<div id="amount">수량<button id="minus" class="btn btn-primary" onclick="updateCart('\${item.code}','minus')">-</button>` +
                            `<span id="quantity_\${item.code}">\${item.count}</span>` +
                            `<button id="plus" class="btn btn-primary" onclick="updateCart('\${item.code}','plus')">+</button></div>`;
                        +`<div>`;
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
        <style>
            #cartList > div {
                display: flex;
                flex-wrap: wrap;
                align-items: center;
                /* flex: 1; */
                margin: 10px;
                padding: 10px;
            }
            #cartItem {
                flex: 1;
                min-width: 250px;
                max-width: 300px;
                margin: 10px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            #quantity_ {
                font-size: large;
            }
            #minus {
                margin-right: 10px;
                margin-left: 10px;
            }
            #plus {
                margin-left: 10px;
            }

            h3 {
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            #clear-cart {
                margin-top: 10px;
            }

            #writer,
            #price,
            #amount {
                display: flex;
                justify-content: center;
                align-items: center;
                border: 1px solid #ccc;
                font-size: large;
                width: 100%;
                margin-right: 10px;
                margin-top: 15px;
            }
        </style>
    </body>
</html>

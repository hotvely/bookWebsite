<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Insert title here</title>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    </head>
    <body>
        <%@ include file="/WEB-INF/views/header.jsp"%>

        <div>
            <div id="image"></div>
            <div>
                <div>
                    <div id="category">분류 :</div>
                    <div id="title">책 제목 :</div>
                    <div id="detail">책 요약 :</div>
                    <div id="authority">글쓴이 :</div>
                    <div id="price">가격 :</div>
                    <div id="date">출간일 :</div>
                </div>
                <div>
                    <button onclick="addCart()">장바구니 담기</button>
                    <div id="updateBook"></div>
                </div>
            </div>
        </div>

        <script>
             let book = null;

                $.ajax({
                	url:"/book/show?code="+${code},
                	method: "POST",
                	data : {code : ${code}},
                	success: function(data) {
                		book = data;
                		if(book != null){
                			$('#category').html("분류 : " + book.subcategory);
                			$('#title').html("제목 : " + book.title);
                			$('#detail').html("책 요약 : " + book.detail);
                			$('#authority').html("글쓴이 : " + book.authority);
                			$('#price').html("가격 : " + book.price);
                			$('#date').html("출간일 : " + book.date);

                			if(book.image != null){
                				$('#image').append("<img src=" +book.image+ "/>");
                			}
                			else{
                				$('#image').append('<img src="/images/basic.jpeg"/>');
                			}
                		}
                	}
                });


                const addCart = () => {
              	  console.log(member);
              	if(member == null){
                		alert("로그인이 필요합니다");
                		return null;
                	}

                	let cartItem = [];
                 	if(getCookie('cart')!=null){
                		console.log(JSON.parse(getCookie('cart')));
                		cartItem = [...JSON.parse(getCookie('cart'))];
                 	}
                 	for(let elem of cartItem){
                 		if(elem.code == book.code){
                 			console.log("같은 아이템 있음;;");
                 			return null;
                 		}
                 	}
            	book = {...book, count : 1};
                 	cartItem = [...cartItem, book];
                 	setCookie('cart', JSON.stringify(cartItem), 60);
                 	console.log(JSON.parse(getCookie('cart')));
                }

            const checkAdmin = () => {
                	if(`${member.id}` != "") //어드민지 나중에 추가해야함.  )
                	{
                		$("#updateBook").append(
                			`<a href=/book/update?code=${code}><button>책 수정하기</button></a>`
                		);
                	}
                	else{
                		return null;
                	}
                }
                checkAdmin();
        </script>
    </body>
</html>

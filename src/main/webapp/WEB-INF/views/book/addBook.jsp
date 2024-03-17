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
            <div>
                <span>제목</span>
                <input type="text" id="title" name="title" />
            </div>
            <div>
                <span>책 설명</span>
                <input type="text" id="detail" name="detail" />
            </div>

            <div>
                <span>작가</span>
                <input type="text" id="authority" name="authority" />
            </div>

            <div>
                <span>카테고리</span>
                <select id="categoryOpt"></select>
            </div>

            <div>
                <span>가격</span>
                <input type="text" id="price" name="price" onkeypress="return insNumKey(event)" />
            </div>

            <div>
                <span>출판사</span>
                <input type="text" id="publisher" name="publisher" />
            </div>

            <div>
                <span>출간연도</span>
                <input type="date" id="date" name="date" />
            </div>

            <div>
                <span>대표이미지</span>
                <input type="file" accept="image/*" id="img" name="img" />
            </div>
            <div>
                <button onclick="addBookForm()">추가</button>
                <a href="/">
                    <button>뒤로가기</button>
                </a>
            </div>
        </div>

        <script>
            const addBookForm = () => {
                const book = {
                    title: $("#title").val(),
                    detail: $("#detail").val(),
                    authority: $("#authority").val(),
                    subcategory: $("#categoryOpt").val(),
                    price: parseInt($("#price").val()),
                    publisher: $("#publisher").val(),
                    date: $("#date").val() == "" ? null : $("#date").val(),
                    img: $("#img").val(),
                };
                //console.log(book);

                console.log("책 추가 함수..");
                $.ajax({
                    url: "/book/create",
                    method: "POST",
                    data: book,

                    success: function (response) {
                        console.log(response);
                        console.log("add book SUCCESS !!!");
                    },
                    error: function (error) {},
                });
            };

            const setOptionMain = async () => {
                const response = await axios.get("/category/category");
                if (response.data != null) {
                    for (let data of response.data) {
                        $("#categoryOpt").append(
                            `<optgroup id=categoryOpt\${data.code} label=-------\${data.category}></optgroup>`
                        );
                    }
                }
            };
            setOptionMain();

            const setOptionSub = async () => {
                const response = await axios.get("/category/subCategory");

                if (response.data != null) {
                    for (let data of response.data) {
                        //console.log(data);

                        $(`#categoryOpt\${data.categorycode}`).append(
                            `<option value=\${data.code}>\${data.subcategory}</option>`
                        );
                        //window.location.reload(true);
                    }
                }
            };
            setOptionSub();

            const insNumKey = (e) => {
                if (e.keyCode < 48 || e.keyCode > 57) {
                    return false;
                }
                return true;
            };
        </script>
    </body>
</html>

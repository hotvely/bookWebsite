<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Insert title here</title>
    </head>
    <body>
        <%@ include file="/WEB-INF/views/header.jsp"%>

        <table id="bookList">
            <tr>
                <td>책표지</td>
                <td>제목</td>
                <td>글쓴이</td>
                <td>가격</td>
                <td>출판사</td>
                <td>출간일</td>
            </tr>
            <tr>
                <td colspan="6">
                    <hr />
                </td>
            </tr>
        </table>
        <div id="page"></div>

        <script>
            console.log("scode >> ", ${subCategory})
            	const showList = () => {
            		$.ajax({
                   		url: "/book/showAll/subCategory",
                   		method: "POST",
                   		data: {
                   			pageNum : ${currPage},
                   			scode : ${subCategory}
                   			},
                   		success: function(data){
                   			console.log(data);
                   			books = [...data.bookList];
                   			console.log(books);

                   			const startPage = (Math.floor((${currPage} - 1) / 5) * 5) + 1;
                   			if(data.hasPrev && startPage > 5)
                   				$('#page').append('<a href="/?pageNum='+(startPage-5)+ '"><button><</button></a>');

                   			// 실제 페이지들 나열 할 곳..
                   			let endPage = startPage + 5;
                   			if(endPage > data.totalPages){
                   				endPage = data.totalPages;
                   			}

                   			console.log("endPage", endPage);
                   			for(let idx = startPage ; idx < endPage; idx++){
                   				$('#page').append('<a href="/?pageNum=' + (idx) + '"><button>' + (idx)+ '</button></a>');
                   			}

                   			if(startPage == data.totalPages || data.totalPages <= 5)
                   				$('#page').append('<a href="/?pageNum=' + endPage + '"><button>' +endPage + '</button></a>');

                   			console.log("startPage + 5 ",startPage + 5);
                   			if(data.hasNext && endPage - startPage >= 4)
                   				$('#page').append('<a href="/?pageNum=' + (startPage+5) + '"><button>></button></a>');

                   			 let HTML = '';

                   			books.map((book) => {
                   				console.log((new Date()- new Date(book.date))/ (1000*60*60*24));
                   				HTML +='<tr><td>' +
                   				'<img width="100px" alt="xxx" src="' + (book.image != null ? book.image : "/images/basic.jpeg") + '"/></td>' +
                   			 	'<td width="250px"><a href="http://localhost:8080/book/detail?code='+book.code+'">'+((book.title).length > 10 ? (book.title).substr(0,10) + "..." : (book.title))+'<a/></td>'+
                   				'<td width="170px">'+ book.authority+'</td>'+
                   				'<td width="120px">'+ book.price+' 원</td>'+
                   				'<td width="150px">'+ book.publisher+'</td>'+
                   				'<td width="130px">'+ ((new Date() - new Date(book.date))/(1000*60*60*24) < 30 ? ('신간(NEW)' + (book.date)) : (book.date))+'</td><tr>';
                   				});
                   			$('#bookList').append(HTML);
                   		}
                   	});
            	}
            	showList();
        </script>

        <style>
            #bookList {
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            a {
                margin-right: 10px;
                color: gray;
                text-decoration: none;
            }
        </style>
    </body>
</html>

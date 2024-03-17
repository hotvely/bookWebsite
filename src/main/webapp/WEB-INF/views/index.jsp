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

        <script>

                    let books = null;
                    const showAll = () => {
                    	$.ajax({
                    		url: "/book/showAll?pageNum=${currPage}",
                    		method: "GET",
                    		success: function(data){
                    			console.log(data);
                    			books = [...data.bookList];

                    			const startPage = (Math.floor((${currPage} - 1) / 5) * 5) + 1;
                    			if(data.hasPrev && startPage > 5)
                    				$('#page').append('<a href="/?pageNum='+(startPage-5)+ '"><button class="btn btn-secondary"><</button></a>');

                    			// 실제 페이지들 나열 할 곳..
                    			let endPage = startPage + 5;
                    			if(endPage > data.totalPages){
                    				endPage = data.totalPages;
                    			}

                    			console.log("endPage", endPage);
                    			for(let idx = startPage ; idx < endPage; idx++){
                    				$('#page').append('<a href="/?pageNum=' + (idx) + '"><button class="btn btn-secondary">' + (idx)+ '</button></a>');
                    			}

                    			if(startPage == data.totalPages || data.totalPages <= 5)
                    				$('#page').append('<a href="/?pageNum=' + endPage + '"><button class="btn btn-secondary">' +endPage + '</button></a>');

                    			console.log("startPage + 5 ",startPage + 5);
                    			if(data.hasNext && endPage - startPage >= 4)
                    				$('#page').append('<a href="/?pageNum=' + (startPage+5) + '"><button class="btn btn-secondary">></button></a>');

                    			 let HTML = '';

                    			books.map((book) => {
                    				console.log((new Date()- new Date(book.date))/ (1000*60*60*24));
                    				HTML +='<tr><td>' +
                    				'<img width="100px" alt="xxx" src="' + (book.image != null ? book.image : "/images/basic.jpeg") + '"/></td>' +
                    			 	'<td width="250px"><a href="book/detail?code='+book.code+'">'+((book.title).length > 10 ? (book.title).substr(0,10) + "..." : (book.title))+'<a/></td>'+
                    				'<td width="170px">'+ book.authority+'</td>'+
                    				'<td width="120px">'+ book.price+' 원</td>'+
                    				'<td width="150px">'+ book.publisher+'</td>'+
                    				'<td width="130px">'+ ((new Date() - new Date(book.date))/(1000*60*60*24) < 30 ? ('신간(NEW)' + (book.date)) : (book.date))+'</td><tr>';
                    				});
                    			$('#bookList').append(HTML);


                    		}
                    	});
                    }

                    showAll();

                    const checkMember = () => {
                    	if(member == null){
                    		alert("관리자 전용")
                    	}
                    }

            // if (member != null && member.admin == "Y") {
            //                         $("#addBooks").show();
            //                         } else if (member == null) {
            //                             $("#addBooks").hide();
            //                     } else {
            //                         $("#addBooks").hide();
            //                     }
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
            #addBooks {
                position: absolute;
                top: 10px;
                right: 10px;
            }
            #page {
                text-align: center;
                margin-bottom: 15px;
            }
            a {
                margin-right: 10px;
                color: gray;
                text-decoration: none;
            }
        </style>
        <div id="addBooks"></div>
        <script>
            console.log(member);
            const id = `${member.id}`;
            console.log(id);
            // console.log(${member});
            if (`${member}` != "" && `${member.admin}` == "Y") {
                const str = `<a href="/book/create">
                        <button style="margin-left: 50px" class="btn btn-secondary">
                            책추가
                        </button>
                    </a>`;
                $("#addBooks").append(str);
            }
        </script>

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
    </body>
</html>

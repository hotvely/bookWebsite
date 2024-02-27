
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>

	이 줄 부터는 메인 페이지 입니다..





	<script>	
		
		let books = null;
		const showAll = () => {
			$.ajax({
				url: "/book/showAll?pageNum=" + ${currPage},
				method: "GET",			
				success: function(data){
					console.log(data);
					books = [...data.bookList];
					
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
						HTML +='<tr><td>' + 
						'<img width="100px" alt="xxx" src="' + (book.image != null ? book.image : "/images/basic.jpeg") + '"/></td>' +
					 	'<td width="250px"><a href="book/detail?code='+book.code+'">'+book.title+'<a/></td>'+
						'<td width="170px">'+ book.authority+'</td>'+
						'<td width="120px">'+ book.price+' 원</td>'+
						'<td width="150px">'+ book.publisher+'</td>'+
						'<td width="100px">'+ book.date+'</td><tr>';
						});
					$('#bookList').append(HTML); 
				}
			});
		}
		showAll();

		
		
		const handlerAfterMember = (id) => {
			if( id != undefined || id != null){
				$('#afterMember').append(id + "님 반갑습니다.");
			}
		}
		
				
		// 로그인시 멤버 정보 가져오는 로직
		
		/*
		
		*/
	</script>

	<div id="afterMember"></div>
	<div id="addBooks"></div>

	<a href="/book/create">
		<button>책추가</button>
	</a>

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
				<hr>
			</td>
		</tr>
	</table>
	<div id=page></div>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
	<script>	
		
		let books = null;
	
		const addBook = () => {
			console.log("hello")
		};
		
		const showAll = () => {
			$.ajax({
				url: "http://localhost:8080/book/showAll",
				method: "GET",
				success: function(data){
					console.log(data);
					books = [...data];
					
					books.map((book) => {
						$("#bookList").append('<tr><td width="100px">'+book.title+'</td>'+
								'<td width="100px">'+ book.detail+'</td>'+
								'<td width="100px">'+ book.price+'</td><tr>');
					});
				}
			});
		}
		showAll();
		
	
	</script>
	
	${test} hello
	<button onclick="addBook()">addBook</button>
	<!-- <button onclick="showAll()">showAll</button> -->
	<div>
		<a href="/book/create">add</a>
	</div>
	<div>
		<a href="/member/registerView" style="text-decoration: none; color: black">
			<button>member register</button>
		</a>
	</div>

	<div id="bookList">책 리스트</div>
</body>
</html>
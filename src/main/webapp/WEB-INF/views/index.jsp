
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

</head>
<body>
	<%@ include file="header.jsp"%>
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
						$("#bookList").append('<tr><td width="100px">'+book.bookTitle+'</td>'+
								'<td width="100px">'+ book.bookDetail+'</td>'+
								'<td width="100px">'+ book.price+'</td><tr>');
					});
				}
			});
		}
		
		
		// 로그인시 멤버 가져오는 로직
		const getMember = () => {
			$.ajax({
				url: "/member/isLogin",
				method: "POST",
				success: function(data){
					console.log(data);
					  document.cookie = "member=" + JSON.stringify(data);
					
				}
			})
		}
		
		getMember();
		
	
	</script>

	${test} hello
	<button onclick="addBook()">addBook</button>
	<button onclick="showAll()">showAll</button>
	<button>
		<a href="/book/create">add</a>
	</button>
	<button>
		<a href="/member/register" style="text-decoration: none; color: black">member
			register</a>
	</button>
	<button>
		<a href="/member/login" style="text-decoration: none; color: black">login</a>
	</button>

	<div id="bookList"></div>
</body>
</html>
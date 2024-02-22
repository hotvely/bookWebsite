
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
	<jsp:include page="/header" />

	이 줄 부터는 메인 페이지 입니다..





	<script>	
		console.log(member);
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
		
		
		const handlerAfterMember = (id) => {
			if( id != undefined || id != null){
				$('#afterMember').append(id + "님 반갑습니다.");
			}
		}
		
				
		// 로그인시 멤버 정보 가져오는 로직
		
		/*
		$("#logout").click(function() {
		        $.ajax({
		            type: "POST",
		            url: "/member/logout",
		            success: function() {
		                console.log("로그아웃 성공");
		                location.reload(); 
		            },
		            error: function() {
		                console.log("로그아웃 실패");
		            }
		        });
		    });
		});
		*/
	</script>

	<div id="afterMember"></div>
	<button onclick="addBook()">addBook</button>
	<button onclick="showAll()">showAll</button>
	<button>
		<a href="/book/create">add</a>
	</button>


	<div id="bookList"></div>
</body>
</html>
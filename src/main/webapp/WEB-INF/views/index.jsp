
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp" %>

	이 줄 부터는 메인 페이지 입니다..





	<script>	
		
		let books = null;
		
		const moveDetail = () => {
			window.location.href = "bookDetail";
			
			
		}
		
		
		const showAll = () => {
			$.ajax({
				url: "http://localhost:8080/book/showAll",
				method: "GET",
				success: function(data){
			//		console.log(data);
					books = [...data];
					
					let HTML = '';
					books.map((book) => {
						HTML +='<tr><td>' + 
						(book.image != null ? 
						'<img alt="" src="'+book.image+'"/></td>' : 
						'<img width="100px" alt="xxx" src="https://photo.coolenjoy.co.kr/data/editor/1901/20190128172926_3c9c1896362cdd6a8e5f782db9817014_1wii.jpg"/></td>' )+
					 	'<td width="100px"><a href="book/detail?code='+book.code+'">'+book.title+'<a/></td>'+
						'<td width="100px">'+ book.authority+'</td>'+
						'<td width="100px">'+ book.price+'</td>'+
						'<td width="100px">'+ book.publisher+'</td>'+
						'<td width="100px">'+ book.date+'</td><tr>';
						});
			//		console.log(HTML);
					$('#bookList').append(HTML);
				}
			});
		}
		showAll();

	// <img src="http://www.adullammission.org/files/attach/images/941/494/001/d682e4726411430055c0b856df54297b.jpg" />
	//  <button onclick="showAll()">showAll</button> 


		
		
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
	<button onclick="addBook()">addBook</button>
	<!-- <button onclick="showAll()">showAll</button> -->


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

	<div id="bookList"></div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

</head>
<body>

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
			<div><button>결제하기</button></div>
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
	
	
	</script>

</body>
</html>
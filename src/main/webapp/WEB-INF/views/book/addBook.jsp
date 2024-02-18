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
	hello
	<div>
		<input type="text" id="title" name="title" />
		<button onclick="addBookForm()">추가</button>
	</div>

	<script>
		const addBookForm = () => {
			console.log("책 추가 함수..");
			$.ajax({
				url : "/book/create",
				method: "POST",
				data: {title : $("#title").val()},
				
				success:function(response) {
					console.log(response + "성공");
				},
				error: function(error)
				{
					
				}
				
			
			});
			
		};
	
	</script>
</body>
</html>
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

	<div>
		<div>
			<span>제목</span>
			<input type="text" id="title" name="title" value="${book.title}" />
		</div>
		<div>
			<span>책 설명</span>
			<input type="text" id="detail" name="detail" value="${book.detail}" />
		</div>

		<div>
			<span>작가</span>
			<input type="text" id="authority" name="authority" value="${book.authority}" />
		</div>

		<div>
			<span>카테고리</span>
			<select id="subcategory">
				<optgroup label="==== 문학">
					<option value="1">소설</option>
					<option value="2">수필</option>
					<option value="51">만화</option>
				</optgroup>
				<optgroup label="==== 학습">
					<option value="4">이공계열 전문서적</option>
					<option value="5">어문계열 전문서적</option>
					<option value="6">고등학교</option>
				</optgroup>
			</select>
		</div>


		<div>
			<span>가격</span>
			<input type="text" id="price" name="price" value="${book.price}" onkeypress="return insNumKey(event)" />
		</div>

		<div>
			<span>출판사</span>
			<input type="text" id="publisher" name="publisher" value="${book.publisher}" />
		</div>

		<div>
			<span>출간연도</span>
			<input type="date" id="date" name="date" value="${book.date}" />
		</div>

		<div>
			<span>대표이미지</span>
			<input type="file" accept="image/*" id="img" name="img" />
		</div>
		<div>
			<button onclick="update()">수정하기</button>
			<a href="/">
				<button>뒤로가기</button>
			</a>
		</div>

	</div>

	<script>
	
		console.log("book", `${book.toString()}`);
		$('#subcategory').find('option[value="${book.subcategory}"]').attr('selected', true);
		
		const update = () => {
			const book = {
					code : ${book.code},
					title : $('#title').val(),
					detail : $('#detail').val(),
					authority : $('#authority').val(),
					subcategory : $('#subcategory').val(),
					price : parseInt($('#price').val()),
					publisher : $('#publisher').val(),
					date : $('#date').val() == "" ? null : $('#date').val(),
					img : $('#img').val()				
				};
				console.log(book);
				
				
				console.log("책 추가 함수..");
				$.ajax({
					url : "/book/update",
					method: "PUT",
					data: book,
					
					success:function(response) {
						if(response){
							console.log("update book SUCCESS !!!");
							alert("update 완료 !");
							window.location.href = "/";
						}
					},
					error: function(error)
					{
						
					}
					
				
				});
			
		}
		
		
		
	</script>
</body>
</html>
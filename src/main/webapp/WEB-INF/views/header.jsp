
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

	<div id="header"></div>



	<script>
		let member = null;
		const getMember = () => {
			 $.ajax({
				url: "/header",
				method: "POST",
				success: function(data){
					
					console.log(data);			
					handlerMember(data);
					handlerAfterMember(data.id);
					if(data.id != null){
						$('#header').append("지금은 로그인이 되어 있는 상태 입니다");
					}
					else{
						$('#header').append("로그인 필요해요");
					}
				}
			})
		}		
		getMember();
		
		const handlerMember = (data) => {
			member = data;
			}
		
		
		/* const member = ${member}; */
		
		
		
		
	
	</script>
	<a href="/member/login">로그인</a>  <a href="/member/logout">로그아웃</a>
	<div id="header"></div>
	<!-- ${member} 서버 세션의 키값과 변수명 같아야함 -->

</body>
</html>
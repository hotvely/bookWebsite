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
	<h1>로그인</h1>
	
	<div class="form-login">
	아이디 : <input type="text" name="username" id="username" placeholder="아이디를 입력해 주세요" required/> 
	</div>
	
	<div class="form-login">
	비밀번호 : <input type="text" name = "password" id = "password" placeholder="비밀번호를 입력해 주세요" required/>
	</div> 
	
	<br/>
	
	<button type="submit" value="로그인" id=login>
		로그인
	</button>
	
	<script>
	 	$('#login').on('click',function(){
	 		let member = {
	 				username:$('#username').val(),
	 				password:$('#password').val()
	 		};
	 		$.ajax({
	 			url:'/member/login',
	 			type:'POST',
	 			data: member,	 			
	 				success: function(response){	
						console.log(response);
						if(response){
							window.location.href = "/";
						}else{
							console.log('로그인 실패');						
							window.location.href = "/member/login";
						}
				},
			error: function(error){
				console.log('로그인 에러');
				window.location.href = "/member/login";
			}
	 		});
	 	})
	</script>
</body>
</html>
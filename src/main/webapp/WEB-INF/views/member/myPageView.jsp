<%@page import="com.practice.semi.vo.Member"%>
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
	<%@ include file="/WEB-INF/views/header.jsp" %>

	
	<h1>내 정보  ${member.id }</h1>
	<div id="info"></div>
	
	<div class="form-el">
	아이디 : <input type="text" name="username" id="username" placeholder="아이디를 입력해 주세요" required/> 
	</div>
	
	<div class="form-el">
	비밀번호 : <input type="text" name = "password" id = "password" placeholder="비밀번호를 입력해 주세요" required/>
	</div> 
	
	<div class="form-el">
	이메일 : <input type="text" name="email" id="email" placeholder="이메일을 입력해 주세요" required/>
	</div>
	
	<div class="form-el">
	전화번호 : <input type="text" name="phone" id="phone" placeholder="전화 번호를 입력해 주세요" required/>
	</div>
	
	<div class="form-el">
	닉네임 : <input type="text" name="nickname" id="nickname" placeholder="닉네임을 입력해 주세요" required/>
	</div>
	
	<br/>
	
	<button type="submit" value="정보수정" id=updateProfile>
		수정
	</button>
	
	<script>
		$('#updateProfile').on('click',function(){
			let member = {
					username:$('#username').val(),
					password:$('#password').val(),
					email:$('#email').val(),
					phone:$('#phone').val(),
					nickname:$('#nickname').val()
			};
			$.ajax({
				url:'/member/update',
				type: 'PUT',
				data: member,
				success: function(response){
					
					console.log(response);
					if(response != null){
						window.location.href ="/"
					}
				},
				error: function(error){
					console.log('정보수정 에러')
				}
			});
		})
	</script>
		
	<script>
	$('#info').append("<div>${member.id}</div>");
	</script>
	
</body>
</html>
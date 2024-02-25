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

	<div>${book.title}</div>
	<h1>내 정보  ${member.id }</h1>
	<div id="info"></div>
	
	
	
	<div class="form-el">
	<input type = "hidden" id = "usercode"  value = "${member.usercode}" />
	
	<input type = "hidden" id = username  value = "${member.id}" />

	비밀번호 : <input type="text" name = "password" id = "password" placeholder="변경할 비밀번호를 입력하세요" />
	</div> 
	
	<div class="form-el">
	이메일 : <input type="text" name="email" id="email" placeholder="변경할 이메일을 입력하세요" />
	</div>
	
	<div class="form-el">
	전화번호 : <input type="text" name="phone" id="phone" placeholder="변경할 전화번호를 입력하세요" />
	</div>
	
	<div class="form-el">
	닉네임 : <input type="text" name="nickname" id="nickname" placeholder="변경할 닉네임을 입력하세요" />
	</div>
	
		<input type = "hidden" id = "admin"  value = "${member.admin}" />	
	
	<br/>
	
	<button type="submit" value="정보수정" id=updateProfile>
		수정
	</button>
	
	<script>
		$('#updateProfile').on('click',function(){
			let member = {	
					usercode:$('#usercode').val(),
					username:$('#username').val(),
					password:$('#password').val(),
					email:$('#email').val(),
					phone:$('#phone').val(),
					nickname:$('#nickname').val(),
					admin:$('#admin').val()
			};
			$.ajax({
				url:'/member/update',
				type: 'PUT',
				data: member,
				success: function(response){
					
					console.log(response);
					/* if(response != null){
					window.location.href ="/"
					} */
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
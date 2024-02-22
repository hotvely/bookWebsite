<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<!--<script src="/resources/static/javascript/getMember.js"></script>  -->

</head>
<body>


	<script>
		console.log(`${member}`);
		const handlerMember = (data) => {
	        console.log("handlerMember");
	        member = data;
	    };
	
	 	const getMember = () => {
	        try {
	            $.ajax({
	                url: "/header",
	                method: "POST",
	                success: function (data) {
	                    // getMember 함수에서 데이터를 처리하는 부분을 handlerMember 함수를 호출하는 것으로 수정
	                    handlerMember(data);

	                    if (data.id != null) {
	                        $('#header').append("지금은 로그인이 되어 있는 상태 입니다<br/>");
	                        $('#header').append('<a href="/member/myPage">마이페이지</a>  <a href="/member/logout">로그아웃</a>');
	                    } else {
	                        $('#header').append("로그인 필요해요<br/>");
	                        $('#header').append('<a href="/member/register">회원가입</a>  <a href="/member/login">로그인</a>');
	                    }
	                }
	            });
	        } catch (error) {
	            console.error("Error: " + error);
	            throw error;
	        }
	    };

	    // 초기 페이지 로딩 시 getMember 함수 호출
	    getMember();

	

		
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
		
	
	
	</script>


	<div id="header"></div>
	
	<!-- ${member} 서버 세션의 키값과 변수명 같아야함 -->

</body>
</html>
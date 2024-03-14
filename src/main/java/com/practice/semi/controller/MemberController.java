package com.practice.semi.controller;

import java.io.IOException;
import java.net.http.HttpResponse;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.practice.semi.service.MemberService;
import com.practice.semi.vo.Member;
import com.practice.semi.vo.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/member")
@Slf4j
public class MemberController {

	@Autowired
	private MemberService service;
	HttpSession session = null;
	// --------------------- page view

	// 일반유저
	@GetMapping("/register")
	public ModelAndView registerView() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/member/registerView");
		mv.addObject("admin", false);
		return mv;
	}
	// 관리자
	 @GetMapping("/register/admin")
	    public ModelAndView registerAdminView() {
	        ModelAndView mv = new ModelAndView();
	        mv.setViewName("/member/registerView");
	        mv.addObject("admin", true);
	        return mv;
	    }
	 
//	 // 관리자
//	 @GetMapping("/login/admin")
//	 public ModelAndView loginAdminView() {
//		 log.info("관리자 로그인 페이지 들어옴");
//		 ModelAndView mv = new ModelAndView();
//		 mv.setViewName("/member/loginView");
//		 mv.addObject("admin", true);
//		 return mv;
//	 }
	 
		@GetMapping("/test")
		public ModelAndView test() {
			log.info("붙스트랩....");
			ModelAndView mv = new ModelAndView();
			mv.setViewName("/member/test");
			return mv;
		}

	@GetMapping("/login")
	public ModelAndView loginView() {
		log.info("dma....");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/member/loginView");
		return mv;
	}

	// 로그아웃 a태그 url 매핑해서 서버에서 처리하는 로그아웃 방식 아마 jsp 사용하니까 서버에서 처리하는 걸 선호하지 않으려나 생각 중..
	@GetMapping("/logout")
	public void logout2(HttpServletRequest request, HttpServletResponse response) {
		session = request.getSession(false);
		try {
			if (session != null) {
				session.invalidate();
				response.sendRedirect("/");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 로그아웃 button 태그로 ajax 통신 post 요청 후 반환 받고 클라이언트에서 처리하는 로그아웃 방식
	@PostMapping("/logout")
	public boolean logout(HttpServletRequest request) {
		log.info("logout");
		session = request.getSession(false);
		if (session != null) {
			session.invalidate();
			return true;
		}
		log.info("로그아웃");
		return false;
	}

	@GetMapping("/myPage")
	public ModelAndView myPageView() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/member/myPageView");
		return mv;
	}
	
	@GetMapping("/myCart")
	public ModelAndView myCartView() {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/member/myCartView");
		
		return mv;
	}

	// --------------------- page view

	// --------------------- function & mapping

	// 닉네임으로 멤버 찾기
//	@PostMapping("/")
//	public String show(@PathVariable String nickName, Model model) {
//		Member member = service.findByNickname(nickName);
//		if (member != null) {
//			model.addAttribute("member", member);
//			return "회원조회 페이지";
//		} else {
//			return "조회실패 페이지";
//		}
//	}

//	// 아이디 찾기
//	@PostMapping("/findId")
//	public String findId(@RequestBody MemberDTO dto, Model model) {
//		String memberId = service.findId(dto);
//		if (memberId != null) {
//			model.addAttribute("memberId", memberId);
//			return "아이디 찾은 페이지";
//		} else {
//			return "아이디 없다는 페이지";
//		}
//	}

	// 회원가입
	@PostMapping("/register")
	public ResponseEntity<Member> register(
			@RequestParam(name = "username") String username,
			@RequestParam(name = "password") String password, 
			@RequestParam(name = "email") String email,
			@RequestParam(name = "phone") String phone, 
			@RequestParam(name = "nickname") String nickname,
			@RequestParam(name = "admin", required = false, defaultValue = "false") String admin) {
		log.info("register");
			
		Member member = Member.builder().id(username).password(password).email(email).phone(phone).nickname(nickname).admin("N")
				.build();
		Member registerMember = service.create(member);
		return ResponseEntity.ok(registerMember);
	}
	
	// 관리자 회원가입
	@PostMapping("/register/admin")
	public ResponseEntity<Member> registerAdmin(
			@RequestParam(name = "username") String username,
			@RequestParam(name = "password") String password, 
			@RequestParam(name = "email") String email,
			@RequestParam(name = "phone") String phone, 
			@RequestParam(name = "nickname") String nickname,
			@RequestParam(name = "admin" )String admin) {
		log.info("registerAdmin");
		Member member = Member.builder().id(username).password(password).email(email).phone(phone).nickname(nickname).admin("Y")
				.build();
		Member registerAdmin = service.create(member);
		log.info("관리자 가입 " + member.toString());
		return ResponseEntity.ok(registerAdmin);
	}

	// 아이디 중복 체크
	@PostMapping("/idCheck")
	public ResponseEntity<Boolean>idCheck(@RequestParam(name = "username") String username){
		  log.info("idCheck started for username: {}", username);
		Member member = service.idCheck(username);
		  log.info("idCheck started for username: {}", username);
		log.info("중복방지 들어오냐");
		if(member == null) {
			// 아이디 중복 아닐때
			log.info("아이디 중복아님" + username);
		return ResponseEntity.ok(true);
		
		}else {
			// 아이디 중복일때
			log.info("아이디 중복" + username);
			return ResponseEntity.ok(false);
		}	
	};
	
	// 닉네임 중복 체크
	@PostMapping("/nickCheck")
	public ResponseEntity<Boolean>nickCheck(@RequestParam(name = "nickname") String nickname){
		Member member = service.nickCheck(nickname);

		if(member == null) {
			// 닉네임 중복 아닐때
			log.info("닉네임 중복아님" + nickname);
			return ResponseEntity.ok(true);
		}else {
			// 닉네임 중복일때
			log.info("닉네임 중복" + nickname);
			return ResponseEntity.ok(false);
		}		
	};
	
//	@PostMapping("/findPwd")
//	public ResponseEntity<String> findPwd(@RequestBody MemberDTO dto) {
//		String pwd = service.findPwd(dto);
//		return ResponseEntity.ok(pwd);
//	}
//	
	// 비밀번호 찾기
	@PostMapping("/findPwd")
	public ResponseEntity<String> findPwd(
			@RequestParam(name = "username") String id,
			@RequestParam(name = "email") String email) {
		String pwd = service.findPwd(id, email);
		return ResponseEntity.ok(pwd);
	}
	
	// 관리자 로그인
//	@PostMapping("/login/admin")
//	public ResponseEntity<Boolean> adminLogin(
//			@RequestParam(name = "username")String id ,
//			@RequestParam(name = "password")String password,
//			@RequestParam(name = "admin", defaultValue = "N")String admin,
//			HttpServletRequest request){
//		log.info("관리자 로그인 들어오나");
//		Member member = service.loginMember(id, password);
//		if(member!=null) {
//			if("Y".equals(admin)) {
//				session = request.getSession();
//				session.setAttribute("member", member);
//				log.info("관리자 아이디 : " + member);
//				return ResponseEntity.ok(true);
//			}else {
//				return ResponseEntity.ok(false);
//			}
//		}
//		return null;	
//	}

	// 로그인
	// 세션 생성 후 저장
	@PostMapping("/login")
	public ResponseEntity<String> login(
			@RequestParam(name = "username") String id,
			@RequestParam(name = "password") String password,
			HttpServletRequest request) {
		log.info("로그인 성공하냐");
		Member member = service.loginMember(id, password);
		try {

			if (member != null) {
				session = request.getSession();
				session.setAttribute("member", member); // key value
				
				if("Y".equals(member.getAdmin())) {
					log.info("관리자 : " + member);
					return ResponseEntity.ok("Y");
				}else {
					log.info("유저 : " + member);
					return ResponseEntity.ok("N");				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.ok(null);
	}

	// 회원수정
	@PutMapping("/update")
	public ResponseEntity<Member> update(
			@RequestParam(name = "code") int code,
			@RequestParam(name = "username") String id, 
			@RequestParam(name = "password") String password,
			@RequestParam(name = "email") String email, 
			@RequestParam(name = "phone") String phone,
			@RequestParam(name = "nickname") String nickname, 
			@RequestParam(name = "admin") String admin,
			HttpSession session) {
		log.info("update 오냐");
		Member member = (Member) session.getAttribute("member");

		if (member != null) {
			Member eidtMember = Member.builder()
					.code(code)
					.id(id)
					.password(password)
					.email(email)
					.phone(phone)
					.nickname(nickname)
					.admin("N")
					.build();
			member = service.update(eidtMember);			
			session.setAttribute("member", member);
			
			log.info("멤버" + member);
			
			return ResponseEntity.ok(member);
		}
		return null;
	}

	// 회원탈퇴
	@DeleteMapping("/delete")
	public ResponseEntity<Boolean> deleteMember(
			@RequestParam(name = "code") int code) {
		try {
			service.delete(code);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("삭제 시루패");
			return ResponseEntity.ok(false);
		}
		log.info("삭제 성공");
		return ResponseEntity.ok(true);
	}
	
	@GetMapping("/")
	public ModelAndView showAll(Model model) {
		List<Member> members = service.showAll();
		model.addAttribute("members", members);

		ModelAndView mv = new ModelAndView();
		mv.addObject("mlist", members);
		mv.setViewName("/member/adminView");
		return mv;
	}

	// 상세 조회
	@GetMapping("/show/{code}")
	public ModelAndView show(Model model, @RequestParam("code") int code) {

		Member member = service.show(code);

		if (member != null) {
			model.addAttribute("member", member);

			ModelAndView mv = new ModelAndView();
			mv.addObject("showMember", member);
			mv.setViewName("/member/adminView");
			return mv;
		}
		return null;
	}
}

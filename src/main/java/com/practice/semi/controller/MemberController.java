package com.practice.semi.controller;

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

	@GetMapping("/register")
	public ModelAndView registerView() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/member/registerView");
		return mv;
	}

	@GetMapping("/login")
	public ModelAndView loginView() {
		log.info("dma....");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/member/loginView");
		return mv;
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public ModelAndView logout(HttpServletRequest request) {

		ModelAndView mv = new ModelAndView();
			session = request.getSession(false);
		if (session != null) {
			session.invalidate();	
			
			mv.addObject("logout", session);
			mv.setViewName("index");
			mv.addObject("currPage", 1);
		}
		log.info("로그아웃");
		return mv;
	}


	@GetMapping("/myPage")
	public ModelAndView myPageView() {
		ModelAndView mv = new ModelAndView();

		mv.setViewName("/member/myPageView");

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
			@RequestParam("username")String username,
			@RequestParam("password")String password,
			@RequestParam("email") String email,
			@RequestParam("phone") String phone,
			@RequestParam("nickname") String nickname) {
		log.info("register");
		Member member = Member.builder()
				.id(username)
				.password(password)
				.email(email)
				.phone(phone)
				.nickname(nickname)
				.build();
		Member registerMember = service.create(member);
		log.info("가입 " + member.toString());
		return ResponseEntity.ok(registerMember);
	}

//	@PostMapping("/findPwd")
//	public ResponseEntity<String> findPwd(@RequestBody MemberDTO dto) {
//		String pwd = service.findPwd(dto);
//		return ResponseEntity.ok(pwd);
//	}
//	
	// 비밀번호 찾기
	@PostMapping("/findPwd")
	public ResponseEntity<String> findPwd(@RequestParam("username") String id, @RequestParam("email") String email) {
		String pwd = service.findPwd(id, email);
		return ResponseEntity.ok(pwd);
	}

	// 로그인
	// 세션 생성 후 저장
	@PostMapping("/login")
	public ResponseEntity<Boolean> login(@RequestParam("username") String id, 
			@RequestParam("password") String password,
			HttpServletRequest request) {
		log.info("로그인 성공하냐");
		Member member = service.loginMember(id, password);
		try {

			if (member != null) {
				session = request.getSession();
				session.setAttribute("member", member); // key value
				return ResponseEntity.ok(true);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.ok(false);
	}

	// 회원수정
	@PutMapping("/update")
	public ResponseEntity<Member> update(
			@RequestParam("usercode") int code,
			@RequestParam("username") String id,
			@RequestParam("password") String password,
			@RequestParam("email") String email, 
			@RequestParam("phone") String phone,
			@RequestParam("nickname") String nickname,
			@RequestParam("admin") String admin,
			HttpSession session) {
		log.info("update 오냐");
		 Member member = (Member) session.getAttribute("member");
		 
		if(member != null){
		Member eidtMember = Member.builder()
				.usercode(code)
				.id(id)
				.password(password)
				.email(email)
				.phone(phone)
				.nickname(nickname)
				.admin(admin)
				.build();		
			member = service.update(eidtMember);
		log.info("수정 " + eidtMember.toString());
		return ResponseEntity.ok(member);
	}
		return null;
	}
	// 회원탈퇴
	@DeleteMapping("/delete{code}")
	public ResponseEntity<Boolean> deleteMember(@PathVariable int code) {
		
//	Member member = (Member) session.getAttribute("member");
		try {
			service.delete(code);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("삭제 성공");
			return ResponseEntity.ok(true);
		}
		log.info("삭제 실패");
		return ResponseEntity.ok(false);
	}

}

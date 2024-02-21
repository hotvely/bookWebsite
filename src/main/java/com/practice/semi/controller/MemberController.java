package com.practice.semi.controller;

import java.util.List;

import org.aspectj.apache.bcel.classfile.Module.Require;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.practice.semi.service.MemberService;
import com.practice.semi.vo.Member;
import com.practice.semi.vo.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {

	@Autowired
	private MemberService service;
	
	//--------------------- page view 

	@GetMapping("/")
	public ModelAndView showAll(Model model) {
		List<Member> members = service.showAll();
		model.addAttribute("members", members);

		ModelAndView mv = new ModelAndView();
		mv.addObject("mlist", members);
		mv.setViewName("adminPage");
		return mv;
	}
	
	@GetMapping("/registerView")
	public ModelAndView registerView() {
		log.info("dma....");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("member/registerView");
		return mv;
	}
	
	@GetMapping("/loginView")
	public ModelAndView loginView() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("member/login");
		return mv;
	}
	
	@GetMapping("/myPageView")
	public ModelAndView myPageView() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/member/myPageView");
		return mv;
	}
	
	//--------------------- page view 
	
	
	
	//--------------------- function & mapping

	// 상세 조회
	@GetMapping("/show/{code}")
	 ResponseEntity<Member> show(@RequestParam("code") int code){
		Member member = service.show(code);
		if(member != null) {
			return ResponseEntity.ok(member);
		}
		return null;
		
	}

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
	public ResponseEntity<Member> register(@RequestParam("username")String id,
			@RequestParam("password") String password ,
			@RequestParam("email") String email ,
			@RequestParam("phone") String phone ,
			@RequestParam("nickname") String nickname) {
		log.info("register");		
		Member member = Member.builder()
				.id(id)
				.password(password)
				.email(email).phone(phone)
				.nickname(nickname)
				.build();
		log.info("가입" + member.toString());
		
			return ResponseEntity.ok(member);
	}
	
//	@PostMapping("/findPwd")
//	public ResponseEntity<String> findPwd(@RequestBody MemberDTO dto) {
//		String pwd = service.findPwd(dto);
//		return ResponseEntity.ok(pwd);
//	}
//	
	// 비밀번호 찾기
	@PostMapping("/findPwd")
	public ResponseEntity<String> findPwd(@RequestParam("username") String id,
			@RequestParam("email") String email) {
		String pwd = service.findPwd(id, email);
		return ResponseEntity.ok(pwd);
	}

	// 로그인 
	@PostMapping("/login")
	public ResponseEntity<Member> login(@RequestParam("username")String id,
			@RequestParam("password")String password ) {
		try {
			Member member = service.loginMember(id, password);			
			return ResponseEntity.ok(member);
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return null;
	}

	// 회원수정
	@PutMapping("/update")
	public ResponseEntity<Member> update(@RequestParam("username")String id,
			@RequestParam("password")String password,
			@RequestParam("email")String email,
			@RequestParam("phone")String phone,
			@RequestParam("nickname")String nickname) {
		Member member = Member.builder()
						.id(id)
						.password(password)
						.email(email)
						.phone(phone)
						.nickname(nickname)
						.build();
		log.info("수정" + member.toString());
		return ResponseEntity.ok(member);
	}

	// 회원탈퇴
	@DeleteMapping("/delete")
	public ResponseEntity<Boolean> deleteMember(@PathVariable int code) {
		try {
			service.delete(code);
		} 
		catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.ok(false);
		}
		
		return ResponseEntity.ok(true);
	}

}

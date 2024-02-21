package com.practice.semi.controller;

import java.util.List;
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
		ModelAndView mv = new ModelAndView();
		mv.setViewName("register");
		return mv;
	}
	
	@GetMapping("loginView")
	public ModelAndView loginView() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("member/login");
		return mv;
	}
	

	
	//--------------------- page view 
	
	//--------------------- function & mapping

	// 멤버 코드로 찾기
	@PostMapping("/findById")
	public String show(@PathVariable int code, Model model) {
		Member member = service.show(code);
		if (member != null) {
			model.addAttribute("member", member);
			return "회원조회 페이지";
		} else {
			return "조회실패 페이지";
		}
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

	// 비밀번호 찾기 이메일 인증하는거 넣어야함
	@PostMapping("/findPwd")
	public ResponseEntity<String> findPwd(@RequestBody MemberDTO dto) {
		String pwd = service.findPwd(dto);
		return ResponseEntity.ok(pwd);
	}


	// 회원가입
	@PostMapping("/register")
	public ModelAndView register(@RequestBody MemberDTO dto) {
		
		ModelAndView mv = new ModelAndView();

		Member member = Member.builder().id(dto.getId()).passWord(dto.getPwd()).email(dto.getMail())
				.phone(dto.getPhone()).nickName(dto.getNickName()).build();

		Member regiMember = service.create(member);

		if (regiMember != null) {
			MemberDTO responseDTO = MemberDTO.builder().id(regiMember.getId()).nickName(regiMember.getNickName())
					.build();
			mv.setViewName("index");
			return mv;
		} else {
			mv.setViewName("register");
			return mv;
		}
	}

	// 로그인 만들어야함
	@PostMapping("/login")
	public ResponseEntity<MemberDTO> loginMember(@RequestBody MemberDTO dto, Model model) {
		return null;
	}

	// 회원수정
	@PutMapping("/update")
	public ResponseEntity<MemberDTO> updateMember(@RequestBody MemberDTO dto, Model model) {
		return null;
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

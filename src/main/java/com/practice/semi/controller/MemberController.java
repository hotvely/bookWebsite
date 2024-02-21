package com.practice.semi.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	private PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	@GetMapping("/member")
	public String showAll(Model model){
			List<Member> members = service.showAll();
			model.addAttribute("members",members);
	       return "유저리스트 페이지";
	       
	    }
	
	
	// 멤버 코드로 찾기
	@GetMapping("/member/유저찾는페이지/{code}")
	public String memberDtail(@PathVariable int code, Model model){  
	     Member member = service.show(code);
		 if (member != null) {
			 model.addAttribute("member", member);
				return "회원조회 페이지";
		 }else {
			return "조회실패 페이지";
	}
}
	// 닉네임으로 멤버 찾기
	@GetMapping("/member/유저는찾페이지/{nickName}")
	public String show(@PathVariable String nickName, Model model){
		Member member = service.findByNickname(nickName);
		if (member != null) {
			model.addAttribute("member", member);
			return "회원조회 페이지";
		}else {
			return  "조회실패 페이지";	
	}
}
	
	// 아이디 찾기
	@PostMapping("/member/뭘로하지")
	public String findId(@RequestBody MemberDTO dto, Model model){
		String memberId = service.findId(dto);
		if (memberId != null) {
			model.addAttribute("memberId", memberId);
			return "아이디 찾은 페이지";
		}else {
			return "아이디 없다는 페이지";
		}	
	}
	
	// 비밀번호 찾기 이메일 인증하는거 넣어야함
	@PostMapping("/member/뭘로할까")
	public String findPwd(@RequestBody MemberDTO dto){
		String Pwd = service.findPwd(dto);
		return Pwd;
	}
	
	// 회원가입
	@PostMapping("/member/registerPage")
	public String registerPage(@RequestBody MemberDTO dto, Model model){
		
		Member member = Member.builder()
				.id(dto.getId())
				.passWord(passwordEncoder.encode(dto.getPwd()))
				.email(dto.getMail())
				.phone(dto.getPhone())
				.nickName(dto.getNickName())
				.build();				
		
		Member regiMember = service.create(member);
		
		if(regiMember != null) {
			MemberDTO responseDTO = MemberDTO.builder()
					.id(regiMember.getId())
					.nickName(regiMember.getNickName())
					.build();
			model.addAttribute("responseDTO",responseDTO);
			
			return "/member/login";
		}else {
			return "오류발생 페이지";				
			}
	}

	// 로그인 만들어야함
	@PostMapping("/member/login")
	public MemberDTO loginMember(@RequestBody MemberDTO dto, Model model){				
			return null;	
	}
	
	// 회원수정
	@PutMapping("/member")
	public MemberDTO updateMember(@RequestBody MemberDTO dto, Model model){	
			return null;		
	}
	
	// 회원탈퇴
	@DeleteMapping("/member/{code}")
	public Member deleteMember(@PathVariable int code){
		service.delete(code);
		return null;
		}
	
}

package com.practice.semi.controller;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.practice.semi.service.MemberService;
import com.practice.semi.vo.Member;
import com.practice.semi.vo.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/member")
@Slf4j
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	private PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	@GetMapping("/member")
	public ResponseEntity<List<Member>> showAll(){
		try {
			return ResponseEntity.status(HttpStatus.OK).body(service.showAll());
		}catch(Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}
	
	// 멤버 코드로 찾기
	@GetMapping("/member/{code}")
	public ResponseEntity<Member> show(@PathVariable int code){
	  try {
	     Member member = service.show(code);
			if (member != null) {
				return ResponseEntity.ok().body(member);
			}else {
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
			}
		}catch(Exception e){
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
		
	}
	
	// 닉네임으로 멤버 찾기
	@GetMapping("/member/{nickName}")
	public ResponseEntity<Member> show(@PathVariable String nickName){
		Member member = service.findByNickname(nickName);
		if (member != null) {
			return ResponseEntity.ok().body(member);
		}else {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}
	
	// 아이디 찾기
	@PostMapping("/member/뭘로하지")
	public ResponseEntity<String> findId(@RequestBody MemberDTO dto){
		String memberId = service.findId(dto);
		return ResponseEntity.ok().body(memberId);
	}
	
	// 비밀번호 찾기 이메일 인증하는거 넣어야함
	@PostMapping("/member/뭘로하지")
	public ResponseEntity<String> findPwd(@RequestBody MemberDTO dto){
		String Pwd = service.findPwd(dto);
		return ResponseEntity.ok().body(null);
	}
	
	// 회원가입
	@PostMapping("member/registerPage")
	public ResponseEntity<MemberDTO> registerPage(@RequestBody MemberDTO dto){
		try {
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
			return ResponseEntity.ok().body(responseDTO);
	 }
		}catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
	}
			return null;
}

	// 로그인
	@PostMapping("/member/login")
	public ResponseEntity<MemberDTO> loginMember(@RequestBody MemberDTO dto){
		try {
			
			return null;
		}catch(Exception e) {
			 return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}
	
	// 회원수정
	@PutMapping("/member")
	public ResponseEntity<MemberDTO> updateMember(@RequestBody MemberDTO dto){
		try {
			
			return null;
		}catch(Exception e) {
			 return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}

	// 회원탈퇴 update 방식으로 하려나
	
	// 회원탈퇴
	@DeleteMapping("/member/{code}")
	public ResponseEntity<Member> deleteMember(@PathVariable int code){
		service.delete(code);
		return null;
		}
	
}

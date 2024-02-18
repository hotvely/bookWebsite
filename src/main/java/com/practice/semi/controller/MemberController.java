package com.practice.semi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;

import com.practice.semi.service.MemberService;
import com.practice.semi.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	

	@GetMapping("/register")
	public String registerPage(){
		return "member/register";
	}
	
	@GetMapping("/login")
	public String loginPage(){
		return "member/login";
	}
	
	@GetMapping("/logout")
	public String logOut(){
		
		//Todo..
		
		return "index";
	}
	
	
	@GetMapping("/showall")
	public ResponseEntity<List<Member>> showAll(){
		return null;	
	}
	
	@GetMapping("/show/{code}")
	public ResponseEntity<Member> show(int code){
		return null;
	}
	

	@PostMapping("/register")
	public ResponseEntity<Member> register(){
		return null;
	}
	
	@PutMapping("/update")
	public ResponseEntity<Member> updateMember(){
		return null;
	}
	
	@DeleteMapping("/delete/{code}")
	public ResponseEntity<Member> deleteMember(){
		return null;
	}
	
}

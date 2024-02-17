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
	
	@GetMapping("/member")
	public ResponseEntity<List<Member>> showAll(){
		return null;	
	}
	
	@GetMapping("/member/{code}")
	public ResponseEntity<Member> show(int code){
		return null;
	}
	

	@PostMapping("/member")
	public ResponseEntity<Member> register(){
		return null;
	}
	
	@PutMapping("/member")
	public ResponseEntity<Member> updateMember(){
		return null;
	}
	
	@DeleteMapping("/member/{code}")
	public ResponseEntity<Member> deleteMember(){
		return null;
	}
	
}

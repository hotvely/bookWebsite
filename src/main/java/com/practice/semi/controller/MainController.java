package com.practice.semi.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.practice.semi.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class MainController {

	@GetMapping({ "/", "/main" })
	public ModelAndView home() {
		log.info("main page init !! ");

		ModelAndView mv = new ModelAndView();
		mv.setViewName("index");
		mv.addObject("test", 100);
		return mv;
	}

	@GetMapping("/header")
	public ModelAndView header(HttpSession session) throws JsonProcessingException {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("header");
		

		return mv;
	}
	
	@PostMapping("/header")
	public ResponseEntity<Member> header2(HttpSession session) throws JsonProcessingException {

		Member member = (Member)session.getAttribute("member");
		
		return ResponseEntity.ok(member);
	}
}

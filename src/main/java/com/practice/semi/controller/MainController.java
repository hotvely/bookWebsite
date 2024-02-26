package com.practice.semi.controller;

import org.apache.tomcat.util.json.JSONParser;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.practice.semi.vo.Member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class MainController {

	@GetMapping({ "/", "/main" })
	public ModelAndView home(@RequestParam(name = "pageNum", defaultValue = "1") int pageNum) {
		log.info("main page init !! ");

		ModelAndView mv = new ModelAndView();
		mv.setViewName("index");
		mv.addObject("currPage", pageNum);
		return mv;
	}

	@GetMapping("/header")
	public ModelAndView header(HttpSession session) throws JsonProcessingException {
		log.info("headercontroller");

//		Member member = (Member)session.getAttribute("member");
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("header");
//		if(member != null) {
//			ObjectMapper objectMapper = new ObjectMapper();
//			String memberJson = objectMapper.writeValueAsString(member);
//			mv.addObject("member", memberJson);
//		}
//		mv.addObject("member", member);

		return mv;
	}
	
	@PostMapping("/header")
	public ResponseEntity<Member> header2(HttpSession session) throws JsonProcessingException {
		log.info("headercontroller");

		Member member = (Member)session.getAttribute("member");
		
//		mv.addObject("member", member);

		return ResponseEntity.ok(member);
	}


}

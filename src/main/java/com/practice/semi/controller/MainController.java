package com.practice.semi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.practice.semi.vo.Member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
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
	public ModelAndView header(HttpSession session) {
		log.info("headercontroller");

		Member member = (Member) session.getAttribute("member");
		log.info(member.toString());
		ModelAndView mv = new ModelAndView();
		mv.setViewName("header");
		mv.addObject("member", member);

		return mv;
	}

}

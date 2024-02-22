package com.practice.semi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MainController {

	@GetMapping({ "/", "/main" })
	public ModelAndView home() {
		log.info("main page init !! ");
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index");
		mv.addObject("test" , 100);
		
		
		return mv;
	}

}

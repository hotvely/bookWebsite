package com.practice.semi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mysql.cj.log.Log;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {
	
	@GetMapping({"/","/main"})
	public String home() {
		System.out.println("main page init !! ");
//		Log.()
		return "index";
	}
	
}

package com.practice.semi.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.practice.semi.vo.Book;

import ch.qos.logback.core.model.Model;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/book")
public class BookController {
	Book a = new Book();
	Book[] list = { new Book(1, "안녕", "안녕", 999), new Book(2, "ㅋㅋㅋ", "ㅋㅋㅋ", 1000), new Book(3, "호호호호", "호호호호", 3333) };
	
	@GetMapping("/showAll")
	public ResponseEntity<List<Book>> showAll(Model model){
		log.info("book controller showall");
		
		List<Book> arr = new ArrayList<Book>();
		for(Book book : list) {
			arr.add(book);
		}
		
		return ResponseEntity.ok(arr);
	}
	
	
}

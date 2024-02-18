package com.practice.semi.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.practice.semi.service.BookService;
import com.practice.semi.vo.Book;

import ch.qos.logback.core.model.Model;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/book")
public class BookController {

	@Autowired
	BookService service;

	@GetMapping("/showAll")
	public ResponseEntity<List<Book>> showAll(Model model) {
		return ResponseEntity.ok(service.showAll());
	}

	@GetMapping("/create")
	public String createPage() {
		return "book/addBook";
	}

	@PostMapping("/create")
	public ResponseEntity<Book> create(@RequestParam(name = "title", required = false) String title,
			@RequestParam(name = "detail", required = false) String detail,
			@RequestParam(name = "authority", required = false) String authority,
			@RequestParam(name = "subCategory", required = false) Integer subCategory,
			@RequestParam(name = "price", required = false) Integer price,
			@RequestParam(name = "publisher", required = false) String publisher,
			@RequestParam(name = "date", required = false) Date date,
			@RequestParam(name = "image", required = false) String image) {

		if (price == null)
			price = 0;

		if (subCategory == null)
			subCategory = 0;

		Book book = Book.builder().title(title).detail(detail).authority(authority).subcategory(subCategory)
				.price(price).publisher(publisher).date(date).image(image).build();

		log.info(book.toString());

		return ResponseEntity.ok(service.create(book));
	}

}

package com.practice.semi.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
import org.springframework.web.servlet.ModelAndView;

import com.mysql.cj.Session;
import com.practice.semi.service.BookService;
import com.practice.semi.vo.Book;

import ch.qos.logback.core.model.Model;
import lombok.extern.slf4j.Slf4j;
import net.bytebuddy.utility.privilege.GetSystemPropertyAction;

@Controller
@Slf4j
@RequestMapping("/book")
public class BookController {

	@Autowired
	BookService service;

	@GetMapping("/showAll")
	public ResponseEntity<List<Book>> showAll(Model model) {
		List<Book> list = service.showAll();
		log.info(list.toString());
		return ResponseEntity.ok(service.showAll());
	}

	@GetMapping("/create")
	public String createView() {
		return "book/addBook";
	}

	@GetMapping("/detail")
	public ModelAndView detailView(@RequestParam(name = "code") int code) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("book/bookDetail");
		mv.addObject("code", code);
		return mv;
	}
	
	@PostMapping("/show")
	public ResponseEntity<Book> show(@RequestParam(name="code")int code){ 
		Book book = service.show(code);
		
		return ResponseEntity.ok(book);
	}

	
	
	
	
	
	@PostMapping("/create")
	public ResponseEntity<Book> create(@RequestParam(name = "title") String title,
			@RequestParam(name = "detail", required = false) String detail,
			@RequestParam(name = "authority") String authority,
			@RequestParam(name = "subcategory", required = false) Integer subcategory,
			@RequestParam(name = "price") int price, @RequestParam(name = "publisher") String publisher,
			@RequestParam(name = "date", required = false) String date,
			@RequestParam(name = "image", required = false) String image) {

		log.info("" + date);
		if (subcategory == null)
			subcategory = 0;

		// 날짜 문자열로 받아서 java.util.Date 타입으로 변환해 줘야함.
//		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//		Date bDate = null;
//		try {
//			bDate = formatter.parse(date);
//			log.info(""+ bDate);
//		} catch (ParseException e) {
//			// TODO 자동 생성된 catch 블록
//			e.printStackTrace();
//		}

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		// 포맷 적용
		LocalDate localDate = LocalDate.parse(date, formatter);

		Book book = Book.builder().title(title).detail(detail).authority(authority).subcategory(subcategory)
				.price(price).publisher(publisher).date(localDate).image(image).build();

		log.info(book.toString());

		return ResponseEntity.ok(service.create(book));
	}

}

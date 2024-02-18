package com.practice.semi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.practice.semi.dao.BookDAO;
import com.practice.semi.vo.Book;

@Service
public class BookService {

	@Autowired
	BookDAO dao;

	public List<Book> showAll() {
		return dao.findAll();
	}
	
	public Book show(int code) {
		return dao.findById(code).orElse(null);
	}
	
	public Book create(Book book) {
		return dao.save(book);
	}

}

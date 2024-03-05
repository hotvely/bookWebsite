package com.practice.semi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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

	public Page<Book> showAll(Pageable pageable) {
		// TODO 자동 생성된 메소드 스텁
		return dao.findAll(pageable);
	}

	public Book update(Book book) {
		// TODO 자동 생성된 메소드 스텁
		return dao.save(book);
	}

	public Page<Book> showAllCategory(Pageable pageable, int category) {
		// TODO 자동 생성된 메소드 스텁
		return dao.findByCategory(pageable, category);
	}

}

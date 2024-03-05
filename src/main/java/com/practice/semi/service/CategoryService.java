package com.practice.semi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.practice.semi.dao.CategoryDAO;
import com.practice.semi.vo.Category;

@Service
public class CategoryService {
	@Autowired
	CategoryDAO dao;

	public List<Category> showAll() {
		// TODO 자동 생성된 메소드 스텁
		return dao.findAll();
	}

}

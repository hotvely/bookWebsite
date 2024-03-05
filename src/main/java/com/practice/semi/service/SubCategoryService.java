package com.practice.semi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.practice.semi.dao.SubCategoryDAO;
import com.practice.semi.vo.SubCategory;

@Service
public class SubCategoryService {
	
	@Autowired
	SubCategoryDAO dao;
	
	public List<SubCategory> showAll() {
		// TODO 자동 생성된 메소드 스텁
		return dao.findAll();
	}

}

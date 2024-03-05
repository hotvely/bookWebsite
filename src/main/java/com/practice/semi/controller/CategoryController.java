package com.practice.semi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.practice.semi.service.CategoryService;
import com.practice.semi.service.SubCategoryService;
import com.practice.semi.vo.Category;
import com.practice.semi.vo.SubCategory;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/category")
public class CategoryController {

	@Autowired
	CategoryService categoryService;
	
	@Autowired
	SubCategoryService subCategoryService;
	
	@GetMapping("/category")
	public ResponseEntity<List<Category>> showCategory(){
		List<Category> list = categoryService.showAll();
		log.info(list.toString());
		return ResponseEntity.ok(list);
	}
	
	@GetMapping("/subCategory")
	public ResponseEntity<List<SubCategory>> showSubCategory(){
		List<SubCategory> list = subCategoryService.showAll();
		
		return ResponseEntity.ok(list);
	}
	
	
}

package com.practice.semi.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.practice.semi.vo.Category;

public interface CategoryDAO extends JpaRepository<Category, Integer>{

}

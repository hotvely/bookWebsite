package com.practice.semi.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.practice.semi.vo.Book;

public interface BookDAO extends JpaRepository<Book, Integer> {

	@Query(value = "SELECT * FROM BOOK WHERE SUBCATEGORY=:scode", nativeQuery = true)
	Page<Book> findByCategory(Pageable pageable, @Param("scode")int scode);

}

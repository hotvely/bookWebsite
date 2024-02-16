package com.practice.semi.vo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class Book {
	
	@Id
	int bookCode;
	
	@Column
	String bookTitle;
	
	@Column
	String bookDetail;
	
	@Column
	int price;
	
}

package com.practice.semi.vo;



import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Book {
	
	@Id
	@Column
	private int code;
	
	@Column
	private String title;	
	
	@Column
	private String detail;
	
	@Column
	private String authority;
	
	@Column
	private int subcategory;
	
	@Column
	private int price;
	
	@Column
	private String publisher;
	
	@Column
	private Date date;
	
	@Column
	private String image;

	
	
}

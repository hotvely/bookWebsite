package com.practice.semi.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Paging {
	private long totalCount;
	private int totalPages;
	private int currPage;
	private boolean hasNext;
	private boolean hasPrev;
	private boolean isFirst;
	
	private List<Book> bookList;
	
	
	

}

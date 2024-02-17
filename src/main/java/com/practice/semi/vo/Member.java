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
public class Member {
	
	@Id
	int userCode;
	
	@Column
	String id;
	
	@Column
	String passWord;
	
	@Column
	String email;
	
	@Column
	String phone;
	
	@Column
	String nickName;
	
}

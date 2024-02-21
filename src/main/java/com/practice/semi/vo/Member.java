package com.practice.semi.vo;

import org.hibernate.annotations.ColumnDefault;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "MEMBER")
public class Member {
	
	@Id
	@Column(name = "CODE")
	@GeneratedValue(strategy = GenerationType.IDENTITY)   
	int userCode;
	
	@Column(name = "ID")
	String id;
	
	@Column(name = "PASSWORD")
	String passWord;
	
	@Column(name = "EMAIL")
	String email;
	
	@Column(name = "PHONE")
	String phone;
	
	@Column(name = "NICKNAME")
	String nickName;
	
	@Column(name = "ROLE")
	String role;
	
}

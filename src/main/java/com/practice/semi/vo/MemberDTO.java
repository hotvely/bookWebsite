package com.practice.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberDTO {

	private int code;
	private String id;
	private String pwd;
	private String mail;
	private String phone;
	private String nickName;
}

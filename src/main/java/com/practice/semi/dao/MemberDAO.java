package com.practice.semi.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import com.practice.semi.vo.Member;
import org.springframework.data.jpa.repository.Query;

public interface MemberDAO extends JpaRepository<Member, Integer> {
	
	

}

package com.practice.semi.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import com.practice.semi.vo.Member;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface MemberDAO extends JpaRepository<Member, Integer> {
	
	// 닉네임으로 멤버 찾기
	@Query(value = "SELECT * FROM MEMBER WHERE NICKNAME = :nickname", nativeQuery = true)
	Member findByNickName(String nickname); 
		
	// 아이디 찾기
	@Query(value = "SELECT ID FROM MEMBER WHERE PHONE = :phone AND EMAIL = :email", nativeQuery = true)
	String findByMemberId(String id, String email); 
	
	// 비밀번호 찾기
	@Query(value = "SELECT PASSWORD FROM MEMBER WHERE ID = :id AND EMAIL = :email ", nativeQuery = true)
	String findByPwd(String id, String email);
	
	
	@Query(value = "SELECT ID FROM MEMBER WHERE ID =:id", nativeQuery = true)
	Member findByStringId(String id); 
	
	
//	@Query(value = "SELECT * FROM MEMBER WHERE CODE = :userCode", nativeQuery = true)
//	void deleteByCode(@Param("userCode") int userCode); 
	
}

package com.practice.semi.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import com.practice.semi.vo.Member;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface MemberDAO extends JpaRepository<Member, Integer> {
	
	// 닉네임으로 멤버 찾기
	@Query(value = "SELECT * FROM MEMBER WHERE NICKNAME =:nickname", nativeQuery = true)
	Member findByNickName(@Param("nickname")String nickname); 
	
	@Query(value = "SELECT * FROM MEMBER WHERE ID =:id", nativeQuery = true)
	Member findByStringId(@Param("id") String id); 
	
	// 아이디 찾기
	@Query(value = "SELECT ID FROM MEMBER WHERE PHONE = :phone AND EMAIL = :email", nativeQuery = true)
	String findByMemberId(@Param("phone")String phone, @Param("email")String email); 
	
	// 비밀번호 찾기
	@Query(value = "SELECT PASSWORD FROM MEMBER WHERE ID = :id AND EMAIL = :email ", nativeQuery = true)
	String findByPwd(@Param("id")String id,@Param("email")String email);
		
	// 로그인
	@Query(value = "SELECT * FROM MEMBER WHERE ID =:id AND PASSWORD =:password", nativeQuery = true)
	Member login(@Param("id")String id, @Param("password")String password);
	
	
//	@Query(value = "SELECT * FROM MEMBER WHERE CODE = :code", nativeQuery = true)
//	void deleteByCode(@Param("userCode") int code); 
	
}

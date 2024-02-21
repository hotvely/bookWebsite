package com.practice.semi.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.practice.semi.dao.MemberDAO;
import com.practice.semi.vo.Member;
import com.practice.semi.vo.MemberDTO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class MemberService {
	
	@Autowired
	private MemberDAO dao;

	// 아이디 찾기
	public String findId(MemberDTO dto) {
		return dao.findByMemberId(dto.getPhone(), dto.getMail());
	}
	
	// 비밀번호 찾기
//	public String findPwd(MemberDTO dto) {
//		return dao.findByPwd(dto.getId(), dto.getMail());
//	}
//	
	public String findPwd(String id, String email) {
		return dao.findByPwd(id, email);
	}
	
	// 로그인 만들어야됨
	public Member loginMember(String id, String password) {
		Member member = dao.findByStringId(id);
		if(member != null && password.equals(member.getPassword())) {
			return member;
		}		
		return null;
	}
	
	public List<Member> showAll(){
		return dao.findAll();
	}
	
	 public Member show(Integer code) {
	     Member member = dao.findById(code).orElse(null);
	     if(member != null) {
	    	 return member;
	     }
	     log.info("멤버 코드로 조회한 계정이 없을시 ");
		 return null;
	    } 
	
	public Member findByNickname(String nickname) {
		Member member = dao.findByNickName(nickname);
	    if(member != null) {
	    	return member;
		 }
		 log.info("닉네임으로 조회한 계정이 없을시 ");
		 return null;
		} 
	
	public Member create(Member vo) {
		log.info("member create: " + vo);
		return dao.save(vo);
	}
	
	public Member update(Member vo) {
		Member member = dao.findById(vo.getUserCode()).orElse(null);
			if(member != null) {
				log.info("member update : " + member);
				return dao.save(member);
			}else {
				return dao.save(member);
			}
		}

	public void delete(int code) {
		dao.deleteById(code);
	}
}

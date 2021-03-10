package com.bookstore.webservice.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service("memberService")
@Transactional(propagation = Propagation.REQUIRED)
public class MemberService {

    @Autowired
    private MemberDAO memberDAO;

    public MemberVO login(Map<String,String> loginMap) throws Exception {
        return memberDAO.login(loginMap);
    }

    public String overlapped(String id) throws Exception {
        return memberDAO.selectOverlappedID(id);
    }

    public void addMember(MemberVO memberVO) throws Exception {
        memberDAO.insertNewMember(memberVO);
    }
}

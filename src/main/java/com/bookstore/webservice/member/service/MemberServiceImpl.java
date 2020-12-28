package com.bookstore.webservice.member.service;

import com.bookstore.webservice.member.dao.MemberDAO;
import com.bookstore.webservice.member.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service("memberService")
@Transactional(propagation = Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberDAO memberDAO;

    @Override
    public MemberVO login(Map loginMap) throws Exception {
        return memberDAO.login(loginMap);
    }

    @Override
    public String overlapped(String id) throws Exception {
        return memberDAO.selectOverlappedID(id);
    }
}

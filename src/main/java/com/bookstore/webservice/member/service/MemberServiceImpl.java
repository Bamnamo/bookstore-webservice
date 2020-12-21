package com.bookstore.webservice.member.service;

import com.bookstore.webservice.member.dao.MemberDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("memberService")
@Transactional(propagation = Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberDAO memberDAO;

    @Override
    public List listMembers() throws Exception {
        List membersList = null;
        membersList = memberDAO.selectAllMemberList();
        return membersList;
    }
}

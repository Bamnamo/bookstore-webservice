package com.bookstore.webservice.admin.member.service;

import com.bookstore.webservice.admin.member.dao.AdminMemberDAO;
import com.bookstore.webservice.member.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;

@Service("adminMemberService")
@Transactional(propagation = Propagation.REQUIRED)
public class AdminMemberServiceImpl implements AdminMemberService {

    @Autowired
    private AdminMemberDAO adminMemberDAO;


    @Override
    public ArrayList<MemberVO> listMember(HashMap condMap) throws Exception {
        return adminMemberDAO.listMember(condMap);
    }
}

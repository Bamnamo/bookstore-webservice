package com.bookstore.webservice.admin.member;

import com.bookstore.webservice.member.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;

@Service("adminMemberService")
@Transactional(propagation = Propagation.REQUIRED)
public class AdminMemberService {

    @Autowired
    private AdminMemberDAO adminMemberDAO;



    public ArrayList<MemberVO> listMember(HashMap condMap) throws Exception {
        return adminMemberDAO.listMember(condMap);
    }


    public MemberVO memberDetail(String memberId) throws Exception {
        return adminMemberDAO.memberDetail(memberId);
    }


    public void modifyMemberInfo(HashMap memberMap) throws Exception {
        String memberId=(String)memberMap.get("memberId");
        adminMemberDAO.updateMemberInfo(memberMap);
    }
}

package com.bookstore.webservice.admin.member.service;

import com.bookstore.webservice.member.vo.MemberVO;

import java.util.ArrayList;
import java.util.HashMap;

public interface AdminMemberService {
    public ArrayList<MemberVO> listMember(HashMap condMap) throws Exception;
}

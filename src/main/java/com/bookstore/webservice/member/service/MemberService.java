package com.bookstore.webservice.member.service;

import com.bookstore.webservice.member.vo.MemberVO;

import java.util.List;
import java.util.Map;

public interface MemberService {

    public MemberVO login(Map loginMap) throws Exception;

    public String overlapped(String id) throws Exception;
}

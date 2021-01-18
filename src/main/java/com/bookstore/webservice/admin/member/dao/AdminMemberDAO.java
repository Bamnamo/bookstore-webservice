package com.bookstore.webservice.admin.member.dao;

import com.bookstore.webservice.member.vo.MemberVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;

@Mapper
@Repository("adminMemberDAO")
public interface AdminMemberDAO {
    public ArrayList<MemberVO> listMember(HashMap condMap) throws DataAccessException;
    public MemberVO memberDetail(String member_id) throws DataAccessException;
    public void modifyMemberInfo(HashMap memberMap) throws DataAccessException;
}

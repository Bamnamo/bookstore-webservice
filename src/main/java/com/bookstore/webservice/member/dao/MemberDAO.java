package com.bookstore.webservice.member.dao;

import com.bookstore.webservice.member.vo.MemberVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import javax.xml.crypto.Data;
import java.util.List;
import java.util.Map;

@Mapper
@Repository("memberDAO")
public interface MemberDAO {

    public MemberVO login(Map loginMap) throws DataAccessException;

    public String selectOverlappedID(String id) throws DataAccessException;

    public void insertNewMember(MemberVO memberVO) throws DataAccessException;
}

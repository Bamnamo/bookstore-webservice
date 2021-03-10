package com.bookstore.webservice.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository("memberDAO")
public class MemberDAO {

    @Autowired
    private SqlSession sqlSession;


    public MemberVO login(Map<String,String> loginMap) throws DataAccessException {
        return sqlSession.selectOne("mapper.member.login",loginMap);
    }

    public String selectOverlappedID(String id) throws DataAccessException {
        return sqlSession.selectOne("mapper.member.selectOverlappedID",id);
    }

    public void insertNewMember(MemberVO memberVO) throws DataAccessException {
        sqlSession.insert("mapper.member.insertNewMember",memberVO);
    }
}

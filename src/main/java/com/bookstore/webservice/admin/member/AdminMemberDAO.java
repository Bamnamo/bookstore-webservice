package com.bookstore.webservice.admin.member;

import com.bookstore.webservice.member.MemberVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;


@Repository("adminMemberDAO")
public class AdminMemberDAO {

    @Autowired
    SqlSession sqlSession;

    public ArrayList<MemberVO> listMember(HashMap condMap) throws DataAccessException {
        return (ArrayList<MemberVO>) (ArrayList) sqlSession.selectList("mapper.admin.member.listMember", condMap);
    }

    public MemberVO memberDetail(String memberId) throws DataAccessException {
        return (MemberVO) sqlSession.selectOne("mapper.admin.member.memberDetail", memberId);
    }

    public void updateMemberInfo(HashMap memberMap) throws DataAccessException {
        sqlSession.update("mapper.admin.member.updateMemberInfo", memberMap);
    }
}

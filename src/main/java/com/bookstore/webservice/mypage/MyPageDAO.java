package com.bookstore.webservice.mypage;

import com.bookstore.webservice.member.MemberVO;
import com.bookstore.webservice.order.OrderVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("myPageDAO")
public class MyPageDAO {

    @Autowired
    SqlSession sqlSession;

    public List<OrderVO> selectMyOrderGoodsList(String memberId) throws DataAccessException {
        return (List<OrderVO>) (List) sqlSession.selectList("mapper.mypage.selectMyOrderGoodsList", memberId);
    }

    public List selectMyOrderInfo(String orderId) throws DataAccessException {
        List myOrderList = (List) sqlSession.selectList("mapper.mypage.selectMyOrderInfo", orderId);
        return myOrderList;
    }

    public List<OrderVO> selectMyOrderHistoryList(Map dateMap) throws DataAccessException {
        return (List<OrderVO>) (List) sqlSession.selectList("mapper.mypage.selectMyOrderHistoryList", dateMap);
    }

    public void updateMyInfo(Map memberMap) throws DataAccessException {
        sqlSession.update("mapper.mypage.updateMyInfo", memberMap);
    }

    public MemberVO selectMyDetailInfo(String memberId) throws DataAccessException {
        return (MemberVO) sqlSession.selectOne("mapper.mypage.selectMyDetailInfo", memberId);

    }

    public void updateMyOrderCancel(String orderId) throws DataAccessException {
        sqlSession.update("mapper.mypage.updateMyOrderCancel", orderId);
    }
}


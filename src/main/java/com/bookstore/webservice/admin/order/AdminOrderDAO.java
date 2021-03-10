package com.bookstore.webservice.admin.order;

import com.bookstore.webservice.member.MemberVO;
import com.bookstore.webservice.order.OrderVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Map;


@Repository("adminOderDAO")
public class AdminOrderDAO {

    @Autowired
    private SqlSession sqlSession;

    public ArrayList<OrderVO> selectNewOrderList(Map condMap) throws DataAccessException {
        return (ArrayList<OrderVO>) (ArrayList) sqlSession.selectList("mapper.admin.order.selectNewOrderList", condMap);
    }

    public void updateDeliveryState(Map deliveryMap) throws DataAccessException {
        sqlSession.update("mapper.admin.order.updateDeliveryState", deliveryMap);
    }

    public ArrayList<OrderVO> selectOrderDetail(int orderId) throws DataAccessException {
        return (ArrayList<OrderVO>) (ArrayList) sqlSession.selectList("mapper.admin.order.selectOrderDetail", orderId);
    }

    public MemberVO selectOrderer(String memberId) throws DataAccessException {
        return (MemberVO) sqlSession.selectOne("mapper.admin.order.selectOrderer", memberId);
    }
}

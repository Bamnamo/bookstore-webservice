package com.bookstore.webservice.order;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository("orderDAO")
public class OrderDAO  {

    @Autowired
    private SqlSession sqlSession;


    public void insertNewOrder(List<OrderVO> myOrderList) throws DataAccessException {
        int orderId = selectOrderID();
        for (int i = 0; i < myOrderList.size(); i++) {
            OrderVO orderVO = (OrderVO) myOrderList.get(i);
            orderVO.setOrderId(orderId);
            sqlSession.insert("mapper.order.insertNewOrder", orderVO);
        }

    }

    public void removeGoodsFromCart(List<OrderVO> myOrderList) throws DataAccessException {
        for (int i = 0; i < myOrderList.size(); i++) {
            OrderVO orderVO = (OrderVO) myOrderList.get(i);
            sqlSession.delete("mapper.order.deleteGoodsFromCart", orderVO);
        }
    }

    public List<OrderVO> listMyOrderGoods(OrderVO orderVO) throws DataAccessException {
        List<OrderVO> orderGoodsList = new ArrayList<OrderVO>();
        orderGoodsList = (ArrayList) sqlSession.selectList("mapper.order.selectMyOrderList", orderVO);
        return orderGoodsList;
    }

    public OrderVO findMyOrder(String orderId) throws DataAccessException {
        OrderVO orderVO = (OrderVO) sqlSession.selectOne("mapper.order.selectMyOrder", orderId);
        return orderVO;
    }

    public int selectOrderID() throws DataAccessException {
        return sqlSession.selectOne("mapper.order.selectOrderID");
    }

}

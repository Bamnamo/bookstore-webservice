package com.bookstore.webservice.order.dao;

import com.bookstore.webservice.order.vo.OrderVO;
import com.sun.tools.corba.se.idl.constExpr.Or;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository("orderDAO")
public class OrderDAOImpl implements OrderDAO {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public void insertNewOrder(List<OrderVO> myOrderList) throws DataAccessException {
        int order_id = selectOrderID();
        for (int i = 0; i < myOrderList.size(); i++) {
            OrderVO orderVO = (OrderVO) myOrderList.get(i);
            orderVO.setOrder_id(order_id);
            sqlSession.insert("mapper.order.insertNewOrder", orderVO);
        }

    }

    @Override
    public void removeGoodsFromCart(List<OrderVO> myOrderList) throws DataAccessException {
        for (int i = 0; i < myOrderList.size(); i++) {
            OrderVO orderVO = (OrderVO) myOrderList.get(i);
            sqlSession.delete("mapper.order.deleteGoodsFromCart", orderVO);
        }
    }

    @Override
    public List<OrderVO> listMyOrderGoods(OrderVO orderVO) throws DataAccessException {
        List<OrderVO> orderGoodsList = new ArrayList<OrderVO>();
        orderGoodsList = (ArrayList) sqlSession.selectList("mapper.order.selectMyOrderList", orderVO);
        return orderGoodsList;
    }

    @Override
    public OrderVO findMyOrder(String order_id) throws DataAccessException {
        OrderVO orderVO = (OrderVO) sqlSession.selectOne("mapper.order.selectMyOrder", order_id);
        return orderVO;
    }

    public int selectOrderID() throws DataAccessException {
        return sqlSession.selectOne("mapper.order.selectOrderID");
    }

}

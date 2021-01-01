package com.bookstore.webservice.order.service;

import com.bookstore.webservice.order.dao.OrderDAO;
import com.bookstore.webservice.order.vo.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("orderService")
@Transactional(propagation = Propagation.REQUIRED)
public class OrderServiceImpl implements OrderService{

    @Autowired
    private OrderDAO orderDAO;

    @Override
    public void addNewOrder(List<OrderVO> myOrderList) throws Exception {
        orderDAO.insertNewOrder(myOrderList);
        orderDAO.removeGoodsFromCart(myOrderList);
    }
}
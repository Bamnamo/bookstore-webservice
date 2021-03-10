package com.bookstore.webservice.order;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("orderService")
@Transactional(propagation = Propagation.REQUIRED)
public class OrderService {

    @Autowired
    private OrderDAO orderDAO;


    public void addNewOrder(List<OrderVO> myOrderList) throws Exception {
        orderDAO.insertNewOrder(myOrderList);
        orderDAO.removeGoodsFromCart(myOrderList);
    }


    public List<OrderVO> listMyOrderGoods(OrderVO orderVO) throws Exception {
        List<OrderVO> orderGoodsList;
        orderGoodsList = orderDAO.listMyOrderGoods(orderVO);
        return orderGoodsList;
    }


    public OrderVO findMyOrder(String orderId) throws Exception {
        return orderDAO.findMyOrder(orderId);
    }
}

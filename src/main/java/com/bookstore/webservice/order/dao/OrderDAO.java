package com.bookstore.webservice.order.dao;

import com.bookstore.webservice.order.vo.OrderVO;
import org.springframework.dao.DataAccessException;

import java.util.List;

public interface OrderDAO {
    public void insertNewOrder(List<OrderVO> myOrderList) throws DataAccessException;

    public void removeGoodsFromCart(List<OrderVO> myOrderList) throws DataAccessException;
}

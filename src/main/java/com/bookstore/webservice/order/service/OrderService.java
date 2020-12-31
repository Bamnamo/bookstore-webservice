package com.bookstore.webservice.order.service;

import com.bookstore.webservice.order.vo.OrderVO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("orderService")
public interface OrderService {
    public void addNewOrder(List<OrderVO> myOrderList) throws Exception;
}

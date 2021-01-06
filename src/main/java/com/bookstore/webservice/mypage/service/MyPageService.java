package com.bookstore.webservice.mypage.service;

import com.bookstore.webservice.order.vo.OrderVO;

import java.util.List;

public interface MyPageService {
    public List<OrderVO> listMyOrderGoods(String member_id) throws Exception;
    public void cancelOrder(String order_id) throws Exception;
}
package com.bookstore.webservice.mypage.service;

import com.bookstore.webservice.member.vo.MemberVO;
import com.bookstore.webservice.order.vo.OrderVO;

import java.util.List;
import java.util.Map;

public interface MyPageService {
    public List<OrderVO> listMyOrderGoods(String member_id) throws Exception;
    public void cancelOrder(String order_id) throws Exception;
    public MemberVO modifyMyInfo(Map<String, String> memberMap) throws Exception;
    public List findMyOrderInfo(String order_id) throws Exception;
    public List<OrderVO> listMyOrderHistory(Map<String, String> dateMap) throws Exception;
    public MemberVO myDetailInfo(String member_id) throws Exception;

}

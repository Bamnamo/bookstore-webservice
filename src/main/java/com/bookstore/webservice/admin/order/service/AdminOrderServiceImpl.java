package com.bookstore.webservice.admin.order.service;

import com.bookstore.webservice.admin.order.dao.AdminOrderDAO;
import com.bookstore.webservice.member.vo.MemberVO;
import com.bookstore.webservice.order.vo.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("adminOrderService")
@Transactional(propagation = Propagation.REQUIRED)
public class AdminOrderServiceImpl implements AdminOrderService {

    @Autowired
    private AdminOrderDAO adminOrderDAO;

    @Override
    public List<OrderVO> listNewOrder(HashMap condMap) throws Exception {
        return adminOrderDAO.selectNewOrderList(condMap);
    }

    @Override
    public Map orderDetail(int order_id) throws Exception {
        Map orderMap = new HashMap();
        ArrayList<OrderVO> orderList = adminOrderDAO.selectOrderDetail(order_id);
        OrderVO deliveryInfo = (OrderVO) orderList.get(0);
        String member_id = (String) deliveryInfo.getMember_id();
        MemberVO orderer = adminOrderDAO.selectOrderer(member_id);
        orderMap.put("orderList", orderList);
        orderMap.put("deliveryInfo", deliveryInfo);
        orderMap.put("orderer", orderer);
        return orderMap;
    }
}

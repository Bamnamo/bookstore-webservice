package com.bookstore.webservice.admin.order;

import com.bookstore.webservice.member.MemberVO;
import com.bookstore.webservice.order.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("adminOrderService")
@Transactional(propagation = Propagation.REQUIRED)
public class AdminOrderService {

    @Autowired
    private AdminOrderDAO adminOrderDAO;

    public List<OrderVO> listNewOrder(Map condMap) throws Exception {
        return adminOrderDAO.selectNewOrderList(condMap);
    }


    public void modifyDeliveryState(Map deliveryMap) throws Exception {
        adminOrderDAO.updateDeliveryState(deliveryMap);
    }


    public Map orderDetail(int orderId) throws Exception {
        Map orderMap = new HashMap();
        ArrayList<OrderVO> orderList = adminOrderDAO.selectOrderDetail(orderId);
        OrderVO deliveryInfo = (OrderVO) orderList.get(0);
        String memberId = (String) deliveryInfo.getMemberId();
        MemberVO orderer = adminOrderDAO.selectOrderer(memberId);
        orderMap.put("orderList", orderList);
        orderMap.put("deliveryInfo", deliveryInfo);
        orderMap.put("orderer", orderer);
        return orderMap;
    }
}

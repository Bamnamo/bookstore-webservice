package com.bookstore.webservice.mypage;

import com.bookstore.webservice.member.MemberVO;
import com.bookstore.webservice.order.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service("myPageService")
@Transactional(propagation = Propagation.REQUIRED)
public class MyPageService{


    @Autowired
    private MyPageDAO myPageDAO;



    public List<OrderVO> listMyOrderGoods(String memberId) throws Exception {
        return myPageDAO.selectMyOrderGoodsList(memberId);
    }


    public void cancelOrder(String orderId) throws Exception {
        myPageDAO.updateMyOrderCancel(orderId);
    }


    public MemberVO modifyMyInfo(Map<String, String> memberMap) throws Exception {
        String memberId = (String) memberMap.get("memberId");
        myPageDAO.updateMyInfo(memberMap);
        return myPageDAO.selectMyDetailInfo(memberId);
    }


    public List findMyOrderInfo(String orderId) throws Exception {
        return myPageDAO.selectMyOrderInfo(orderId);
    }


    public List<OrderVO> listMyOrderHistory(Map<String, String> dateMap) throws Exception {
        return myPageDAO.selectMyOrderHistoryList(dateMap);
    }


    public MemberVO myDetailInfo(String memberId) throws Exception {
        return myPageDAO.selectMyDetailInfo(memberId);
    }
}

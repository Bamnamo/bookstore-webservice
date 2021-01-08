package com.bookstore.webservice.mypage.service;

import com.bookstore.webservice.member.vo.MemberVO;
import com.bookstore.webservice.mypage.dao.MyPageDAO;
import com.bookstore.webservice.mypage.vo.MyPageVO;
import com.bookstore.webservice.order.vo.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import javax.xml.ws.ServiceMode;
import java.util.List;
import java.util.Map;

@Service("myPageService")
@Transactional(propagation = Propagation.REQUIRED)
public class MyPageServiceImpl implements MyPageService {


    @Autowired
    private MyPageDAO myPageDAO;


    @Override
    public List<OrderVO> listMyOrderGoods(String member_id) throws Exception {
        return myPageDAO.selectMyOrderGoodsList(member_id);
    }

    @Override
    public void cancelOrder(String order_id) throws Exception {
        myPageDAO.updateMyOrderCancel(order_id);
    }

    @Override
    public MemberVO modifyMyInfo(Map<String, String> memberMap) throws Exception {
        String member_id = (String) memberMap.get("member_id");
        myPageDAO.updateMyInfo(memberMap);
        return myPageDAO.selectMyDetailInfo(member_id);
    }

    @Override
    public List findMyOrderInfo(String order_id) throws Exception {
        return myPageDAO.selectMyOrderInfo(order_id);
    }

    @Override
    public List<OrderVO> listMyOrderHistory(Map<String, String> dateMap) throws Exception {
        return myPageDAO.selectMyOrderHistoryList(dateMap);
    }

    @Override
    public MemberVO myDetailInfo(String member_id) throws Exception {
        return myPageDAO.selectMyDetailInfo(member_id);
    }
}

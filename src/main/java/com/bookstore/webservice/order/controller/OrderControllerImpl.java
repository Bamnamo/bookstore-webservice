package com.bookstore.webservice.order.controller;

import com.bookstore.webservice.member.vo.MemberVO;
import com.bookstore.webservice.order.service.OrderService;
import com.bookstore.webservice.order.vo.OrderVO;
import com.sun.xml.internal.ws.resources.HttpserverMessages;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller("orderController")
@RequestMapping(value = "/order")
public class OrderControllerImpl implements OrderController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderVO orderVO;

    @Override
    @RequestMapping(value = "/orderEachGoods.do", method = RequestMethod.POST)
    public ModelAndView orderEachGoods(@ModelAttribute("orderVO") OrderVO _orderVO,
                                       HttpServletRequest request, HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        session = request.getSession();

        Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
        String action = (String) session.getAttribute("action");

        if (isLogOn == null || isLogOn == false) {
            session.setAttribute("orderInfo", _orderVO);
            session.setAttribute("action", "/order/orderEachGoods.do");
            return new ModelAndView("redirect:/member/loginForm.do");
        } else {
            if (action != null && action.equals("/order/orderEachGoods.do")) {
                orderVO = (OrderVO) session.getAttribute("orderInfo");
                session.removeAttribute("action");
            } else {
                orderVO = _orderVO;
            }
        }

        String viewName = (String) request.getAttribute("viewName");
        ModelAndView mav = new ModelAndView(viewName);

        List myOrderList = new ArrayList<OrderVO>();
        myOrderList.add(orderVO);

        MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");

        session.setAttribute("myOrderList", myOrderList);
        session.setAttribute("orderer", memberInfo);
        return mav;
    }

    @Override
    @RequestMapping(value = "/payToOrderGoods.do", method = RequestMethod.POST)
    public ModelAndView payToOrderGoods(@RequestParam Map<String, String> receiverMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

        String viewName = (String) request.getAttribute("viewName");
        ModelAndView mav = new ModelAndView(viewName);

        HttpSession session = request.getSession();
        MemberVO memberVO = (MemberVO) session.getAttribute("orderer");
        String member_id = memberVO.getMember_id();
        String orderer_name = memberVO.getMember_name();
        String orderer_hp = memberVO.getHp1() + "-" + memberVO.getHp2() + "-" + memberVO.getHp3();
        List<OrderVO> myOrderList = (List<OrderVO>) session.getAttribute("myOrderList");

        for (int i = 0; i < myOrderList.size(); i++) {
            OrderVO orderVO = (OrderVO) myOrderList.get(i);
            orderVO.setMember_id(member_id);
            orderVO.setOrderer_name(orderer_name);
            orderVO.setReceiver_name(receiverMap.get("receiver_name"));

            orderVO.setReceiver_hp1(receiverMap.get("receiver_hp1"));
            orderVO.setReceiver_hp2(receiverMap.get("receiver_hp2"));
            orderVO.setReceiver_hp3(receiverMap.get("receiver_hp3"));
            orderVO.setReceiver_tel1(receiverMap.get("receiver_tel1"));
            orderVO.setReceiver_tel2(receiverMap.get("receiver_tel2"));
            orderVO.setReceiver_tel3(receiverMap.get("receiver_tel3"));

            orderVO.setDelivery_address(receiverMap.get("delivery_address"));
            orderVO.setDelivery_message(receiverMap.get("delivery_message"));
            orderVO.setDelivery_method(receiverMap.get("delivery_method"));
            orderVO.setGift_wrapping(receiverMap.get("gift_wrapping"));
            orderVO.setPay_method(receiverMap.get("pay_method"));
            orderVO.setCard_com_name(receiverMap.get("card_com_name"));
            orderVO.setCard_pay_month(receiverMap.get("card_pay_month"));
            orderVO.setPay_orderer_hp_num(receiverMap.get("pay_orderer_hp_num"));
            orderVO.setOrderer_hp(orderer_hp);
            myOrderList.set(i, orderVO);
        }
        orderService.addNewOrder(myOrderList);
        mav.addObject("myOrderInfo", receiverMap);
        mav.addObject("myOrderList", myOrderList);
        return mav;
    }



}



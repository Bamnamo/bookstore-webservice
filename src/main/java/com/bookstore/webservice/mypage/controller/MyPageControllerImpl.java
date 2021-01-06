package com.bookstore.webservice.mypage.controller;

import com.bookstore.webservice.member.vo.MemberVO;
import com.bookstore.webservice.mypage.service.MyPageService;
import com.bookstore.webservice.mypage.vo.MyPageVO;
import com.bookstore.webservice.order.vo.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.AutoConfigurationPackage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller("myPageController")
@RequestMapping(value = "/mypage")
public class MyPageControllerImpl implements MyPageController {

    @Autowired
    private MyPageService myPageService;
    @Autowired
    private MemberVO memberVO;

    @Override
    @RequestMapping(value = "myPageMain.do", method = RequestMethod.GET)
    public ModelAndView myPageMain(@RequestParam(required = false, value = "message") String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        session = request.getSession();
        session.setAttribute("side_menu", "my_page");
        String viewName = (String) request.getAttribute("viewName");
        ModelAndView mav = new ModelAndView(viewName);
        memberVO = (MemberVO) session.getAttribute("memberInfo");
        String member_id = memberVO.getMember_id();
        List<OrderVO> myOrderList = myPageService.listMyOrderGoods(member_id);

        mav.addObject("message", message);
        mav.addObject("myOrderList", myOrderList);
        return mav;
    }

    @Override
    @RequestMapping(value = "/cancelMyOrder.do", method = RequestMethod.POST)
    public ModelAndView cancelMyOrder(@RequestParam("order_id") String order_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView();
        myPageService.cancelOrder(order_id);
        mav.addObject("message", "cancel_order");
        mav.setViewName("redirect:/mypage/myPageMain.do");
        return mav;
    }


}

package com.bookstore.webservice.order;

import com.bookstore.webservice.goods.GoodsVO;
import com.bookstore.webservice.member.MemberVO;
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
public class OrderController  {

    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderVO orderVO;


    @RequestMapping(value = "/orderEachGoods.do", method = RequestMethod.POST)
    public ModelAndView orderEachGoods(@ModelAttribute("orderVO") OrderVO order,
                                       HttpServletRequest request, HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
        String action = (String) session.getAttribute("action");

        if (isLogOn == null || isLogOn == false) {
            session.setAttribute("orderInfo", order);
            session.setAttribute("action", "/order/orderEachGoods.do");
            return new ModelAndView("redirect:/member/loginForm.do");
        } else {
            if (action != null && action.equals("/order/orderEachGoods.do")) {
                orderVO = (OrderVO) session.getAttribute("orderInfo");
                session.removeAttribute("action");
            } else {
                orderVO = order;
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


    @RequestMapping(value = "/payToOrderGoods.do", method = RequestMethod.POST)
    public ModelAndView payToOrderGoods(@RequestParam Map<String, String> receiverMap,
                                        HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = (String) request.getAttribute("viewName");
        ModelAndView mav = new ModelAndView(viewName);

        HttpSession session = request.getSession();
        MemberVO memberVO = (MemberVO) session.getAttribute("orderer");
        String memberId = memberVO.getMemberId();
        String ordererName = memberVO.getMemberName();
        String ordererHp = memberVO.getHp1() + "-" + memberVO.getHp2() + "-" + memberVO.getHp3();
        List<OrderVO> myOrderList = (List<OrderVO>) session.getAttribute("myOrderList");

        for (int i = 0; i < myOrderList.size(); i++) {
            OrderVO orderVO = (OrderVO) myOrderList.get(i);
            orderVO.setMemberId(memberId);
            orderVO.setOrdererName(ordererName);
            orderVO.setReceiverName(receiverMap.get("receiverName"));
            orderVO.setReceiverHp1(receiverMap.get("receiverHp1"));
            orderVO.setReceiverHp2(receiverMap.get("receiverHp2"));
            orderVO.setReceiverHp3(receiverMap.get("receiverHp3"));
            orderVO.setReceiverTel1(receiverMap.get("receiverTel1"));
            orderVO.setReceiverTel2(receiverMap.get("receiverTel2"));
            orderVO.setReceiverTel3(receiverMap.get("receiverTel3"));
            orderVO.setDeliveryAddress(receiverMap.get("deliveryAddress"));
            orderVO.setDeliveryMessage(receiverMap.get("deliveryMessage"));
            orderVO.setDeliveryMethod(receiverMap.get("deliveryMethod"));
            orderVO.setGiftWrapping(receiverMap.get("giftWrapping"));
            orderVO.setPayMethod(receiverMap.get("payMethod"));
            orderVO.setCardComName(receiverMap.get("cardComName"));
            orderVO.setCardPayMonth(receiverMap.get("cardPayMonth"));
            orderVO.setPayOrdererHpNum(receiverMap.get("payOrdererHpNum"));
            orderVO.setOrdererHp(ordererHp);
            myOrderList.set(i, orderVO); //각 orderVO에 주문자 정보를 세팅한 후 다시 myOrderList에 저장한다.
        }//end for

        orderService.addNewOrder(myOrderList);
        mav.addObject("myOrderInfo", receiverMap);//OrderVO로 주문결과 페이지에  주문자 정보를 표시한다.
        mav.addObject("myOrderList", myOrderList);
        return mav;
    }


    @RequestMapping(value = "/orderAllCartGoods.do", method = RequestMethod.POST)
    public ModelAndView orderAllCartGoods(@RequestParam("cartGoodsQty") String[] cartGoodsQty, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = (String) request.getAttribute("viewName");
        ModelAndView mav = new ModelAndView(viewName);
        HttpSession session = request.getSession();
        Map cartMap = (Map) session.getAttribute("cartMap");
        List myOrderList = new ArrayList<OrderVO>();

        List<GoodsVO> myGoodsList = (List<GoodsVO>) cartMap.get("myGoodsList");
        MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");

        for (int i = 0; i < cartGoodsQty.length; i++) {
            String[] cartGoods = cartGoodsQty[i].split(":");
            for (int j = 0; j < myGoodsList.size(); j++) {
                GoodsVO goodsVO = myGoodsList.get(i);
                int goodsId = goodsVO.getGoodsId();
                if (goodsId == Integer.parseInt(cartGoods[0])) {
                    OrderVO order = new OrderVO();
                    String goodsTitle = goodsVO.getGoodsTitle();
                    int goodsSalesPrice = goodsVO.getGoodsSalesPrice();
                    String goodsFileName = goodsVO.getGoodsFileName();
                    order.setGoodsId(goodsId);
                    order.setGoodsTitle(goodsTitle);
                    order.setGoodsSalesPrice(goodsSalesPrice);
                    order.setGoodsFileName(goodsFileName);
                    order.setOrderGoodsQty(Integer.parseInt(cartGoods[1]));
                    myOrderList.add(order);
                    break;

                }
            }
        }
        session.setAttribute("myOrderList", myOrderList);
        session.setAttribute("orderer", memberVO);
        return mav;
    }

}



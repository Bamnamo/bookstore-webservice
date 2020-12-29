package com.bookstore.webservice.cart.controller;

import com.bookstore.webservice.cart.service.CartService;
import com.bookstore.webservice.cart.vo.CartVO;
import com.bookstore.webservice.main.BaseController;
import com.bookstore.webservice.member.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller("cartController")
@RequestMapping(value = "/cart")
public class CartControllerImpl extends BaseController implements CartController {

    @Autowired
    private CartService cartService;
    @Autowired
    private CartVO cartVO;
    @Autowired
    private MemberVO memberVO;

    @Override
    @RequestMapping(value = "addGoodsInCart.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
    public @ResponseBody String addGoodsInCart(@RequestParam("goods_id") int goods_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        memberVO = (MemberVO) session.getAttribute("memberInfo");
        String member_id = memberVO.getMember_id();
        cartVO.setMember_id(member_id);
        cartVO.setGoods_id(goods_id);
        boolean isAreadyExisted = cartService.findCartGoods(cartVO);
        System.out.println("isAreadyExisted:" + isAreadyExisted);
        if (isAreadyExisted == true) {
            return "already_existed";
        } else {
            cartService.addGoodsInCart(cartVO);
            return "add_succes";
        }
    }
}

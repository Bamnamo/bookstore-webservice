package com.bookstore.webservice.cart;


import com.bookstore.webservice.main.BaseController;
import com.bookstore.webservice.member.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller("cartController")
@RequestMapping(value = "/cart")
public class CartController extends BaseController  {

    @Autowired
    private CartService cartService;
    @Autowired
    private CartVO cartVO;
    @Autowired
    private MemberVO memberVO;

    @RequestMapping(value = "/myCartList.do", method = RequestMethod.GET)
    public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = (String) request.getAttribute("viewName");
        ModelAndView mav = new ModelAndView(viewName);
        HttpSession session = request.getSession();
        MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
        String memberId = memberVO.getMemberId();
        cartVO.setMemberId(memberId);
        Map<String, List> cartMap = cartService.myCartList(cartVO);
        session.setAttribute("cartMap", cartMap);
        mav.addObject("cartMap", cartMap);
        return mav;
    }


    @RequestMapping(value = "/addGoodsInCart.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
    public @ResponseBody
    Object addGoodsInCart(@RequestParam("goodsId") int goodsId,
                          HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();

        Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
        String action = (String) session.getAttribute("action");

        if (isLogOn == null || isLogOn == false) {
            session.setAttribute("goodsId", goodsId);
            session.setAttribute("action", "/cart/addGoodsInCart.do");
            return new ModelAndView("redirect:/member/loginForm.do");
        }

        memberVO = (MemberVO) session.getAttribute("memberInfo");
        String memberId = memberVO.getMemberId();

        cartVO.setMemberId(memberId);
        //카트 등록전에 이미 등록된 제품인지 판별한다.
        cartVO.setGoodsId(goodsId);
        cartVO.setMemberId(memberId);
        boolean isAreadyExisted = cartService.findCartGoods(cartVO);
        System.out.println("isAreadyExisted:" + isAreadyExisted);
        if (isAreadyExisted == true) {
            return "already_existed";
        } else {
            cartService.addGoodsInCart(cartVO);
            return "add_success";
        }
    }

    @RequestMapping(value = "/modifyCartQty.do", method = RequestMethod.POST)
    public @ResponseBody String modifyCartQty(@RequestParam("goodsId") int goodsId,
                         @RequestParam("cartGoodsQty") int cartGoodsQty,
                         HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        memberVO = (MemberVO) session.getAttribute("memberInfo");
        String memberId = memberVO.getMemberId();
        cartVO.setGoodsId(goodsId);
        cartVO.setMemberId(memberId);
        cartVO.setCartGoodsQty(cartGoodsQty);
        boolean result = cartService.modifyCartQty(cartVO);

        if (result == true) {
            return "modify_success";
        } else {
            return "modify_failed";
        }

    }

    @RequestMapping(value = "/removeCartGoods.do", method = RequestMethod.POST)
    public ModelAndView removeCartGoods(@RequestParam("cartId") int cartId,
                                        HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView();
        cartService.removeCartGoods(cartId);
        mav.setViewName("redirect:/cart/myCartList.do");
        return mav;
    }
}
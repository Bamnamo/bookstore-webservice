package com.bookstore.webservice.order.controller;

import com.bookstore.webservice.order.vo.OrderVO;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public interface OrderController {
    @RequestMapping(value = "/orderEachGoods.do", method = RequestMethod.POST)
    ModelAndView orderEachGoods(@ModelAttribute("order") OrderVO _orderVO, HttpServletRequest request, HttpServletResponse response) throws Exception;

    @RequestMapping(value = "/payToOrderGoods.do", method = RequestMethod.POST)
    ModelAndView payToOrderGoods(@RequestParam Map<String, String> receiverMap, HttpServletRequest request, HttpServletResponse response) throws Exception;
}

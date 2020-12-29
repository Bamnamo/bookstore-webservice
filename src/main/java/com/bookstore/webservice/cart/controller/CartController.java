package com.bookstore.webservice.cart.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CartController {
    public @ResponseBody
    String addGoodsInCart(@RequestParam("goods_id") int goods_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
}

package com.bookstore.webservice.mypage.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface MyPageController {
    @RequestMapping(value = "myPageMain.do", method = RequestMethod.GET)
    ModelAndView myPageMain(@RequestParam(required = false, value = "message") String message, HttpServletRequest request, HttpServletResponse response) throws Exception;

    @RequestMapping(value = "/cancelMyOrder.do", method = RequestMethod.POST)
    ModelAndView cancelMyOrder(@RequestParam("order_id") String order_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
}

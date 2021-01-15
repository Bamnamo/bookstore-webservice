package com.bookstore.webservice.admin.member.controller;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public interface AdminMemberController {
    public ModelAndView adminGoodsMain(@RequestParam Map<String,String> dateMap, HttpServletRequest request, HttpServletResponse response) throws Exception;
}

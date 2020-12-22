package com.bookstore.webservice.member.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface MemberController {

    public ModelAndView listMembers(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
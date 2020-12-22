package com.bookstore.webservice.member.controller;

import com.bookstore.webservice.member.service.MemberService;
import com.bookstore.webservice.member.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller("memberController")
public class MemberControllerImpl implements MemberController {

    @Autowired
    private MemberService memberService;
    @Autowired
    private MemberVO memberVO;

    @Override
    @RequestMapping(value = "/member/listMembers.do", method = RequestMethod.GET)
    public ModelAndView listMembers(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = (String) request.getAttribute("viewName");
        List membersList = memberService.listMembers();
        ModelAndView mav = new ModelAndView(viewName);
        //ModelAndView mav = new ModelAndView("/member/listMembers");
        mav.addObject("membersList", membersList);
        return mav;
    }

}

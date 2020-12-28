package com.bookstore.webservice.member.controller;

import com.bookstore.webservice.main.BaseController;
import com.bookstore.webservice.member.service.MemberService;
import com.bookstore.webservice.member.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller("memberController")
@RequestMapping(value = "/member")
public class MemberControllerImpl extends BaseController implements MemberController {

    @Autowired
    private MemberService memberService;
    @Autowired
    private MemberVO memberVO;

    @Override
    @RequestMapping(value = "/login.do", method = RequestMethod.POST)
    public ModelAndView login(@RequestParam Map<String, String> loginMap,
                              HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView();
        memberVO = memberService.login(loginMap);
        if (memberVO != null && memberVO.getMember_id() != null) {
            HttpSession session = request.getSession();
            session = request.getSession();
            session.setAttribute("isLogOn", true);
            session.setAttribute("memberInfo", memberVO);

            String action = (String) session.getAttribute("action");
            if (action != null && action.equals("/order/orderEachGoods.do")) {
                mav.setViewName("forward:" + action);
            } else {
                mav.setViewName("redirect:/main/main.do");
            }


        } else {
            String message = "아이디나  비밀번호가 틀립니다. 다시 로그인해주세요";
            mav.addObject("message", message);
            mav.setViewName("/member/loginForm");
        }
        return mav;
    }

    @Override
    @RequestMapping(value = "/logout.do", method = RequestMethod.GET)
    public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView();
        HttpSession session = request.getSession();
        session.setAttribute("isLogOn", false);
        session.removeAttribute("memberInfo");
        mav.setViewName("redirect:/main/main.do");
        return mav;
    }

    @Override
    @RequestMapping(value = "/overlapped.do", method = RequestMethod.POST)
    public ResponseEntity overlapped(@RequestParam("id") String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ResponseEntity resEntity = null;
        String result = memberService.overlapped(id);
        resEntity = new ResponseEntity(result, HttpStatus.OK);
        return resEntity;
    }
}
package com.bookstore.webservice.mypage;

import com.bookstore.webservice.main.BaseController;
import com.bookstore.webservice.member.MemberVO;
import com.bookstore.webservice.order.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("myPageController")
@RequestMapping(value = "/mypage")
public class MyPageController extends BaseController{

    @Autowired
    private MyPageService myPageService;
    @Autowired
    private MemberVO memberVO;


    @RequestMapping(value = "myPageMain.do", method = RequestMethod.GET)
    public ModelAndView myPageMain(@RequestParam(required = false, value = "message") String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        session.setAttribute("side_menu", "my_page");
        String viewName = (String) request.getAttribute("viewName");
        ModelAndView mav = new ModelAndView(viewName);
        memberVO = (MemberVO) session.getAttribute("memberInfo");
        String memberId = memberVO.getMemberId();
        List<OrderVO> myOrderList = myPageService.listMyOrderGoods(memberId);

        mav.addObject("message", message);
        mav.addObject("myOrderList", myOrderList);
        return mav;
    }


    @RequestMapping(value = "/cancelMyOrder.do", method = RequestMethod.POST)
    public ModelAndView cancelMyOrder(@RequestParam("orderId") String orderId, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView();
        myPageService.cancelOrder(orderId);
        mav.addObject("message", "cancel_order");
        mav.setViewName("redirect:/mypage/myPageMain.do");
        return mav;
    }


    @RequestMapping(value = "/modifyMyInfo.do", method = RequestMethod.POST)
    public ResponseEntity modifyMyInfo(@RequestParam("attribute") String attribute, @RequestParam("value") String value, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, String> memberMap = new HashMap<String, String>();
        String val[] = null;
        HttpSession session = request.getSession();
        memberVO = (MemberVO) session.getAttribute("memberInfo");
        String memberId = memberVO.getMemberId();
        if (attribute.equals("memberBirth")) {
            val = value.split(",");
            memberMap.put("memberBirthY", val[0]);
            memberMap.put("memberBirthM", val[1]);
            memberMap.put("memberBirthD", val[2]);
            memberMap.put("memberBirthGn", val[3]);
        } else if (attribute.equals("tel")) {
            val = value.split(",");
            memberMap.put("tel1", val[0]);
            memberMap.put("tel2", val[1]);
            memberMap.put("tel3", val[2]);
        } else if (attribute.equals("hp")) {
            val = value.split(",");
            memberMap.put("hp1", val[0]);
            memberMap.put("hp2", val[1]);
            memberMap.put("hp3", val[2]);
            memberMap.put("smsstsYn", val[3]);
        } else if (attribute.equals("email")) {
            val = value.split(",");
            memberMap.put("email1", val[0]);
            memberMap.put("email2", val[1]);
            memberMap.put("emailstsYn", val[2]);
        } else if (attribute.equals("address")) {
            val = value.split(",");
            memberMap.put("zipCode", val[0]);
            memberMap.put("roadAddress", val[1]);
            memberMap.put("jibunAddress", val[2]);
            memberMap.put("namujiAddress", val[3]);
        } else {
            memberMap.put(attribute, value);
        }

        memberMap.put("memberId", memberId);

        //수정된 회원 정보를 세션에 저장한다.
        memberVO = (MemberVO) myPageService.modifyMyInfo(memberMap);
        session.removeAttribute("memberInfo");
        session.setAttribute("memberInfo", memberVO);

        String message = null;
        ResponseEntity resEntity = null;
        HttpHeaders responseHeaders = new HttpHeaders();
        message = "mod_success";
        resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
        return resEntity;
    }


    @RequestMapping(value = "/myDetailInfo.do",method = RequestMethod.GET)
    public ModelAndView myDetailInfo(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String viewName=(String)request.getAttribute("viewName");
        ModelAndView mav=new ModelAndView(viewName);
        return mav;
    }


    @RequestMapping(value = "/myOrderDetail.do",method = RequestMethod.GET)
    public ModelAndView myOrderDetail(@RequestParam("orderId") String orderId, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName=(String)request.getAttribute("viewName");
        ModelAndView mav=new ModelAndView(viewName);
        HttpSession session=request.getSession();
        MemberVO orderer=(MemberVO)session.getAttribute("memberInfo");

        List<OrderVO> myOrderList=myPageService.findMyOrderInfo(orderId);
        mav.addObject("orderer",orderer);
        mav.addObject("myOrderList",myOrderList);
        return mav;
    }


    @RequestMapping(value = "/listMyOrderHistory.do",method = RequestMethod.GET)
    public ModelAndView listMyOrderHistory(@RequestParam Map<String, String> dateMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName=(String)request.getAttribute("viewName");
        ModelAndView mav=new ModelAndView(viewName);
        HttpSession session=request.getSession();
        memberVO=(MemberVO)session.getAttribute("memberInfo");
        String memberId=memberVO.getMemberId();

        String fixedSearchPeriod=dateMap.get("fixedSearchPeriod");
        String beginDate=null,endDate=null;

        String [] tempDate=calcSearchPeriod(fixedSearchPeriod).split(",");
        beginDate=tempDate[0];
        endDate=tempDate[1];
        dateMap.put("beginDate",beginDate);
        dateMap.put("endDate",endDate);
        dateMap.put("memberId",memberId);
        List<OrderVO> myOrderHistList=myPageService.listMyOrderHistory(dateMap);

        String beginDate1[]=beginDate.split("-");
        String endDate1[]=endDate.split("-");
        mav.addObject("beginYear",beginDate1[0]);
        mav.addObject("beginMonth",beginDate1[1]);
        mav.addObject("beginDay",beginDate1[2]);
        mav.addObject("endYear",beginDate1[0]);
        mav.addObject("endMonth",beginDate1[1]);
        mav.addObject("endDay",beginDate1[2]);
        mav.addObject("myOrderHistList ",myOrderHistList);

        return mav;
    }


}

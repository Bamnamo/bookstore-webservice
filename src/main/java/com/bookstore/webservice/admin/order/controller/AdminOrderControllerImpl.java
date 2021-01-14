package com.bookstore.webservice.admin.order.controller;

import com.bookstore.webservice.admin.order.service.AdminOrderService;
import com.bookstore.webservice.main.BaseController;
import com.bookstore.webservice.order.vo.OrderVO;
import com.sun.org.apache.regexp.internal.RE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("adminOrderController")
@RequestMapping(value = "/orderAdmin")
public class AdminOrderControllerImpl extends BaseController implements AdminOrderController {

    @Autowired
    private AdminOrderService adminOrderService;


    @Override
    @RequestMapping(value = "/adminOrderMain.do", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView adminOrderMain(@RequestParam Map<String, String> dateMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = (String) request.getAttribute("viewName");
        ModelAndView mav = new ModelAndView(viewName);

        String fixedSearchPeriod = dateMap.get("fixedSearchPeriod");
        String section = dateMap.get("section");
        String pageNum = dateMap.get("pageNum");
        String beginDate = null, endDate = null;

        String[] tempDate = calcSearchPeriod(fixedSearchPeriod).split(",");
        beginDate = tempDate[0];
        endDate = tempDate[1];
        dateMap.put("beginDate", beginDate);
        dateMap.put("endDate", endDate);

        HashMap<String, Object> condMap = new HashMap<String, Object>();
        if (section == null) {
            section = "1";
        }
        condMap.put("section", section);
        if (pageNum == null) {
            pageNum = "1";
        }
        condMap.put("pageNum", pageNum);
        condMap.put("beginDate", beginDate);
        condMap.put("endDate", endDate);
        List<OrderVO> newOrderList = adminOrderService.listNewOrder(condMap);
        mav.addObject("newOrderList", newOrderList);

        String beginDate1[] = beginDate.split("-");
        String endDate2[] = endDate.split("-");
        mav.addObject("beginYear", beginDate1[0]);
        mav.addObject("beginMonth", beginDate1[1]);
        mav.addObject("beginDay", beginDate1[2]);
        mav.addObject("endYear", endDate2[0]);
        mav.addObject("endMonth", endDate2[1]);
        mav.addObject("endDay", endDate2[2]);

        mav.addObject("section", section);
        mav.addObject("pageNum", pageNum);
        return mav;
    }

    @Override
    @RequestMapping(value = "/orderDetail.do", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView orderDetail(int order_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = (String) request.getAttribute("viewName");
        ModelAndView mav = new ModelAndView(viewName);
        Map orderMap = adminOrderService.orderDetail(order_id);
        mav.addObject("orderMap", orderMap);
        return mav;
    }
}
package com.bookstore.webservice.admin.goods.controller;

import com.bookstore.webservice.admin.goods.service.AdminGoodsService;
import com.bookstore.webservice.goods.vo.GoodsVO;
import com.bookstore.webservice.main.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
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

@Controller("adminGoodsController")
@RequestMapping("/admin/goods")
public class AdminGoodsControllerImpl extends BaseController implements AdminGoodsController {

    private static final String CURR_IMAGE_REPO_PATH = "/Users/parkseongbeom/SpringBoot Project/BookStore-WebService/src/main/resources/static/file_repo";

    @Autowired
    private AdminGoodsService adminGoodsService;

    @Override
    @RequestMapping(value = "/adminGoodsMain", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap,
                                       HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = (String) request.getAttribute("viewName");
        ModelAndView mav = new ModelAndView(viewName);
        HttpSession session = request.getSession();
        session.setAttribute("side_menu", "admin_mode");

        String fixedSearchPeriod = dateMap.get("fixedSearchPeriod");
        String section = dateMap.get("section");
        String pageNum = dateMap.get("pageNum");
        String beginDate = null, endDate = null;

        String[] tempDate = calcSearchPeriod(fixedSearchPeriod).split(",");
        beginDate = tempDate[0];
        endDate = tempDate[1];
        dateMap.put("beginDate", beginDate);
        dateMap.put("endDate", endDate);

        Map<String, Object> condMap = new HashMap<String, Object>();
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
        List<GoodsVO> newGoodsList = adminGoodsService.listNewGoods(condMap);
        mav.addObject("newGoodsList", newGoodsList);

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
}

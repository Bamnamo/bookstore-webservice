package com.bookstore.webservice.goods.controller;

import com.bookstore.webservice.goods.service.GoodsService;
import com.bookstore.webservice.goods.vo.GoodsVO;
import com.bookstore.webservice.main.BaseController;


import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Controller("goodsController")
@RequestMapping(value = "/goods")
public class GoodsControllerImpl extends BaseController implements GoodsController {

    @Autowired
    private GoodsService goodsService;

    @Override
    @RequestMapping(value = "/goodsDetail.do", method = RequestMethod.GET)
    public ModelAndView goodsDetail(@RequestParam("goods_id") String goods_id,
                                    HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = (String) request.getAttribute("viewName");
        HttpSession session = request.getSession();
        Map goodsMap = goodsService.goodsDetail(goods_id);
        ModelAndView mav = new ModelAndView(viewName);
        mav.addObject("goodsMap", goodsMap);
        GoodsVO goodsVO = (GoodsVO) goodsMap.get("goodsVO");
        return mav;
    }

    @Override
    @RequestMapping(value = "/keywordSearch.do", method = RequestMethod.GET, produces = "application/text; charset=UTF-8")
    public String keywordSearch(@RequestParam("keyword") String keyword, HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("utf-8");
        if (keyword == null || keyword.equals(""))
            return null;

        keyword = keyword.toUpperCase();
        List keywordList = goodsService.keywordSearch(keyword);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("keyword", keywordList);
        String jsonInfo = jsonObject.toString();
        return jsonInfo;
    }

    @Override
    @RequestMapping(value = "/searchGoods.do", method = RequestMethod.GET)
    public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = (String) request.getAttribute("viewName");
        List goodsList = goodsService.searchGoods(searchWord);
        ModelAndView mav = new ModelAndView(viewName);
        mav.addObject("goodsList", goodsList);
        return mav;
    }

}

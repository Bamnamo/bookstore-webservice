package com.bookstore.webservice.goods.controller;

import com.bookstore.webservice.goods.service.GoodsService;
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
        // addGoodsInQuick(goods_id, goodsVO, session);
        return mav;
    }

    @Override
    public String keywordSearch(String keyword, HttpServletRequest request, HttpServletResponse response) throws Exception {
        return null;
    }

    @Override
    public ModelAndView searchGoods(String searchWord, HttpServletRequest request, HttpServletResponse response) throws Exception {
        return null;
    }


    /*
    private void addGoodsInQuick(String goods_id, GoodsVO goodsVO, HttpSession session) {
        boolean already_existed = false;
        List<GoodsVO> quickGoodsList; //최근 본 상품 저장 ArrayList
        quickGoodsList = (ArrayList<GoodsVO>) session.getAttribute("quickGoodsList");

        if (quickGoodsList != null) {
            if (quickGoodsList.size() < 4) { //미리본 상품 리스트에 상품개수가 세개 이하인 경우
                for (int i = 0; i < quickGoodsList.size(); i++) {
                    GoodsVO _goodsBean = (GoodsVO) quickGoodsList.get(i);
                    if (goods_id.equals(_goodsBean.getGoods_id())) {
                        already_existed = true;
                        break;
                    }
                }
                if (already_existed == false) {
                    quickGoodsList.add(goodsVO);
                }
            }

        } else {
            quickGoodsList = new ArrayList<GoodsVO>();
            quickGoodsList.add(goodsVO);

        }
        session.setAttribute("quickGoodsList", quickGoodsList);
        session.setAttribute("quickGoodsListNum", quickGoodsList.size());
    }

     */


}

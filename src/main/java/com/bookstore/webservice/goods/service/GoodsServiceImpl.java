package com.bookstore.webservice.goods.service;

import com.bookstore.webservice.goods.dao.GoodsDAO;
import com.bookstore.webservice.goods.vo.GoodsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("goodsService")
@Transactional(propagation = Propagation.REQUIRED)
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    private GoodsDAO goodsDAO;

    @Override
    public Map<String, List<GoodsVO>> listGoods() throws Exception {
        Map<String, List<GoodsVO>> goodsMap = new HashMap<String, List<GoodsVO>>();

        List<GoodsVO> goodsList = goodsDAO.selectGoodsList("bestseller");
        goodsMap.put("bestseller", goodsList);

        goodsList = goodsDAO.selectGoodsList("newbook");
        goodsMap.put("newbook", goodsList);

        goodsList = goodsDAO.selectGoodsList("steadyseller");
        goodsMap.put("steadyseller", goodsList);

        return goodsMap;
    }
}

package com.bookstore.webservice.admin.goods.service;

import com.bookstore.webservice.goods.vo.GoodsVO;

import java.util.List;
import java.util.Map;

public interface AdminGoodsService {
    public int addNewGoods(Map newGoodsMap) throws Exception;
    public List<GoodsVO> listNewGoods(Map condMap) throws Exception;
}

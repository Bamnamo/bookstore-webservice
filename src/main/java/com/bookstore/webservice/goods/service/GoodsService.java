package com.bookstore.webservice.goods.service;

import com.bookstore.webservice.goods.vo.GoodsVO;

import java.util.List;
import java.util.Map;

public interface GoodsService {
    Map<String, List<GoodsVO>> listGoods() throws Exception;
}

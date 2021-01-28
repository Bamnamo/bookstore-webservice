package com.bookstore.webservice.admin.goods.dao;

import com.bookstore.webservice.goods.vo.GoodsVO;
import org.springframework.dao.DataAccessException;

import java.util.List;
import java.util.Map;

public interface AdminGoodsDAO {
    List<GoodsVO> selectNewGoodsList(Map condMap) throws DataAccessException;
}

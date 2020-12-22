package com.bookstore.webservice.goods.dao;

import com.bookstore.webservice.goods.vo.GoodsVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository("goodsDAO")
public interface GoodsDAO {
    public List<GoodsVO> selectGoodsList(String goodsStatus) throws DataAccessException;
}

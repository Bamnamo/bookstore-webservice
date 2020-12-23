package com.bookstore.webservice.goods.dao;

import com.bookstore.webservice.goods.vo.GoodsVO;
import com.bookstore.webservice.goods.vo.ImageFileVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository("goodsDAO")
public interface GoodsDAO {
    public List<GoodsVO> selectGoodsList(String goodsStatus) throws DataAccessException;

    public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException;

    public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException;
}

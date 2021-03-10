package com.bookstore.webservice.goods;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;


@Repository("goodsDAO")
public class GoodsDAO {

    @Autowired
    private SqlSession sqlSession;

    public List<GoodsVO> selectGoodsList(String goodsStatus) throws DataAccessException {
        return (List<GoodsVO>) (ArrayList)sqlSession.selectList("mapper.goods.selectGoodsList",goodsStatus);
    }

    public List<String> selectKeywordSearch(String keyword) throws DataAccessException {
        return (List<String>) (ArrayList)sqlSession.selectList("mapper.goods.selectKeywordSearch",keyword);
    }

    public GoodsVO selectGoodsDetail(String goodsId) throws DataAccessException {
        return (GoodsVO)sqlSession.selectOne("mapper.goods.selectGoodsDetail",goodsId);
    }

    public List<ImageFileVO> selectGoodsDetailImage(String goodsId) throws DataAccessException {
        return (List<ImageFileVO>) (ArrayList)sqlSession.selectList("mapper.goods.selectGoodsDetail",goodsId);
    }

    public ArrayList<GoodsVO> selectGoodsBySearchWord(String searchWord) throws DataAccessException {
        return (ArrayList<GoodsVO>) (ArrayList)sqlSession.selectList("mapper.goods.selectGoodsBySearchWord",searchWord);
    }
}

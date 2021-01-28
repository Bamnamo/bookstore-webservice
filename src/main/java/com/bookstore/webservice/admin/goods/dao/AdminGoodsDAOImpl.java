package com.bookstore.webservice.admin.goods.dao;

import com.bookstore.webservice.goods.vo.GoodsVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository("adminGoodsDAO")
public class AdminGoodsDAOImpl implements AdminGoodsDAO{

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<GoodsVO> selectNewGoodsList(Map condMap) throws DataAccessException {
        ArrayList<GoodsVO> goodsList=(ArrayList)sqlSession.selectList("mapper.admin.goods.selectNewGoodsList",condMap);
        return goodsList;
    }
}

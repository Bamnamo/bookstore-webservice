package com.bookstore.webservice.admin.goods;

import com.bookstore.webservice.goods.GoodsVO;
import com.bookstore.webservice.goods.ImageFileVO;
import com.bookstore.webservice.order.OrderVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository("adminGoodsDAO")
public class AdminGoodsDAO  {

    @Autowired
    private SqlSession sqlSession;


    public int insertNewGoods(Map newGoodsMap) throws DataAccessException {
        sqlSession.insert("mapper.admin.goods.insertNewGoods", newGoodsMap);
        return Integer.parseInt((String) newGoodsMap.get("goodsId"));
    }

    public void insertGoodsImageFile(List fileList) throws DataAccessException {
        for (int i = 0; i < fileList.size(); i++) {
            ImageFileVO imageFileVO = (ImageFileVO) fileList.get(i);
            sqlSession.insert("mapper.admin.goods.insertGoodsImageFile", imageFileVO);
        }
    }


    public List<GoodsVO> selectNewGoodsList(Map condMap) throws DataAccessException {
        return (ArrayList<GoodsVO>) (ArrayList) sqlSession.selectList("mapper.admin.goods.selectNewGoodsList", condMap);
    }


    public GoodsVO selectGoodsDetail(int goodsId) throws DataAccessException {
        return (GoodsVO) sqlSession.selectOne("mapper.admin.goods.selectGoodsDetail", goodsId);
    }


    public List selectGoodsImageFileList(int goodsId) throws DataAccessException {
        return (List) sqlSession.selectList("mapper.admin.goods.selectGoodsImageFileList", goodsId);
    }


    public void updateGoodsInfo(Map goodsMap) throws DataAccessException {
        sqlSession.update("mapper.admin.goods.updateGoodsInfo", goodsMap);
    }


    public void deleteGoodsImage(int imageId) throws DataAccessException {
        sqlSession.delete("mapper.admin.goods.deleteGoodsImage", imageId);
    }


    public void deleteGoodsImage(List fileList) throws DataAccessException {
        int imageId;
        for (int i = 0; i < fileList.size(); i++) {
            ImageFileVO bean = (ImageFileVO) fileList.get(i);
            imageId = bean.getImageId();
            sqlSession.delete("mapper.admin.goods.deleteGoodsImage", imageId);
        }
    }


    public List<OrderVO> selectOrderGoodsList(Map condMap) throws DataAccessException {
        return (List<OrderVO>) (ArrayList) sqlSession.selectList("mapper.admin.selectOrderGoodsList", condMap);
    }


    public void updateOrderGoods(Map orderMap) throws DataAccessException {
        sqlSession.update("mapper.admin.goods.updateOrderGoods", orderMap);

    }


    public void updateGoodsImage(List<ImageFileVO> imageFileList) throws DataAccessException {

        for (int i = 0; i < imageFileList.size(); i++) {
            ImageFileVO imageFileVO = imageFileList.get(i);
            sqlSession.update("mapper.admin.goods.updateGoodsImage", imageFileVO);
        }

    }


}

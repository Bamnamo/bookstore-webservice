package com.bookstore.webservice.admin.goods.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository("adminGoodsDAO")
public interface AdminGoodsDAO {
    public int insertNewGoods(Map newGoodsMap) throws DataAccessException;
    public void insertGoodsImageFile(List fileList) throws DataAccessException;
}

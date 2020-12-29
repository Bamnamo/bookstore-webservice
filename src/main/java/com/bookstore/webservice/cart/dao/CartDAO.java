package com.bookstore.webservice.cart.dao;

import com.bookstore.webservice.cart.vo.CartVO;
import com.bookstore.webservice.goods.vo.GoodsVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;


public interface CartDAO {
    public boolean selectCountInCart(CartVO cartVO) throws DataAccessException;

    public void insertGoodsInCart(CartVO cartVO) throws DataAccessException;

    public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException;

    public List<GoodsVO> selectGoodsList(List<CartVO> myCartList) throws DataAccessException;
}

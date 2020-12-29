package com.bookstore.webservice.cart.dao;

import com.bookstore.webservice.cart.vo.CartVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("cartDAO")
public interface CartDAO {
    public boolean selectCountInCart(CartVO cartVO) throws DataAccessException;

    public void insertGoodsInCart(CartVO cartVO) throws DataAccessException;
}

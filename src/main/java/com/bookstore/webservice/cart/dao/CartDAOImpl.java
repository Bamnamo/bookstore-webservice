package com.bookstore.webservice.cart.dao;

import com.bookstore.webservice.cart.vo.CartVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository("cartDAO")
public class CartDAOImpl implements CartDAO {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public boolean selectCountInCart(CartVO cartVO) throws DataAccessException {
        String result = sqlSession.selectOne("mapper.cart.selectCountInCart", cartVO);
        return Boolean.parseBoolean(result);
    }

    @Override
    public void insertGoodsInCart(CartVO cartVO) throws DataAccessException {
        int cart_id = selectMaxCartId();
        cartVO.setCart_id(cart_id);
        sqlSession.insert("mapper.cart.insertGoodsInCart", cartVO);
    }

    private int selectMaxCartId() throws DataAccessException {
        int cart_id = sqlSession.selectOne("mapper.cart.selectMaxCartId");
        return cart_id;
    }
}

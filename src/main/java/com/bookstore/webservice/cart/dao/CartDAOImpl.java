package com.bookstore.webservice.cart.dao;

import com.bookstore.webservice.cart.vo.CartVO;
import com.bookstore.webservice.goods.vo.GoodsVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;

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

    @Override
    public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException {
        List<CartVO> cartList = (List) sqlSession.selectList("mapper.cart.selectCartList", cartVO);
        return cartList;
    }

    @Override
    public List<GoodsVO> selectGoodsList(List<CartVO> myCartList) throws DataAccessException {
        List<GoodsVO> myGoodsList = sqlSession.selectList("mapper.cart.selectGoodsList", myCartList);
        return myGoodsList;
    }

    private int selectMaxCartId() throws DataAccessException {
        int cart_id = sqlSession.selectOne("mapper.cart.selectMaxCartId");
        return cart_id;
    }
}

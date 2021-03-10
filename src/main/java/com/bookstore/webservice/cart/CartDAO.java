package com.bookstore.webservice.cart;

import com.bookstore.webservice.goods.GoodsVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("cartDAO")
public class CartDAO  {

    @Autowired
    private SqlSession sqlSession;

    public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException {
        return (List<CartVO>) (List) sqlSession.selectList("mapper.cart.selectCartList", cartVO);
    }

    public List<GoodsVO> selectGoodsList(List<CartVO> cartList) throws DataAccessException {

        List<GoodsVO> myGoodsList;
        myGoodsList = sqlSession.selectList("mapper.cart.selectGoodsList", cartList);
        return myGoodsList;
    }

    public boolean selectCountInCart(CartVO cartVO) throws DataAccessException {
        String result = sqlSession.selectOne("mapper.cart.selectCountInCart", cartVO);
        return Boolean.parseBoolean(result);
    }

    public void insertGoodsInCart(CartVO cartVO) throws DataAccessException {
        int cartId = selectMaxCartId();
        cartVO.setCartId(cartId);
        sqlSession.insert("mapper.cart.insertGoodsInCart", cartVO);
    }

    public void updateCartGoodsQty(CartVO cartVO) throws DataAccessException {
        sqlSession.insert("mapper.cart.updateCartGoodsQty", cartVO);
    }

    public void deleteCartGoods(int cartId) throws DataAccessException {
        sqlSession.delete("mapper.cart.deleteCartGoods", cartId);
    }

    private int selectMaxCartId() throws DataAccessException {
        return sqlSession.selectOne("mapper.cart.selectMaxCartId");
    }

}
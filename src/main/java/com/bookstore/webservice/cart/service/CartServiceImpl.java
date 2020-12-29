package com.bookstore.webservice.cart.service;

import com.bookstore.webservice.cart.dao.CartDAO;
import com.bookstore.webservice.cart.vo.CartVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("cartService")
@Transactional(propagation = Propagation.REQUIRED)
public class CartServiceImpl implements CartService {

    @Autowired
    private CartDAO cartDAO;

    @Override
    public boolean findCartGoods(CartVO cartVO) throws Exception {
        return cartDAO.selectCountInCart(cartVO);
    }

    @Override
    public void addGoodsInCart(CartVO cartVO) throws Exception {
          cartDAO.insertGoodsInCart(cartVO);
    }
}

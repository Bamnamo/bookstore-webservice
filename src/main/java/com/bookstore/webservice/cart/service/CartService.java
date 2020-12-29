package com.bookstore.webservice.cart.service;

import com.bookstore.webservice.cart.vo.CartVO;

public interface CartService {
    public boolean findCartGoods(CartVO cartVO) throws Exception;

    public void addGoodsInCart(CartVO cartVO) throws Exception;
}

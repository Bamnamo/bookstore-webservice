package com.bookstore.webservice.cart.service;

import com.bookstore.webservice.cart.vo.CartVO;

import java.util.List;
import java.util.Map;

public interface CartService {
    public Map<String ,List> myCartList(CartVO cartVO) throws Exception;
    public boolean findCartGoods(CartVO cartVO) throws Exception;
    public void addGoodsInCart(CartVO cartVO) throws Exception;
    public boolean modifyCartQty(CartVO cartVO) throws Exception;
    public void removeCartGoods(int cart_id) throws Exception;
}

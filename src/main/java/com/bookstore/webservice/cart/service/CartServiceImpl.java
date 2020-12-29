package com.bookstore.webservice.cart.service;

import com.bookstore.webservice.cart.dao.CartDAO;
import com.bookstore.webservice.cart.vo.CartVO;
import com.bookstore.webservice.goods.vo.GoodsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Override
    public Map<String, List> myCartList(CartVO cartVO) throws Exception {
        Map<String, List> cartMap = new HashMap<String, List>();
        List<CartVO> myCartList = cartDAO.selectCartList(cartVO);
        if (myCartList.size() == 0) {
            return null;
        }
        List<GoodsVO> myGoodsList = cartDAO.selectGoodsList(myCartList);
        cartMap.put("myCartList",myCartList);
        cartMap.put("myGoodsList",myGoodsList);
        return cartMap;
    }
}

package com.bookstore.webservice.cart;


import com.bookstore.webservice.goods.GoodsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("cartService")
@Transactional(propagation=Propagation.REQUIRED)
public class CartService {
    @Autowired
    private CartDAO cartDAO;

    public Map<String ,List> myCartList(CartVO cartVO) throws Exception{
        Map<String,List> cartMap=new HashMap<String,List>();
        List<CartVO> myCartList=cartDAO.selectCartList(cartVO);
        if(myCartList.size()==0){ //카트에 저장된 상품이없는 경우
            return null;
        }
        List<GoodsVO> myGoodsList=cartDAO.selectGoodsList(myCartList);
        cartMap.put("myCartList", myCartList);
        cartMap.put("myGoodsList",myGoodsList);
        return cartMap;
    }

    public boolean findCartGoods(CartVO cartVO) throws Exception{
        return cartDAO.selectCountInCart(cartVO);

    }
    public void addGoodsInCart(CartVO cartVO) throws Exception{
        cartDAO.insertGoodsInCart(cartVO);
    }

    public boolean modifyCartQty(CartVO cartVO) throws Exception{
        boolean result=true;
        cartDAO.updateCartGoodsQty(cartVO);
        return result;
    }
    public void removeCartGoods(int cartId) throws Exception{
        cartDAO.deleteCartGoods(cartId);
    }

}

package com.bookstore.webservice.cart;

import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@Component("cartVO")
public class CartVO {
    private int cartId;
    private int goodsId;
    private String memberId;
    private int cartGoodsQty;
    private String creDate;
}

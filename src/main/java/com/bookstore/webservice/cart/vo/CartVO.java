package com.bookstore.webservice.cart.vo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@Component("cartVO")
public class CartVO {
    private int cart_id;
    private int goods_id;
    private String member_id;
    private int cart_goods_qty;
    private String creDate;
}

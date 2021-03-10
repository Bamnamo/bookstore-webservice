package com.bookstore.webservice.order;

import lombok.Data;
import org.springframework.stereotype.Component;

@Data
@Component("orderVO")
public class OrderVO {
    private int orderSeqNum;
    private String memberId;
    private int orderId;
    private int goodsId;
    private String goodsTitle;
    private int goodsPrice;
    private int goodsSalesPrice;
    private int totalGoodsPrice;
    private int cartGoodsQty;
    private int orderGoodsQty;
    private String ordererName;
    private String receiverName;
    private String receiverHp1;
    private String receiverHp2;
    private String receiverHp3;
    private String receiverTel1;
    private String receiverTel2;
    private String receiverTel3;
    private String deliveryAddress;
    private String deliveryMessage;
    private String deliveryMethod;
    private String giftWrapping;
    private String payMethod;
    private String cardComName;
    private String cardPayMonth;
    private String payOrdererHpNum;
    private String payOrderTime;
    private String deliveryState;
    private String finalTotalPrice;
    private int goodsQty;
    private String goodsFileName;
    private String ordererHp;
}

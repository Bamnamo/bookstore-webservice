package com.bookstore.webservice.goods;

import lombok.Data;

@Data
public class ImageFileVO {
    private int goodsId;
    private int imageId;
    private String fileName;
    private String fileType;
    private String regId;


    public ImageFileVO() {
        super();
    }

}

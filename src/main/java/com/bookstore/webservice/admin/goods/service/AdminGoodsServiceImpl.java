package com.bookstore.webservice.admin.goods.service;


import com.bookstore.webservice.admin.goods.dao.AdminGoodsDAO;
import com.bookstore.webservice.goods.vo.GoodsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


import java.util.List;
import java.util.Map;

@Service("adminGoodsService")
@Transactional(propagation = Propagation.REQUIRED)
public class AdminGoodsServiceImpl implements AdminGoodsService {

    @Autowired
    private AdminGoodsDAO adminGoodsDAO;

    @Override
    public List<GoodsVO> listNewGoods(Map condMap) throws Exception{
        return adminGoodsDAO.selectNewGoodsList(condMap);
    }

}

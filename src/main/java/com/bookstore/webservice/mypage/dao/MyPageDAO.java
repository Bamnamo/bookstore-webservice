package com.bookstore.webservice.mypage.dao;

import com.bookstore.webservice.order.vo.OrderVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository("myPageDAO")
public interface MyPageDAO {
    public List<OrderVO> selectMyOrderGoodsList(String member_id) throws DataAccessException;
    public void updateMyOrderCancel(String order_id) throws DataAccessException;
}

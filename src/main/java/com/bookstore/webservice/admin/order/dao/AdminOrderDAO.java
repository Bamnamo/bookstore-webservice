package com.bookstore.webservice.admin.order.dao;

import com.bookstore.webservice.member.vo.MemberVO;
import com.bookstore.webservice.order.vo.OrderVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
@Repository("adminOderDAO")
public interface AdminOrderDAO {
    public ArrayList<OrderVO> selectNewOrderList(Map condMap) throws DataAccessException;
    public void  updateDeliveryState(Map deliveryMap) throws DataAccessException;
    public ArrayList<OrderVO> selectOrderDetail(int order_id) throws DataAccessException;
    public MemberVO selectOrderer(String member_id) throws DataAccessException;
}

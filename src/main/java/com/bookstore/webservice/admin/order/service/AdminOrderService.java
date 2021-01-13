package com.bookstore.webservice.admin.order.service;

import com.bookstore.webservice.order.vo.OrderVO;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface AdminOrderService {

    public List<OrderVO> listNewOrder(HashMap condMap) throws Exception;
    public Map orderDetail(int order_id) throws Exception;
}

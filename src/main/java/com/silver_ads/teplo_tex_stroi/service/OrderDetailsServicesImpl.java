package com.silver_ads.teplo_tex_stroi.service;

import com.silver_ads.teplo_tex_stroi.entity.Order;
import com.silver_ads.teplo_tex_stroi.entity.OrderDetails;
import com.silver_ads.teplo_tex_stroi.enums.PaymentStatus;
import com.silver_ads.teplo_tex_stroi.enums.order.OrderStatus;
import com.silver_ads.teplo_tex_stroi.repository.OrderDetailsRepository;
import com.silver_ads.teplo_tex_stroi.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderDetailsServicesImpl implements OrderDetailsServices {

    @Autowired
    OrderDetailsRepository repository;

    @Override
    public OrderDetails createOrderDetails(OrderDetails orderDetailsExternal) {
        OrderDetails orderDetails = new OrderDetails();
        orderDetails.copy(orderDetailsExternal);
        return orderDetails;
    }

    @Override
    public OrderDetails save(OrderDetails orderDetails){
        repository.save(orderDetails);
        return orderDetails;
    }

}

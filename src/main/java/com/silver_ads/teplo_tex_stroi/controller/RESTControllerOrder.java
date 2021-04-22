package com.silver_ads.teplo_tex_stroi.controller;

import com.silver_ads.teplo_tex_stroi.entity.Order;
import com.silver_ads.teplo_tex_stroi.entity.OrderDetails;
import com.silver_ads.teplo_tex_stroi.exception_handling.NoSuchOrderDetailsException;
import com.silver_ads.teplo_tex_stroi.service.OrderServicesImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class RESTControllerOrder {
    @Autowired
    OrderServicesImpl orderServices;

    @GetMapping("/order")
    public List<Order> getAllOrder() {
        List<Order> orders = orderServices.getOrdersWithHidePhoneAndUserNull();
        if (orders == null) {
            throw new NoSuchOrderDetailsException("Not found any orders");
        }
        return orders;
    }

    @PostMapping("/order")
    public Order createOrder(@RequestBody OrderDetails orderDetailsExternal) {
        if (orderDetailsExternal.getCustomerName() == null || orderDetailsExternal.getPhoneNumber() == null || orderDetailsExternal.getCity() == null) {
            throw new NoSuchOrderDetailsException("Field: customerName = " + orderDetailsExternal.getCustomerName()
                    + ";  phoneNumber = " + orderDetailsExternal.getPhoneNumber()
                    + ";  city = " + orderDetailsExternal.getCity() + "  must not be null");
        }

        Order order = orderServices.createOrder(orderDetailsExternal);

        return order;
    }

}

package com.silverwork.teplo_tex_stroi.controller;

import com.silverwork.teplo_tex_stroi.entity.Order;
import com.silverwork.teplo_tex_stroi.exception_handling.NoSuchOrderException;
import com.silverwork.teplo_tex_stroi.service.OrderServices;
import com.silverwork.teplo_tex_stroi.service.OrderServicesImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api")
public class RESTControllerOrder {
    @Autowired
    OrderServicesImpl services;

    @GetMapping("/order")
    public List<Order> getAllOrder() {
        List<Order> orders = services.getOrdersWithHidePhoneAndUserNull();
        if (orders == null) {
            throw new NoSuchOrderException("Not found any orders");
        }
        return orders;
    }

    @PostMapping("/order")
    public Order saveOrder(@RequestBody Order order) {
        if (order.getCustomerName() == null || order.getPhoneNumber() == null || order.getCity() == null) {
            throw new NoSuchOrderException("Field: customerName = " + order.getCustomerName()
                    + ";  phoneNumber = " + order.getPhoneNumber()
                    + ";  city = " + order.getCity() + "  must not be null");
        }
        services.saveOrder(order);
        return order;
    }

}

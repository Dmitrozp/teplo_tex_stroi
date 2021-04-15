package com.silverwork.teplo_tex_stroi.controller;

import com.silverwork.teplo_tex_stroi.entity.Order;
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
        return orders;
    }

    @PostMapping("/order")
    public Order saveOrder(@RequestBody Order order) {
        services.saveOrder(order);
        return order;
    }

}

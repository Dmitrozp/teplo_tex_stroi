package com.silver_ads.teplo_tex_stroi.controller;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.silver_ads.teplo_tex_stroi.entity.Order;
import com.silver_ads.teplo_tex_stroi.entity.OrderDetails;
import com.silver_ads.teplo_tex_stroi.entity.Report;
import com.silver_ads.teplo_tex_stroi.enums.order.OrderStatus;
import com.silver_ads.teplo_tex_stroi.exception_handling.NoSuchOrderDetailsException;
import com.silver_ads.teplo_tex_stroi.service.OrderDetailsServices;
import com.silver_ads.teplo_tex_stroi.service.OrderServicesImpl;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api")
public class RESTController {
    @Autowired
    OrderServicesImpl orderServices;
    @Autowired
    OrderDetailsServices orderDetailsServices;

    @GetMapping("/order")
    public List<Order> getAllOrder() {
        List<Order> orders = orderServices.getOrdersWithHidePhoneAndStatusOrder(OrderStatus.NEW_ORDER_VERIFIED.name());
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

        List<Order> orders = orderServices.findOrdersWhereWithEqualsPhoneNumber(orderDetailsExternal.getPhoneNumber());
        if (orders!= null){
            Report report = new Report();
            report.setDate(LocalDateTime.now());
            report.setDescription("ПОВТОРНАЯ ЗАЯВКА!!!" + "" +
                    "\nИмя клиента  " + orderDetailsExternal.getCustomerName() +
                    "\nГород  " + orderDetailsExternal.getCity() +
                    "\nАдрес  " + orderDetailsExternal.getAddress() +
                    "\nПлощадь  " + orderDetailsExternal.getSquareArea() +
                    "\nКоличество комнат  " + orderDetailsExternal.getCountRooms() +
                    "\nПримечание  " + orderDetailsExternal.getNotes());
            orders.get(0).addReport(report);
            orders.get(0).setStatusOrder(OrderStatus.IN_WORK.name());

            orderServices.save(orders.get(0));

            return orders.get(0);
        }
        Order order = orderServices.createNewOrderFromFormSite(orderDetailsExternal);

        return order;
    }

}

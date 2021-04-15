package com.silverwork.teplo_tex_stroi.service;

import com.silverwork.teplo_tex_stroi.entity.Order;
import com.silverwork.teplo_tex_stroi.entity.Report;
import com.silverwork.teplo_tex_stroi.entity.User;

import java.util.List;

public interface OrderServices {

    public List<Order> getAllOrder();
    public void saveOrder(Order order);
    public Order getOrderById(long id);
    public List<Order> getOrdersWithHidePhoneAndUserNull();
    public List<Order> getOrdersByUser(User user);
    public Report addReport(Report report);
}

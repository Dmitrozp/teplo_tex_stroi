package com.silverwork.teplo_tex_stroi.service;

import com.silverwork.teplo_tex_stroi.entity.Order;
import com.silverwork.teplo_tex_stroi.entity.OrderDetails;
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

    public List<Order> getOrdersWithHidePhoneAndStatusOrder(String orderStatus);

    public Order addOrderToUser(Order order, User user);

    public Order createOrder(OrderDetails orderDetailsExternal);

}

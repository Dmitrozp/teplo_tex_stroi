package com.silver_ads.teplo_tex_stroi.service;

import com.silver_ads.teplo_tex_stroi.entity.Order;
import com.silver_ads.teplo_tex_stroi.entity.OrderDetails;
import com.silver_ads.teplo_tex_stroi.entity.Report;
import com.silver_ads.teplo_tex_stroi.entity.User;

import java.util.List;

public interface OrderServices {

    List<Order> getAllOrder();

    void save(Order order);

    Order getOrderById(long id);

    List<Order> getOrdersWithHidePhoneAndUserNull();

    List<Order> getOrdersByUser(User user);

    Report addReport(Report report);

    List<Order> getOrdersWithHidePhoneAndStatusOrder(String orderStatus);

    Order addOrderToUser(Order order, User user);

    Order createNewOrderFromFormSite(OrderDetails orderDetailsExternal);

    List<Order> getOrdersForManagerByStatusAndManagerLoginName(String orderStatus, User user);

    void saveCompletedOrder(Order orderWithChanges, User user);

    void saveCanceledOrder(Report report, String loginName);

    void saveOrderInArchive(Long orderId, String loginName);

}

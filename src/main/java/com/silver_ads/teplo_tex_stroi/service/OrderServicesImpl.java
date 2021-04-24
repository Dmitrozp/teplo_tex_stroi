package com.silver_ads.teplo_tex_stroi.service;

import com.silver_ads.teplo_tex_stroi.entity.OrderDetails;
import com.silver_ads.teplo_tex_stroi.entity.Report;
import com.silver_ads.teplo_tex_stroi.entity.User;
import com.silver_ads.teplo_tex_stroi.enums.OrderStatus;
import com.silver_ads.teplo_tex_stroi.enums.PaymentStatus;
import com.silver_ads.teplo_tex_stroi.repository.OrderRepository;
import com.silver_ads.teplo_tex_stroi.entity.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class OrderServicesImpl implements OrderServices {

    @Autowired
    private OrderRepository orderRepository;

    @Override
    public List<Order> getAllOrder() {
        List<Order> orders = orderRepository.findAll();
        return orders;
    }

    @Override
    public List<Order> getOrdersForManagerByStatusAndManagerLoginName(String orderStatus, User user) {
        List<Order> orders = orderRepository.findOrderByStatusOrderAndUserExecutor(orderStatus, user);
        return orders;
    }

    @Override
    public List<Order> getOrdersWithHidePhoneAndUserNull() {
        List<Order> orders = orderRepository.findOrderByUserExecutorIsNull();
        orders.stream().map(order -> {
                    order.getOrderDetails().setPhoneNumber(hidingPhoneNumber(order.getOrderDetails().getPhoneNumber()));
                    return order;
                }
        ).collect(Collectors.toList());
        return orders;
    }


    @Override
    public void saveCompletedOrder(Order orderWithChanges, User user){
        Order order = getOrderById(orderWithChanges.getId());
        order.setSquareArea(orderWithChanges.getSquareArea());
        order.setSumOfPaymentCustomer(orderWithChanges.getSumOfPaymentCustomer());
        order.setStatusPayment(PaymentStatus.PROCESSING.name());
        Report report = new Report();
        report.setOrder(order);
        report.setDate(LocalDateTime.now());
        report.setDescription("ВЫПОЛНЕНA! исполнителем логин " + user.getLoginName()
                + " Имя: " + user.getName() + " Заявка ID: " + order.getId()
                + " Площадь утепления: " + order.getSquareArea()
                + " Сумма оплаты клиентом: " + order.getSumOfPaymentCustomer());
        report.setUserExecutor(user);
        order.addReport(report);
        orderRepository.save(order);
    }

    @Override
    public List<Order> getOrdersWithHidePhoneAndStatusOrder(String orderStatus) {
        List<Order> orders = orderRepository.findOrdersByStatusOrder(orderStatus);
        orders.stream().map(order -> {
                    order.getOrderDetails().setPhoneNumber(hidingPhoneNumber(order.getOrderDetails().getPhoneNumber()));
                    return order;
                }
        ).collect(Collectors.toList());
        return orders;
    }

    @Override
    public List<Order> getOrdersByUser(User user) {
        return orderRepository.findOrderByUserExecutor(user);
    }

    @Override
    public Report addReport(Report report) {

        return null;
    }

    @Override
    public void saveOrder(Order order) {
        if (order.getDate() == null) {
            order.setDate(LocalDateTime.now());
        }
        orderRepository.save(order);
    }

    @Override
    public Order getOrderById(long id) {
        Order order = null;
        Optional<Order> optional = orderRepository.findById(id);
        if (optional.isPresent()) {
            order = optional.get();
            return order;
        }
        return order;
    }

    @Override
    public Order addOrderToUser(Order order, User user) {
        if (order.getStatusOrder().equals(OrderStatus.NEW_ORDER_VERIFIED.name())) {
            order.setUserExecutor(user);
            order.setStatusOrder(OrderStatus.IN_WORK.name());
            orderRepository.save(order);
        }
        return order;
    }

    @Override
    public Order createOrder(OrderDetails orderDetailsExternal) {
        OrderDetails orderDetails = new OrderDetails();
        orderDetails.copy(orderDetailsExternal);
        Order order = new Order();
        order.setUserCreator("admin"); //TODO создатель заявки, заявки приходит с сайта
        order.setDate(LocalDateTime.now());
        order.setStatusOrder(OrderStatus.NEW_ORDER_NOT_VERIFIED.name());
        order.setStatusPayment(PaymentStatus.UNKNOWN.name());
        order.setOrderDetails(orderDetails);
        orderRepository.save(order);
        return order;
    }

    private String hidingPhoneNumber(String phoneNumber) {
        final int firstSumbolOfPhoneNumber = 0;
        final int countHideNumber = 2;
        final String hideSymbols = "***";
        String resultPhoneNumber;
        String phoneNumberWithoutLastNumbers = phoneNumber.substring(firstSumbolOfPhoneNumber, phoneNumber.length() - countHideNumber);
        resultPhoneNumber = phoneNumberWithoutLastNumbers + hideSymbols;
        return resultPhoneNumber;
    }

}

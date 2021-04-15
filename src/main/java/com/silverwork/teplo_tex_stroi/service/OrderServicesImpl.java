package com.silverwork.teplo_tex_stroi.service;

import com.silverwork.teplo_tex_stroi.entity.User;
import com.silverwork.teplo_tex_stroi.repository.OrderRepository;
import com.silverwork.teplo_tex_stroi.entity.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    public List<Order> getOrdersWithHidePhoneAndUserNull() {
        List<Order> orders = orderRepository.findOrderByUserNull();
        orders.stream().map(order -> {
                    order.setPhoneNumber(hidingPhoneNumber(order.getPhoneNumber()));
                    return order;
                }
        ).collect(Collectors.toList());
        System.out.println(orders);
        return orders;
    }

    @Override
    public List<Order> getOrdersByUser(User user) {
        return orderRepository.findOrderByUser(user);
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

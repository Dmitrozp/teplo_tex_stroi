package com.silver_ads.teplo_tex_stroi.service;

import com.silver_ads.teplo_tex_stroi.entity.OrderDetails;
import com.silver_ads.teplo_tex_stroi.entity.Report;
import com.silver_ads.teplo_tex_stroi.entity.User;
import com.silver_ads.teplo_tex_stroi.enums.order.OrderSource;
import com.silver_ads.teplo_tex_stroi.enums.order.OrderStatus;
import com.silver_ads.teplo_tex_stroi.enums.PaymentStatus;
import com.silver_ads.teplo_tex_stroi.enums.order.OrderType;
import com.silver_ads.teplo_tex_stroi.repository.OrderDetailsRepository;
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

    @Autowired
    private OrderDetailsRepository orderDetailsRepository;

    @Autowired
    UserServicesImpl userServices;

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
        order.getOrderDetails().setSquareAreaFromReport(orderWithChanges.getOrderDetails().getSquareAreaFromReport());
        order.getOrderDetails().setSumOfPaymentCustomer(orderWithChanges.getOrderDetails().getSumOfPaymentCustomer());
        order.setStatusPayment(PaymentStatus.PROCESSING.name());
        order.setStatusOrder(OrderStatus.COMPLETED.name());
        Report report = new Report();
        report.setOrder(order);
        report.setDate(LocalDateTime.now());
        report.setDescription("ВЫПОЛНЕНA! исполнителем логин " + user.getLoginName()
                + " Имя: " + user.getUserDetails().getName() + " Заявка ID: " + order.getId()
                + " Площадь утепления: " + order.getOrderDetails().getSquareAreaFromReport()
                + " Сумма оплаты клиентом: " + order.getOrderDetails().getSumOfPaymentCustomer());
        report.setUserCreator(user);
        order.addReport(report);
        order.setUserExecutor(userServices.findManagerWhoCanAcceptOrder());
        orderRepository.save(order);
    }

    @Override
    public void saveCanceledOrder(Report report, String loginName){
        final int NEW_CANCELED_ORDER = 1;
        Order order = getOrderById(report.getOrder().getId());
        User user = userServices.getUserByLoginName(loginName);

        report.setDescription("ОТМЕНА! исполнителем логин " + user.getLoginName()
                + " Имя: " + user.getUserDetails().getName() + " Заявка ID: " + order.getId()
                + " Причина отмены : " + report.getDescription());
        report.setDate(LocalDateTime.now());
        report.setUserCreator(user);
        order.addReport(report);
        order.setStatusOrder(OrderStatus.CANCELED.name());
        order.setUserExecutor(userServices.findManagerWhoCanAcceptOrder());
        orderRepository.save(order);
        int currentCanceledCountOrders = user.getUserDetails().getCurrentCanceledCountOrders();
        user.getUserDetails().setCurrentCanceledCountOrders(currentCanceledCountOrders + NEW_CANCELED_ORDER );
        userServices.save(user);
    }

    @Override
    public List<Order> getOrdersWithHidePhoneAndStatusOrder(String orderStatus) {
        List<Order> orders = orderRepository.findOrdersByStatusOrder(orderStatus);
        orders.stream().map(order -> {
            try {
            if (order.getOrderDetails().getPhoneNumber() != null) {
                order.getOrderDetails().setPhoneNumber(hidingPhoneNumber(order.getOrderDetails().getPhoneNumber()));
            } else
                throw new Exception("Order not include phone number");
            } catch (Exception e) {
                e.printStackTrace();
            }
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
    public void save(Order order) {
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
        orderDetails.setOrder(order);
        orderRepository.save(order);
        return order;
    }

    @Override
    public Order createNewOrderFromFormSite(OrderDetails orderDetailsExternal) {
        Order order = new Order();
        order.setUserCreator("admin"); //TODO создатель заявки, заявки приходит с сайта
        order.setDate(LocalDateTime.now());
        order.setStatusOrder(OrderStatus.NEW_ORDER_NOT_VERIFIED.name());
        order.setStatusPayment(PaymentStatus.UNKNOWN.name());
        order.setOrderDetails(orderDetailsExternal);
        order.getOrderDetails().setTypeOrder(OrderType.PROSCHET_NA_UTEPLENIE.name());
        order.getOrderDetails().setSourceOrder(OrderSource.FORM_SITE_SILVER_ADS_COM.name());
        order.setUserExecutor(userServices.findManagerWhoCanAcceptOrder());
        save(order);
        order.setUserExecutor(null);
        return order;
    }

    private String hidingPhoneNumber(String phoneNumber) {
        final int firstSumbolOfPhoneNumber = 0;
        final int countHideNumber = 2;
        final String hideSymbols = "***";
        String resultPhoneNumber = phoneNumber;

        if(phoneNumber.length() >= 3) {
            String phoneNumberWithoutLastNumbers = phoneNumber.substring(firstSumbolOfPhoneNumber, phoneNumber.length() - countHideNumber);
            resultPhoneNumber = phoneNumberWithoutLastNumbers + hideSymbols;
        }
        return resultPhoneNumber;
    }



}

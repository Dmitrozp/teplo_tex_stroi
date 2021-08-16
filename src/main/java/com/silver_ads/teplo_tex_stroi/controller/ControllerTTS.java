package com.silver_ads.teplo_tex_stroi.controller;

import com.silver_ads.teplo_tex_stroi.entity.Order;
import com.silver_ads.teplo_tex_stroi.entity.Report;
import com.silver_ads.teplo_tex_stroi.entity.User;
import com.silver_ads.teplo_tex_stroi.enums.order.OrderStatus;
import com.silver_ads.teplo_tex_stroi.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import java.io.File;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;

@Controller
public class ControllerTTS implements ErrorController {
    @Autowired
    OrderServicesImpl orderServices;
    @Autowired
    UserServicesImpl userServices;
    @Autowired
    ReportServicesImpl reportServices;

    @RequestMapping("/")
    public String showAllOrdersWithHidePhoneNumber(Model model) throws Exception {
        List<Order> orders = orderServices.getOrdersWithHidePhoneAndStatusOrder(OrderStatus.NEW_ORDER_VERIFIED.name());
        model.addAttribute("orders", orders);
        return "home-page";
    }
    
    @RequestMapping("/order")
    public String showAllOrders(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        List<Order> orders = orderServices.getOrdersWithHidePhoneAndStatusOrder(OrderStatus.NEW_ORDER_VERIFIED.name());
        List<Order> ordersNotVerified = new ArrayList<>();
        if(user.getRoles().stream().filter(role -> role.getName().equals("ROLE_SUPER_USER")).count() == 1L)
        {
            ordersNotVerified = orderServices.getOrdersWithHidePhoneAndStatusOrder(OrderStatus.NEW_ORDER_NOT_VERIFIED.name());
        }
        model.addAttribute("orders", orders);
        model.addAttribute("ordersNotVerified", ordersNotVerified);
        model.addAttribute("user", user);
        model.addAttribute("countOrders", user.getOrders().size());

        return "all-orders";
    }

    @RequestMapping("/order/createNewOrder")
    public String createNewOrder(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        Order order = new Order();
        order.setUserCreator(user.getLoginName());

        model.addAttribute("order", order);

        return "create-edit-order";
    }

    @RequestMapping("/order/addOrder")
    public String addOrder(@RequestParam("orderId") int orderId, Principal principal) throws Exception {
        String userLogin = principal.getName();
        Order order = orderServices.getOrderById(orderId);
        User user = userServices.getUserByLoginName(userLogin);
        if (user.getOrders().size() < user.getUserDetails().getMaxCountOrders() &&
        Math.abs(user.getUserDetails().getBalance()) < Math.abs(user.getUserDetails().getMaxCrediteBalance())) {
            orderServices.addOrderToUser(order, user);
            user.getUserDetails().setCurrentCountOrders(user.getOrders().size());
            userServices.save(user);
        } else {
            throw new Exception("<br>Либо у Вас есть задолжность по оплате за заявки! Которая привышает <b>"
                    + user.getUserDetails().getMaxCrediteBalance() + "</b>, <br> погасите пожалуйста полностью задолжность и сможете продолжить брать заявки в работу" +
                    "<br> <br>Либо у Вас в работе заявок больше чем установленный лимит <b>" + user.getUserDetails().getMaxCountOrders() + "грн"+
                    "</b><br> <br> Либо у Вас количество отменненных заявок больше лимита <b>" + user.getUserDetails().getMaxCountCanceledOrders() +
                    "</b><br> <br> Если это ошибочно, обратитесь к администратору на вайбер, или по тел. <b>097 870 63 63</b>");
        }
        return "redirect:/order";
    }

    @RequestMapping("/manager")
    public String showOrdersForManagersPanel(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        List<Order> newOrders =
                orderServices.getOrdersForManagerByStatus(OrderStatus.NEW_ORDER_NOT_VERIFIED.name());
        List<Order> completedOrders =
                orderServices.getOrdersForManagerByStatusAndManagerLoginName(OrderStatus.COMPLETED.name(), user);
        List<Order> canceledOrders =
                orderServices.getOrdersForManagerByStatusAndManagerLoginName(OrderStatus.CANCELED.name(), user);

        List<Order> ordersInWork = orderServices.getOrdersForManagerByStatus(OrderStatus.IN_WORK.name());


        int countNewOrders = newOrders.size();
        model.addAttribute("newOrders", newOrders);
        model.addAttribute("countNewOrders", countNewOrders);

        int countOrdersInWork = ordersInWork.size();
        model.addAttribute("ordersInWork", ordersInWork);
        model.addAttribute("countOrdersInWork", countOrdersInWork);

        int countCompletedOrders = completedOrders.size();
        model.addAttribute("completedOrders", completedOrders);
        model.addAttribute("countCompletedOrders", countCompletedOrders);

        int countCanceledOrders = canceledOrders.size();
        model.addAttribute("canceledOrders", canceledOrders);
        model.addAttribute("countCanceledOrders", countCanceledOrders);
        model.addAttribute("user", user);

        return "manager-panel";
    }

    @RequestMapping("/manager/sendOrderInWork")
    public String sendOrderInWork(@RequestParam("orderId") int orderId, Principal principal, Model model) {
        Order order = orderServices.getOrderById(orderId);
        order.setStatusOrder(OrderStatus.NEW_ORDER_VERIFIED.name());
        orderServices.save(order);

        return "redirect:/manager";
    }



    @RequestMapping(value = "/.well-known/pki-validation/669424F355907B4335118701E4DE92E0.txt", method = RequestMethod.GET)
    @ResponseBody
    public FileSystemResource getFile() {
        return new FileSystemResource(new File("src/main/resources/669424F355907B4335118701E4DE92E0.txt"));
    }


    @RequestMapping("/order/createReport")
    public String createReport(@RequestParam("orderId") Long orderId, Principal principal, Model model) {
        Report report = new Report();
        report.setOrder(new Order());
        report.getOrder().setId(orderId);
        model.addAttribute("report", report);

        return "create-report";
    }

    @RequestMapping("/order/saveReport")
    public String saveReport(@ModelAttribute("report") Report report, Principal principal) throws Exception {
        final int MIN_COUNT_OF_SUMBOLS_IN_DESCRIPTION = 10;

        if (report.getDescription().length() < MIN_COUNT_OF_SUMBOLS_IN_DESCRIPTION) {throw new Exception("В отчете должно быть минимум 10 символов и отчет не может быть пустым");}
        User user = userServices.getUserByLoginName(principal.getName());
        Order order = orderServices.getOrderById(report.getOrder().getId());
        Report reportResult = new Report();
        reportResult.setOrder(order);
        reportResult.setDescription(report.getDescription());
        report.setUserCreator(user);
        reportServices.saveReport(reportResult);

        AtomicReference<String> url = new AtomicReference<>();
        user.getRoles().stream().forEach(role -> {
            if(role.getName().equals("ROLE_USER") || role.getName().equals("ROLE_SUPER_USER")){
                url.set("/profile");
                return ;
            } else {if (role.getName() == "ROLE_MANAGER" || role.getName() == "ROLE_SUPER_MANAGER"
                    || role.getName() == "ROLE_ADMIN" ){
                url.set("/manager");}
            }
        });
        return "redirect:" + url;
    }

    @RequestMapping("/order/createCanceledOrder")
    public String createCanceledOrder(@RequestParam("orderId") int orderId, Principal principal, Model model) throws Exception {
        Order order = orderServices.getOrderById(orderId);
        User user = userServices.getUserByLoginName(principal.getName());

        if (user.getUserDetails().getCurrentCanceledCountOrders() < user.getUserDetails().getMaxCountCanceledOrders()) {
            Report report = new Report();
            report.setUserCreator(user);
            report.setOrder(order);

            model.addAttribute("order", order);
            model.addAttribute("user", user);
            model.addAttribute("report", report);
        } else {
            throw new Exception("У Вас привышен лимин отменненных заявок! Max = " + user.getUserDetails().getMaxCountCanceledOrders()
                    + "в данный момент " + user.getUserDetails().getCurrentCanceledCountOrders() + "/n"
                    + "За увеличение лимита, обратитесь в поддержку, по тел. 097 870 63 63");
        }

        return "canceled-order";
    }

    @RequestMapping("/order/saveCanceledOrder")
    public String saveCanceledOrder(@ModelAttribute("report") Report report, Principal principal) throws Exception {
        final int MIN_SYMBOLS_OF_DESCRIPTION = 10;
        if(report.getDescription().length() < MIN_SYMBOLS_OF_DESCRIPTION ){
            throw new Exception("Описание не может быть пустым, или меньше "+MIN_SYMBOLS_OF_DESCRIPTION+" букв. Добавьте пожалуйста описание к отменненной заявке ");
        }

        orderServices.saveCanceledOrder(report,principal.getName());

        return "redirect:/profile";
    }


    @RequestMapping("/order/edit")
    public String editOrder(@RequestParam("orderId") int orderId, Principal principal, Model model){
        Order order = orderServices.getOrderById(orderId);

        model.addAttribute("order", order);

        return "create-edit-order";
    }

    @RequestMapping("/order/saveEditedOrder")
    public String saveEditedOrder(@ModelAttribute("order") Order editedOrder, Principal principal, Model model){
        Order order = orderServices.getOrderById(editedOrder.getId());

        if(editedOrder.getOrderDetails().getCustomerName() != "" ){
            String name = editedOrder.getOrderDetails().getCustomerName();
            order.getOrderDetails().setCustomerName(name);
        }

        if(editedOrder.getOrderDetails().getAddress() != "" ){
            String address = editedOrder.getOrderDetails().getAddress();
            order.getOrderDetails().setAddress(address);
        }

        if(editedOrder.getOrderDetails().getPhoneNumber() != "" ){
            String phoneNumber = editedOrder.getOrderDetails().getPhoneNumber();
            order.getOrderDetails().setPhoneNumber(phoneNumber);
        }

        if(editedOrder.getOrderDetails().getCity() != "" ){
            String city = editedOrder.getOrderDetails().getCity();
            order.getOrderDetails().setCity(city);
        }

        if(editedOrder.getOrderDetails().getCountRooms() != "" ){
            String countRooms = editedOrder.getOrderDetails().getCountRooms();
            order.getOrderDetails().setCountRooms(countRooms);
        }
        if(editedOrder.getOrderDetails().getCity() != "" ){
            String city = editedOrder.getOrderDetails().getCity();
            order.getOrderDetails().setCity(city);
        }

        orderServices.save(order);

        return "redirect:/manager";
    }

    @RequestMapping("/order/saveOrderInArchive")
    public String saveOrderInArchive(@RequestParam("orderId") Long orderId, Principal principal) {

        orderServices.saveOrderInArchive(orderId,principal.getName());

        return "redirect:/manager";
    }

    @RequestMapping("/order/createCompletedOrder")
    public String createCompletedOrder(@RequestParam("orderId") int orderId, Principal principal, Model model) {
        Order order = orderServices.getOrderById(orderId);
        User user = userServices.getUserByLoginName(principal.getName());

        model.addAttribute("order", order);
        model.addAttribute("user", user);

        return "completed-order";
    }

    @RequestMapping("/order/saveCompletedOrder")
    public String saveCompletedOrder(@ModelAttribute("order") Order orderWithChanges, Principal principal) throws Exception {
        if (orderWithChanges.getOrderDetails().getSumOfPaymentCustomer() == null || orderWithChanges.getOrderDetails().getSquareAreaFromReport() == null
        || orderWithChanges.getOrderDetails().getSumOfPaymentCustomer() < 0){
            throw new Exception("Поля \"площадь утепления\" и \"сумма оплаты клиентом\" не могут быть пустые или отрицательными! Пожалуйста введите данные. ");
        }
        User user = userServices.getUserByLoginName(principal.getName());
        user.getUserDetails().setBalance(user.getUserDetails().getBalance() - orderWithChanges.getOrderDetails().getSumOfPaymentCustomer()/10);
        userServices.save(user);
        orderServices.saveCompletedOrder(orderWithChanges, user);

        return "redirect:/profile";
    }

    @RequestMapping("/profile")
    public String profileUser(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        List<Order> orders = user.getOrders();
        List<Order> ordersInWork = orders.stream().filter(order -> order.getStatusOrder().equals(OrderStatus.IN_WORK.name())).collect(Collectors.toList());
        int countOrdersInWork = ordersInWork.size();

        if (countOrdersInWork != user.getUserDetails().getCurrentCountOrders() ){
            user.getUserDetails().setCurrentCountOrders(countOrdersInWork);
            userServices.save(user);
        }

        model.addAttribute("ordersInWork", ordersInWork);
        model.addAttribute("countOrdersInWork", countOrdersInWork);
        model.addAttribute("user", user);

        return "user-panel";
    }



    @RequestMapping("/order/archive")
    public String archive(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        List<Order> orders = user.getOrders();
        List<Order> ordersInArchive = orders.stream().filter(order -> !order.getStatusOrder().equals(OrderStatus.IN_WORK.name())).collect(Collectors.toList());
        int countOrdersInArchive = ordersInArchive.size();

        model.addAttribute("ordersInArchive", ordersInArchive);
        model.addAttribute("countOrdersInArchive", countOrdersInArchive);
        model.addAttribute("user", user);

        return "archive";
    }

    @RequestMapping("/order/{id}")
    public java.lang.String showOrderById(@PathVariable long id, Model model) {
        List<Order> orders = new ArrayList<>();
        orders.add(orderServices.getOrderById(id));
        model.addAttribute("allOrders", orders);
        return "all-orders";
    }

    @Override
    public String getErrorPath() {
        return "error";
    }

    @ExceptionHandler()
    @RequestMapping("/error")
    public String error(Exception e, Model model){

        model.addAttribute("message", e.getMessage());

        return "error";
    }

}

package com.silver_ads.teplo_tex_stroi.controller;

import com.silver_ads.teplo_tex_stroi.entity.News;
import com.silver_ads.teplo_tex_stroi.entity.Order;
import com.silver_ads.teplo_tex_stroi.entity.Report;
import com.silver_ads.teplo_tex_stroi.entity.User;
import com.silver_ads.teplo_tex_stroi.enums.order.OrderStatus;
import com.silver_ads.teplo_tex_stroi.repository.NewsRepository;
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
import java.util.Optional;
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
    @Autowired
    NewsServicesImpl newsServices;

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
        List<News> news = newsServices.findFirstLastNews();
        model.addAttribute("news", news);
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
        if (order.getStatusOrder() != OrderStatus.NEW_ORDER_VERIFIED.name() || order.getStatusOrder() != OrderStatus.NEW_ORDER_NOT_VERIFIED.name()){
            throw new Exception("Данная заявка не может быть взята в работу" +
                    "</b><br> <br> Если это ошибочно, обратитесь к администратору на вайбер, или по тел. <b>097 870 63 63</b>");
        } else {
            if (Math.abs(user.getUserDetails().getBalance()) > Math.abs(user.getUserDetails().getMaxCrediteBalance())){
                throw new Exception("<br>У Вас есть задолжность по оплате за заявки! Которая привышает <b>"
                        + user.getUserDetails().getMaxCrediteBalance() + "грн" + "</b>, <br> погасите пожалуйста полностью задолжность и сможете продолжить брать заявки в работу" +
                        "</b><br> <br> Если это ошибочно, обратитесь к администратору на вайбер, или по тел. <b>097 870 63 63</b>");
            } else {
                if (user.getOrders().size() > user.getUserDetails().getMaxCountOrders()) {
                    throw new Exception("<br> <br>У Вас в работе заявок больше чем установленный лимит <b>" + user.getUserDetails().getMaxCountOrders() +
                            "</b><br> <br> Если это ошибочно, обратитесь к администратору на вайбер, или по тел. <b>097 870 63 63</b>");
                } else {
                    orderServices.addOrderToUser(order, user);
                    user.getUserDetails().setCurrentCountOrders(user.getOrders().size());
                    userServices.save(user);
                }
            }
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
        List<Order> ordersExecuting = orderServices.getOrdersForManagerByStatus(OrderStatus.EXECUTING.name());

        List<News> news = newsServices.findFirstLastNews();
        model.addAttribute("news", news);

        int countNewOrders = newOrders.size();
        model.addAttribute("newOrders", newOrders);
        model.addAttribute("countNewOrders", countNewOrders);

        int countOrdersInWork = ordersInWork.size();
        model.addAttribute("ordersInWork", ordersInWork);
        model.addAttribute("countOrdersInWork", countOrdersInWork);

        int countOrdersExecuting = ordersExecuting.size();
        model.addAttribute("ordersExecuting", ordersExecuting);
        model.addAttribute("countOrdersExecuting", countOrdersExecuting);

        int countCompletedOrders = completedOrders.size();
        model.addAttribute("completedOrders", completedOrders);
        model.addAttribute("countCompletedOrders", countCompletedOrders);

        int countCanceledOrders = canceledOrders.size();
        model.addAttribute("canceledOrders", canceledOrders);
        model.addAttribute("countCanceledOrders", countCanceledOrders);
        model.addAttribute("user", user);

        return "manager-panel";
    }

    @RequestMapping("/news")
    public String showNews(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());

        List<News> news = newsServices.showAllNews();
        model.addAttribute("news", news);
        model.addAttribute("user", user);

        return "news";
    }

    @RequestMapping("/newsItem")
    public String showNews(@RequestParam("newsId") Long newsId, Model model, Principal principal) throws Exception {
        User user = userServices.getUserByLoginName(principal.getName());

        Optional<News> newsOne = newsServices.findNewsById(newsId);
        if(newsOne.isEmpty()){
            throw new Exception("Такой новости не найдено");
        }
        List<News> news = new ArrayList<>();
        news.add(newsOne.get());
        model.addAttribute("news", news);
        model.addAttribute("user", user);

        return "news";
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
    public String createReport(@RequestParam("orderId") Long orderId, Principal principal, Model model) throws Exception {
        User user = userServices.getUserByLoginName(principal.getName());
        if(!orderServices.isMyOrder(user,orderId)){
            throw new Exception("Это не Ваша заявка, введите правильный ID заявки");
        }
        Report report = new Report();
        report.setOrder(new Order());
        report.getOrder().setId(orderId);
        model.addAttribute("report", report);
        model.addAttribute("user", user);

        List<News> news = newsServices.findFirstLastNews();
        model.addAttribute("news", news);

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
        reportResult.setDescription(user.getUserDetails().getName() + " "+ user.getUserDetails().getLastName()
                + ": " + report.getDescription());
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
    public String createCanceledOrder(@RequestParam("orderId") Long orderId, Principal principal, Model model) throws Exception {
        Order order = orderServices.getOrderById(orderId);
        User user = userServices.getUserByLoginName(principal.getName());
        if(!orderServices.isMyOrder(user,orderId)){
            throw new Exception("Это не Ваша заявка, введите правильный ID заявки");
        }
        if (user.getUserDetails().getCurrentCanceledCountOrders() < user.getUserDetails().getMaxCountCanceledOrders()) {
            Report report = new Report();
            report.setUserCreator(user);
            report.setOrder(order);

            model.addAttribute("order", order);
            model.addAttribute("user", user);
            model.addAttribute("report", report);
            model.addAttribute("user", user);

            List<News> news = newsServices.findFirstLastNews();
            model.addAttribute("news", news);
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

    @RequestMapping("/order/createExecutingOrder")
    public String createExecutingOrder(@RequestParam("orderId") Long orderId, Principal principal, Model model) throws Exception {
        User user = userServices.getUserByLoginName(principal.getName());
        if(!orderServices.isMyOrder(user,orderId)){
            throw new Exception("Это не Ваша заявка, введите правильный ID заявки");
        }
        Order order = orderServices.getOrderById(orderId);
        model.addAttribute("order", order);
        model.addAttribute("user", user);

        List<News> news = newsServices.findFirstLastNews();
        model.addAttribute("news", news);

        return "executing-order";
    }

    @RequestMapping("/order/saveExecutingOrder")
    public String saveExecutingOrder(@ModelAttribute("order") Order orderWithChanges, Principal principal) throws Exception {
        if (orderWithChanges.getId() == null || orderWithChanges.getNameContract() == null
        || orderWithChanges.getSummOfContract() <= 0 || orderWithChanges.getDateFinished() == null ||
                orderWithChanges.getOrderDetails().getSquareAreaFromReport() == null ||
                orderWithChanges.getOrderDetails().getAddress() == null){
            throw new Exception("Поля \"№ договора\" и \"адрес\" и \"сумма оплаты по договору\" и \"дата окончания работ\" и \"площадь утепления\" не могут быть пустые или отрицательными! Пожалуйста введите данные. ");
        }

        Order order = orderServices.getOrderById(orderWithChanges.getId());
        order.setNameContract(orderWithChanges.getNameContract());
        order.setSummOfContract(orderWithChanges.getSummOfContract());
        order.setDateFinished(orderWithChanges.getDateFinished());
        order.getOrderDetails().setSquareAreaFromReport(orderWithChanges.getOrderDetails().getSquareAreaFromReport());
        order.getOrderDetails().setAddress(orderWithChanges.getOrderDetails().getAddress());
        order.setStatusOrder(OrderStatus.EXECUTING.name());

        User user = userServices.getUserByLoginName(principal.getName());
        user.getUserDetails().setBalance(user.getUserDetails().getBalance()
                - Math.round(Math.abs(orderWithChanges.getSummOfContract())/user.getUserDetails().getRoyalty()));

        userServices.save(user);
        orderServices.save(order);

        return "redirect:/profile";
    }

    @RequestMapping("/order/createCompletedOrder")
    public String createCompletedOrder(@RequestParam("orderId") Long orderId, Principal principal, Model model) throws Exception {
        User user = userServices.getUserByLoginName(principal.getName());
        if(!orderServices.isMyOrder(user,orderId)){
            throw new Exception("Это не Ваша заявка, введите правильный ID заявки");
        }
        Order order = orderServices.getOrderById(orderId);
        model.addAttribute("order", order);
        model.addAttribute("user", user);

        List<News> news = newsServices.findFirstLastNews();
        model.addAttribute("news", news);

        return "completed-order";
    }

    @RequestMapping("/order/saveCompletedOrder")
    public String saveCompletedOrder(@ModelAttribute("order") Order orderWithChanges, Principal principal) throws Exception {
        User user = userServices.getUserByLoginName(principal.getName());

        orderServices.saveCompletedOrder(orderWithChanges, user);

        return "redirect:/profile";
    }

    @RequestMapping("/profile")
    public String profileUser(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        List<Order> orders = user.getOrders();
        List<Order> ordersInWork = orders.stream().filter(order -> order.getStatusOrder().equals(OrderStatus.IN_WORK.name())).collect(Collectors.toList());
        int countOrdersInWork = ordersInWork.size();
        List<Order> ordersExecuting = orders.stream().filter(order -> order.getStatusOrder().equals(OrderStatus.EXECUTING.name())).collect(Collectors.toList());
        int countOrdersExecuting = ordersExecuting.size();

        if (countOrdersInWork != user.getUserDetails().getCurrentCountOrders() ){
            user.getUserDetails().setCurrentCountOrders(countOrdersInWork);
            userServices.save(user);
        }
        List<News> news = newsServices.findFirstLastNews();
        model.addAttribute("news", news);

        model.addAttribute("ordersInWork", ordersInWork);
        model.addAttribute("countOrdersInWork", countOrdersInWork);
        model.addAttribute("ordersExecuting", ordersExecuting);
        model.addAttribute("countOrdersExecuting", countOrdersExecuting);
        model.addAttribute("user", user);

        return "user-panel";
    }

    @RequestMapping("/order/archive")
    public String archive(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        List<Order> orders = user.getOrders();
        List<Order> ordersCanceledInArchive = orders.stream().filter(order -> order.getStatusOrder().equals(OrderStatus.IN_ARCHIVE.name())).collect(Collectors.toList());
        int countCanceledInArchive = ordersCanceledInArchive.size();
        List<Order> ordersCompletedInArchive = orders.stream().filter(order -> order.getStatusOrder().equals(OrderStatus.COMPLETED.name())).collect(Collectors.toList());
        int countCompletedInArchive = ordersCompletedInArchive.size();

        List<News> news = newsServices.findFirstLastNews();
        model.addAttribute("news", news);
        model.addAttribute("ordersCanceledInArchive", ordersCanceledInArchive);
        model.addAttribute("countCanceledInArchive", countCanceledInArchive);
        model.addAttribute("ordersCompletedInArchive", ordersCompletedInArchive);
        model.addAttribute("countCompletedInArchive", countCompletedInArchive);

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

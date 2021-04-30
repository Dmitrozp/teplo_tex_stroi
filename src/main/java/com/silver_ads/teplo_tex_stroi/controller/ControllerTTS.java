package com.silver_ads.teplo_tex_stroi.controller;

import com.silver_ads.teplo_tex_stroi.entity.Order;
import com.silver_ads.teplo_tex_stroi.entity.Report;
import com.silver_ads.teplo_tex_stroi.entity.User;
import com.silver_ads.teplo_tex_stroi.enums.order.OrderStatus;
import com.silver_ads.teplo_tex_stroi.service.OrderServices;
import com.silver_ads.teplo_tex_stroi.service.ReportServices;
import com.silver_ads.teplo_tex_stroi.service.UserServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import java.io.File;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ControllerTTS {
    @Autowired
    OrderServices orderServices;
    @Autowired
    UserServices userServices;
    @Autowired
    ReportServices reportServices;

    @RequestMapping("/")
    public String showAllOrdersWithHidePhoneNumber(Model model) {
        List<Order> orders = orderServices.getOrdersWithHidePhoneAndStatusOrder(OrderStatus.NEW_ORDER_VERIFIED.name());
        model.addAttribute("orders", orders);
        return "home-page";
    }

    @RequestMapping("/order")
    public String showAllOrders(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        List<Order> orders = orderServices.getOrdersWithHidePhoneAndStatusOrder(OrderStatus.NEW_ORDER_VERIFIED.name());
        model.addAttribute("orders", orders);
        model.addAttribute("user", user);
        model.addAttribute("countOrders", user.getOrders().size());

        return "all-orders";
    }

    @RequestMapping("/order/addOrder")
    public String addOrder(@RequestParam("orderId") int orderId, Principal principal) throws Exception {
        String userLogin = principal.getName();
        Order order = orderServices.getOrderById(orderId);
        User user = userServices.getUserByLoginName(userLogin);
        if (user.getOrders().size() < user.getUserDetails().getMaxCountOrders()) {
            orderServices.addOrderToUser(order, user);
            user.getUserDetails().setCurrentCountOrders(user.getOrders().size());
            userServices.save(user);
        } else {
            throw new Exception("You have many orders or many canceled orders");
        }
        return "redirect:/order";
    }

    @RequestMapping("/manager")
    public String showOrdersForManagersPanel(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        List<Order> newOrders =
                orderServices.getOrdersForManagerByStatusAndManagerLoginName(OrderStatus.NEW_ORDER_NOT_VERIFIED.name(), user);
        List<Order> completedOrders =
                orderServices.getOrdersForManagerByStatusAndManagerLoginName(OrderStatus.COMPLETED.name(), user);
        List<Order> canceledOrders =
                orderServices.getOrdersForManagerByStatusAndManagerLoginName(OrderStatus.CANCELED.name(), user);

        int countNewOrders = newOrders.size();
        model.addAttribute("newOrders", newOrders);
        model.addAttribute("countNewOrders", countNewOrders);

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
        User user = userServices.getUserByLoginName(principal.getName());

        return "redirect:/manager";
    }

    @RequestMapping(value = "/.well-known/pki-validation/D0AA6539E8AB5A083BFE76B3F53DD589.txt", method = RequestMethod.GET)
    @ResponseBody
    public FileSystemResource getFile() {
        return new FileSystemResource(new File("src/main/resources/D0AA6539E8AB5A083BFE76B3F53DD589.txt"));
    }


    @RequestMapping("/order/createReport")
    public String createReport(@RequestParam("orderId") int orderId, Principal principal, Model model) {
        Order order = orderServices.getOrderById(orderId);
        User user = userServices.getUserByLoginName(principal.getName());
        Report report = new Report();
        report.setOrder(order);
        report.setUserCreator(user);
        reportServices.saveReport(report);

        model.addAttribute("report", report);

        return "create-report";
    }

    @RequestMapping("/order/saveReport")
    public java.lang.String saveReport(@ModelAttribute("report") Report report, Principal principal) {
        Report reportResult = reportServices.findReportById(report.getId());
        reportResult.setDescription(report.getDescription());
        reportServices.saveReport(reportResult);

        return "redirect:/profile";
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
            throw new Exception("You have many canceled orders");
        }

        return "canceled-order";
    }

    @RequestMapping("/order/saveCanceledOrder")
    public String saveCanceledOrder(@ModelAttribute("report") Report report, Principal principal) {
        orderServices.saveCanceledOrder(report,principal.getName());

        return "redirect:/profile";
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
    public String saveCompletedOrder(@ModelAttribute("order") Order orderWithChanges, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        orderServices.saveCompletedOrder(orderWithChanges, user);

        return "redirect:/profile";
    }

    @RequestMapping("/profile")
    public java.lang.String profileUser(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        List<Order> orders = user.getOrders();
        int countOrders = orders.size();

        model.addAttribute("orders", orders);
        model.addAttribute("user", user);
        model.addAttribute("countOrders", countOrders);

        return "user-panel";
    }

    @RequestMapping("/order/{id}")
    public java.lang.String showOrderById(@PathVariable long id, Model model) {
        List<Order> orders = new ArrayList<>();
        orders.add(orderServices.getOrderById(id));
        model.addAttribute("allOrders", orders);
        return "all-orders";
    }
}

package com.silver_ads.teplo_tex_stroi.controller;

import com.silver_ads.teplo_tex_stroi.entity.Order;
import com.silver_ads.teplo_tex_stroi.entity.Report;
import com.silver_ads.teplo_tex_stroi.entity.User;
import com.silver_ads.teplo_tex_stroi.enums.OrderStatus;
import com.silver_ads.teplo_tex_stroi.service.OrderServices;
import com.silver_ads.teplo_tex_stroi.service.ReportServices;
import com.silver_ads.teplo_tex_stroi.service.UserServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ControllerOrder {
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
        System.out.println(orders);
        return "home-page";
    }

    @RequestMapping("/order")
    public String showAllOrders(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        List<Order> orders = orderServices.getOrdersWithHidePhoneAndStatusOrder(OrderStatus.NEW_ORDER_VERIFIED.name());
        model.addAttribute("orders", orders);
        model.addAttribute("user", user);

        return "all-orders";
    }



    @RequestMapping("/order/addOrder")
    public String addOrder(@RequestParam("orderId") int orderId, Principal principal) {
        String userLogin = principal.getName();
        Order order = orderServices.getOrderById(orderId);
        User user = userServices.getUserByLoginName(userLogin);
        orderServices.addOrderToUser(order, user);
        return "redirect:/order";
    }

    @RequestMapping("/manager")
    public String showOrdersForManagersPanel(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        List<Order> orders =
                orderServices.getOrdersForManagerByStatusAndManagerLoginName(OrderStatus.NEW_ORDER_NOT_VERIFIED.name(), user);

        model.addAttribute("orders", orders);
        model.addAttribute("user", user);

        return "manager-panel";
    }

    @RequestMapping("/manager/sendOrderInWork")
    public String sendOrderInWork(@RequestParam("orderId") int orderId, Principal principal, Model model) {
        Order order = orderServices.getOrderById(orderId);
        order.setStatus(OrderStatus.NEW_ORDER_VERIFIED.name());
        orderServices.saveOrder(order);
        User user = userServices.getUserByLoginName(principal.getName());

        return "redirect:/manager";
    }

    @RequestMapping("/order/createReport")
    public String createReport(@RequestParam("orderId") int orderId, Principal principal, Model model) {
        Order order = orderServices.getOrderById(orderId);
        User user = userServices.getUserByLoginName(principal.getName());
        Report report = new Report();
        report.setOrder(order);
        report.setUserExecutor(user);
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

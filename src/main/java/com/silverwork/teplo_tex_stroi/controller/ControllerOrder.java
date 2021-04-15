package com.silverwork.teplo_tex_stroi.controller;

import com.silverwork.teplo_tex_stroi.entity.Order;
import com.silverwork.teplo_tex_stroi.entity.Report;
import com.silverwork.teplo_tex_stroi.entity.User;
import com.silverwork.teplo_tex_stroi.service.OrderServices;
import com.silverwork.teplo_tex_stroi.service.ReportServices;
import com.silverwork.teplo_tex_stroi.service.UserServices;
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

        List<Order> orders = orderServices.getOrdersWithHidePhoneAndUserNull();
        model.addAttribute("orders", orders);

        return "home-page";
    }

    @RequestMapping("/order")
    public String showAllOrders(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        List<Order> orders = orderServices.getOrdersWithHidePhoneAndUserNull();
        model.addAttribute("orders", orders);
        model.addAttribute("user", user);

        return "all-orders";
    }

    @RequestMapping("/order/addUser")
    public String addOrder(@RequestParam("orderId") int orderId, Principal principal) {
        String userLogin = principal.getName();
        Order order = orderServices.getOrderById(orderId);
        User user = userServices.getUserByLoginName(userLogin);

        order.setUser(user);
        orderServices.saveOrder(order);

        return "redirect:http://134.249.133.144:8080/order";
    }

    @RequestMapping("/order/createReport")
    public String createReport(@RequestParam("orderId") int orderId, Principal principal, Model model) {
        Order order = orderServices.getOrderById(orderId);
        User user = userServices.getUserByLoginName(principal.getName());
        Report report = new Report();
        report.setOrder(order);
        report.setUser(user);
        reportServices.saveReport(report);

        model.addAttribute("report", report);

        return "create-report";
    }

    @RequestMapping("/order/saveReport")
    public String saveReport(@ModelAttribute("report") Report report, Principal principal) throws Exception {
        Report reportResult = reportServices.findReportById(report.getId());
        reportResult.setDescription(report.getDescription());
        reportServices.saveReport(reportResult);

        return "redirect:/profile";
    }

    @RequestMapping("/profile")
    public String profileUser(Model model, Principal principal) {
        User user = userServices.getUserByLoginName(principal.getName());
        List<Order> orders = user.getOrders();
        model.addAttribute("orders", orders);
        model.addAttribute("user", user);

        return "profile-user";
    }

    @RequestMapping("/order/{id}")
    public String showOrderById(@PathVariable long id, Model model) {
        List<Order> orders = new ArrayList<>();
        orders.add(orderServices.getOrderById(id));
        model.addAttribute("allOrders", orders);
        return "all-orders";
    }
}

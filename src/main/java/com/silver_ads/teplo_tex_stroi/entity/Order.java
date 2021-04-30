package com.silver_ads.teplo_tex_stroi.entity;

import lombok.Data;
import org.springframework.stereotype.Component;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Component
@Data
@Entity
@Table(name = "orders")
public class Order {
    @Id()
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "date_insert")
    private LocalDateTime date;
    @Column(name = "user_creator")
    private String userCreator;
    @Column(name = "status_order")
    private String statusOrder;
    @Column(name = "sum_payment")
    private Integer sumPayment;
    @Column(name = "status_payment")
    private String statusPayment;

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "id_details")
    private OrderDetails orderDetails;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_executor")
    private User userExecutor;

    @OneToMany(cascade = CascadeType.ALL,
            fetch = FetchType.LAZY,
            mappedBy = "order")
    private List<Report> reports;

    public Order() {
    }

    public static Order createOrderWithDateCreated(OrderDetails orderDetails) {
        Order order = new Order();
        order.setOrderDetails(orderDetails);
        order.setDate(LocalDateTime.now());
        return order;
    }

    public void addReport(Report report) {
        if (reports == null) {
            this.reports = new ArrayList<>();
            reports.add(report);
        }
        reports.add(report);
        report.setOrder(this);
    }
}



package com.silver_ads.teplo_tex_stroi.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Getter
@Setter
@NoArgsConstructor
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

    @Column(name = "user_verifier")
    private String verifier;

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

    public void addReport(Report report) {
        if (reports == null) {
            this.reports = new ArrayList<>();
            reports.add(report);
        }
        reports.add(report);
        report.setOrder(this);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Order order = (Order) o;
        return date.equals(order.date) && userCreator.equals(order.userCreator) && Objects.equals(statusOrder, order.statusOrder) && Objects.equals(sumPayment, order.sumPayment) && Objects.equals(statusPayment, order.statusPayment) && Objects.equals(userExecutor, order.userExecutor);
    }

    @Override
    public int hashCode() {
        return Objects.hash(date, userCreator);
    }

}



package com.silverwork.teplo_tex_stroi.entity;

import com.sun.istack.Nullable;
import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Data
@Entity
@Table(name = "orders")
public class Order {
    @Id()
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "customer_name")
    private String customerName;
    @Column(name = "address")
    private String address;
    @Column(name = "count_rooms")
    private String countRooms;
    @Column(name = "square_area")
    private Integer squareArea;
    @Column(name = "notes")
    private String notes;
    @Column(name = "city")
    private String city;
    @Column(name = "phone_number")
    private String phoneNumber;
    @Column(name = "date_insert")
    private LocalDateTime date;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @Nullable
    @JoinColumn(name = "login_name")
    private User user;

    @OneToMany(cascade = CascadeType.ALL,
            fetch = FetchType.LAZY,
            mappedBy = "order")
    private List<Report> reports;

    public Order() {
    }

    public Order(String customerName, String address, String countRooms, int squareArea, String notes, String city, String phoneNumber) {
        this.customerName = customerName;
        this.address = address;
        this.countRooms = countRooms;
        this.squareArea = squareArea;
        this.notes = notes;
        this.city = city;
        this.phoneNumber = phoneNumber;
    }

    public void addReportToOrder(Report report){
        if (reports == null){
            this.reports = new ArrayList<>();
            reports.add(report);
        }
        reports.add(report);
        report.setOrder(this);
    }
}

package com.silverwork.teplo_tex_stroi.entity;

import lombok.Data;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "users")
public class User {
    @Id
    @Column(name = "login_name")
    private String loginName;
    @Column(name = "password")
    private String password;
    @Column(name = "name")
    private String name;
    @Column(name = "last_name")
    private String lastName;
    @Column(name = "city")
    private String city;
    @Column(name = "description")
    private String description;
    @Column(name = "phone_number")
    private String phoneNumber;

    @OneToMany(cascade = CascadeType.ALL,
            mappedBy = "userExecutor")
    private List<Order> orders;

    @OneToMany(cascade = CascadeType.ALL,
            mappedBy = "userExecutor")
    private List<Report> reports;

    @Column(name = "max_orders")
    private Integer maxOrders;
    @Column(name = "balance")
    private Integer balance;

    @ManyToMany
    @JoinTable(name = "users_roles",
            joinColumns = @JoinColumn(name = "login_name"),
            inverseJoinColumns = @JoinColumn(name = "role_id"))
    private List<Role> roles;

    public void addOrder(Order order) {
        if (this.orders == null) {
            this.orders = new ArrayList<>();
            this.orders.add(order);
        }
        this.orders.add(order);
    }
}

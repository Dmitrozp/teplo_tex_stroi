package com.silver_ads.teplo_tex_stroi.entity;

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
    @Column(name = "user_status")
    private String userStatus;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "id_details")
    private UserDetails userDetails;

    @OneToMany(cascade = CascadeType.ALL,
            mappedBy = "userExecutor")
    private List<Order> orders;

    @OneToMany(cascade = CascadeType.ALL,
            mappedBy = "userCreator")
    private List<Report> reports;

    @ManyToMany(fetch = FetchType.EAGER)
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

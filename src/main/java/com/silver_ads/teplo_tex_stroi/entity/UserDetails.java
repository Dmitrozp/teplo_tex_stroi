package com.silver_ads.teplo_tex_stroi.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "user_details")
public class UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
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
    @Column(name = "max_count_orders")
    private Integer maxCountOrders;
    @Column(name = "current_count_orders")
    private Integer currentCountOrders;
    @Column(name = "max_count_canceled_orders")
    private Integer maxCountCanceledOrders;
    @Column(name = "current_canceled_count_orders")
    private Integer currentCanceledCountOrders;
    @Column(name = "balance")
    private Integer balance;

    @OneToOne(cascade = CascadeType.ALL,
            mappedBy = "userDetails")
    private User user;

}

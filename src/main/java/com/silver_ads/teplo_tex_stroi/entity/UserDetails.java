package com.silver_ads.teplo_tex_stroi.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Objects;

@Setter
@Getter
@NoArgsConstructor
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserDetails that = (UserDetails) o;
        return Objects.equals(name, that.name) && Objects.equals(lastName, that.lastName) && Objects.equals(city, that.city) && Objects.equals(description, that.description) && phoneNumber.equals(that.phoneNumber) && Objects.equals(maxCountOrders, that.maxCountOrders) && Objects.equals(currentCountOrders, that.currentCountOrders) && Objects.equals(maxCountCanceledOrders, that.maxCountCanceledOrders) && Objects.equals(currentCanceledCountOrders, that.currentCanceledCountOrders) && Objects.equals(balance, that.balance);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, lastName, city, phoneNumber);
    }
}

package com.silver_ads.teplo_tex_stroi.entity;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "order_details")
public class OrderDetails {
    @Id()
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "customer_name")
    private String customerName;
    @Column(name = "phone_number")
    private String phoneNumber;
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
    @Column(name = "sum_payment_customer")
    private Integer sumOfPaymentCustomer;
    @Column(name = "square_area_from_report")
    private Integer squareAreaFromReport;
    @Column(name = "source_order")
    private String sourceOrder;
    @Column(name = "type_order")
    private String typeOrder;

    public void copy(OrderDetails orderDetailsExternal) {
        this.customerName = orderDetailsExternal.customerName;
        this.phoneNumber = orderDetailsExternal.phoneNumber;
        this.address = orderDetailsExternal.address;
        this.countRooms = orderDetailsExternal.countRooms;
        this.squareArea = orderDetailsExternal.squareArea;
        this.notes = orderDetailsExternal.notes;
        this.city = orderDetailsExternal.city;

    }
}

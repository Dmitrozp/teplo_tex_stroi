package com.silverwork.teplo_tex_stroi.entity;

import lombok.Data;

import javax.persistence.*;

@Data
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

//    @OneToOne(cascade = CascadeType.ALL,
//            mappedBy = "orderDetails")
//    private Order order;

    public void copy(OrderDetails orderDetails) {
        this.customerName = orderDetails.customerName;
        this.phoneNumber = orderDetails.phoneNumber;
        this.address = orderDetails.address;
        this.countRooms = orderDetails.countRooms;
        this.squareArea = orderDetails.squareArea;
        this.notes = orderDetails.notes;
        this.city = orderDetails.city;
    }
}

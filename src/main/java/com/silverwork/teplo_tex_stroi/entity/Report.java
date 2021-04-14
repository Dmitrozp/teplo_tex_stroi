package com.silverwork.teplo_tex_stroi.entity;

import com.sun.istack.Nullable;
import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "reports")
public class Report {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name ="date_insert")
    private LocalDateTime date;
    @Column(name = "description")
    private String description;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "login_name")
    private User user;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "order_id")
    private Order order;

}

package com.silver_ads.teplo_tex_stroi.repository;

import com.silver_ads.teplo_tex_stroi.entity.OrderDetails;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderDetailsRepository extends JpaRepository<OrderDetails, Long> {
    List<OrderDetails> findOrderDetailsByPhoneNumber(String phoneNumber);
}

package com.silverwork.teplo_tex_stroi.repository;

import com.silverwork.teplo_tex_stroi.entity.OrderDetails;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderDetailsRepository extends JpaRepository<OrderDetails, Long> {
}

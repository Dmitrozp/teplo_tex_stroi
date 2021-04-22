package com.silver_ads.teplo_tex_stroi.repository;

import com.silver_ads.teplo_tex_stroi.entity.Order;
import com.silver_ads.teplo_tex_stroi.entity.User;
import com.silver_ads.teplo_tex_stroi.enums.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    List<Order> findOrderByUserExecutor(User user);

    List<Order> findOrderByUserExecutorIsNull();

    List<Order> findOrdersByStatus(String orderStatus);

    List<Order> findOrderByStatusAndUserExecutor(String orderStatus, User user);
}


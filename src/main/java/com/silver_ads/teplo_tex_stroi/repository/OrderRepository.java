package com.silver_ads.teplo_tex_stroi.repository;

import com.silver_ads.teplo_tex_stroi.entity.Order;
import com.silver_ads.teplo_tex_stroi.entity.OrderDetails;
import com.silver_ads.teplo_tex_stroi.entity.User;
import org.aspectj.weaver.ast.Or;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    List<Order> findOrderByUserExecutor(User user);

    List<Order> findOrderByOrderDetails(OrderDetails orderDetails);

    List<Order> findOrderByOrderDetailsPhoneNumber(String phoneNumber);

    List<Order> findOrderByUserExecutorIsNull();

    List<Order> findOrdersByStatusOrder(String orderStatus);

    List<Order> findOrderByStatusOrderAndUserExecutor(String orderStatus, User user);

    List<Order> findOrderByStatusOrderAndVerifier(String orderStatus, String user);

    Optional<Order> findOrderByIdAndUserExecutor(Long id, User user);
}


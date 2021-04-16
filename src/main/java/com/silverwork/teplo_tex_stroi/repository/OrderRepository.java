package com.silverwork.teplo_tex_stroi.repository;

import com.silverwork.teplo_tex_stroi.entity.Order;
import com.silverwork.teplo_tex_stroi.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    public List<Order> findOrderByUserExecutor(User user);

    public List<Order> findOrderByUserExecutorIsNull();

    public List<Order> findOrdersByStatus(String orderStatus);
}


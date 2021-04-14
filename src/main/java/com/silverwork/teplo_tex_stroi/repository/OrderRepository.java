package com.silverwork.teplo_tex_stroi.repository;

import com.silverwork.teplo_tex_stroi.entity.Order;
import com.silverwork.teplo_tex_stroi.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    public List<Order> findOrderByUser(User user);
    public List<Order> findOrderByUserNull();
}

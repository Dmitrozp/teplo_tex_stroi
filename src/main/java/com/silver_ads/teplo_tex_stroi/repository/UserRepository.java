package com.silver_ads.teplo_tex_stroi.repository;

import com.silver_ads.teplo_tex_stroi.entity.Role;
import com.silver_ads.teplo_tex_stroi.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, String> {
    User findUserByLoginName(String loginName);
    List<User> findUsersByRoles(Role role);
}

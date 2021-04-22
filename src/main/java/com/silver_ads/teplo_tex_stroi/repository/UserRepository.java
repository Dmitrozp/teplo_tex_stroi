package com.silver_ads.teplo_tex_stroi.repository;

import com.silver_ads.teplo_tex_stroi.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, String> {
    public User findUserByLoginName(String loginName);
}

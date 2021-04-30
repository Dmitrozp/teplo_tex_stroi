package com.silver_ads.teplo_tex_stroi.repository;

import com.silver_ads.teplo_tex_stroi.entity.Role;
import com.silver_ads.teplo_tex_stroi.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RoleRepository extends JpaRepository<Role, Long> {
    Role findRoleByName(String name);
}

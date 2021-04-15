package com.silverwork.teplo_tex_stroi.service;

import com.silverwork.teplo_tex_stroi.entity.User;
import org.springframework.security.core.userdetails.UserDetails;

public interface UserServices {
    public User getUserByLoginName(String login);
}

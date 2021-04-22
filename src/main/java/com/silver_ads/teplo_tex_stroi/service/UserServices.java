package com.silver_ads.teplo_tex_stroi.service;

import com.silver_ads.teplo_tex_stroi.entity.Order;
import com.silver_ads.teplo_tex_stroi.entity.User;

public interface UserServices {
    public User getUserByLoginName(String login);

    public User addOrder(Order order, User user);

    public User save(User user);
}

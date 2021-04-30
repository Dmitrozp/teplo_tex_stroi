package com.silver_ads.teplo_tex_stroi.service;

import com.silver_ads.teplo_tex_stroi.entity.Order;
import com.silver_ads.teplo_tex_stroi.entity.User;

public interface UserServices {
    User getUserByLoginName(String login);

    User addOrder(Order order, User user);

    User save(User user);

    public User findManagerWhoCanAcceptOrder();
}

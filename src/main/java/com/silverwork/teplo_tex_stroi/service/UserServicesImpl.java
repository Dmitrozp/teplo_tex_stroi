package com.silverwork.teplo_tex_stroi.service;

import com.silverwork.teplo_tex_stroi.entity.User;
import com.silverwork.teplo_tex_stroi.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServicesImpl implements UserServices{

    @Autowired
    UserRepository userRepository;

    @Override
    public User getUserByLoginName(String login) {
        User user = userRepository.findUserByLoginName(login);
        return user;
    }
}

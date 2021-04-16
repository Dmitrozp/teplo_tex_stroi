package com.silverwork.teplo_tex_stroi.service;

import com.silverwork.teplo_tex_stroi.entity.Order;
import com.silverwork.teplo_tex_stroi.entity.Role;
import com.silverwork.teplo_tex_stroi.entity.User;
import com.silverwork.teplo_tex_stroi.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collection;
import java.util.stream.Collectors;

@Service
public class UserServicesImpl implements UserServices, UserDetailsService {

    @Autowired
    UserRepository userRepository;

    public User addOrder(Order order, User user) {
        if (user.getOrders() == null) {
            user.setOrders(new ArrayList<>());
            user.getOrders().add(order);
            System.out.println(user);
        }

        user.getOrders().add(order);

        System.out.println(user);
        userRepository.save(user);
        return user;
    }

    @Override
    public User save(User user) {
        return userRepository.save(user);
    }

    @Override
    public User getUserByLoginName(String login) {
        User user = userRepository.findUserByLoginName(login);
        return user;
    }

    @Transactional
    @Override
    public UserDetails loadUserByUsername(String login) throws UsernameNotFoundException {
        User user = userRepository.findUserByLoginName(login);
        if (user == null) {
            throw new UsernameNotFoundException("Такой пользователь не найден");
        }
        return new org.springframework.security.core.userdetails.User(user.getLoginName(), user.getPassword(), mapRolesToAuthority(user.getRoles()));
    }

    private Collection<? extends GrantedAuthority> mapRolesToAuthority(Collection<Role> roles) {
        return roles.stream().map(role -> new SimpleGrantedAuthority(role.getName())).collect(Collectors.toList());
    }
}

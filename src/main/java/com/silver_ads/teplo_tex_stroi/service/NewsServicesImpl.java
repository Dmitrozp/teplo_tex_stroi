package com.silver_ads.teplo_tex_stroi.service;

import com.silver_ads.teplo_tex_stroi.entity.News;
import com.silver_ads.teplo_tex_stroi.repository.NewsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class NewsServicesImpl implements NewsServices {
    @Autowired
    NewsRepository repository;

    @Override
    public List<News> findFirstLastNews() {
        int limitNewsForView = 3;
        return repository.findAll().stream()
                .sorted((a,b) -> b.getDate().compareTo(a.getDate()))
                .limit(limitNewsForView).collect(Collectors.toList());
    }

    @Override
    public List<News> showAllNews() {
        return repository.findAll().stream().sorted((a,b) -> b.getDate().compareTo(a.getDate())).collect(Collectors.toList());
    }

    @Override
    public Optional<News> findNewsById(Long newsId) {
        return repository.findById(newsId);
    }
}

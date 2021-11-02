package com.silver_ads.teplo_tex_stroi.service;

import com.silver_ads.teplo_tex_stroi.entity.News;
import java.util.List;
import java.util.Optional;

public interface NewsServices {
    List<News> findFirstLastNews();
    List<News> showAllNews();
    Optional<News> findNewsById(Long newsId);
}

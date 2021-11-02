package com.silver_ads.teplo_tex_stroi.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "news")
public class News {
    @Id()
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "date_insert")
    private LocalDateTime date;
    @Column(name = "title")
    private String title;
    @Column(name = "pre_view")
    private String preView;
    @Column(name = "text_news", length = 65535, columnDefinition = "text")
    private String text;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        News news = (News) o;
        return date.equals(news.date) && title.equals(news.title) && Objects.equals(preView, news.preView);
    }

    @Override
    public int hashCode() {
        return Objects.hash(date, title, preView);
    }

    @Override
    public String toString() {
        return "News{" +
                "id=" + id +
                ", date=" + date +
                ", title='" + title + '\'' +
                ", preView='" + preView + '\'' +
                ", text=" + text +
                '}';
    }
}

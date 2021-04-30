USE silverads;

CREATE TABLE silverads.order_details (
                                         id BIGINT NOT NULL AUTO_INCREMENT,
                                         customer_name varchar(255) DEFAULT NULL,
                                         address varchar(255) DEFAULT NULL,
                                         count_rooms varchar(255) DEFAULT NULL,
                                         city varchar(255) DEFAULT NULL,
                                         square_area int4 DEFAULT '0',
                                         square_area_from_report int8 DEFAULT '0',
                                         sum_payment_customer int8 DEFAULT '0',
                                         notes varchar(255) DEFAULT NULL,
                                         phone_number varchar(255) DEFAULT NULL,
                                         source_order varchar(255) DEFAULT NULL,
                                         type_order varchar(255) DEFAULT NULL,
                                         id_order BIGINT DEFAULT NULL,
                                         PRIMARY KEY (id)
);
CREATE TABLE silverads.orders (
                                  id BIGINT NOT NULL AUTO_INCREMENT,
                                  date_insert timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                  user_creator varchar(255) DEFAULT NULL,
                                  user_executor varchar(255) DEFAULT NULL,
                                  status_order varchar(255) DEFAULT NULL,
                                  sum_payment int8 DEFAULT '0',
                                  status_payment varchar(255) DEFAULT NULL,
                                  id_details int8,
                                  PRIMARY KEY (id),
                                  FOREIGN KEY (id_details) REFERENCES order_details (id)

);
CREATE TABLE silverads.user_details (
                                        id BIGINT NOT NULL AUTO_INCREMENT,
                                        name varchar(25),
                                        last_name varchar(25),
                                        city varchar(25),
                                        description varchar(25),
                                        phone_number varchar(25),
                                        max_count_orders int8 DEFAULT 0,
                                        current_count_orders int8 DEFAULT 0,
                                        max_count_canceled_orders int8 DEFAULT 0,
                                        current_canceled_count_orders int8 DEFAULT 0,
                                        balance int8 DEFAULT 0,
                                        login_name varchar(25),
                                        PRIMARY KEY (id)
) ;
CREATE TABLE silverads.users (
                                 login_name varchar(25),
                                 password varchar(255),
                                 user_status varchar(25),
                                 id_details int8,
                                 PRIMARY KEY (login_name),
                                 FOREIGN KEY (id_details) REFERENCES user_details (id)
);
CREATE TABLE silverads.roles (
                                 id BIGINT NOT NULL AUTO_INCREMENT,
                                 name varchar(25),
                                 PRIMARY KEY (id)
) ;
CREATE TABLE silverads.users_roles (
                                       id BIGINT NOT NULL AUTO_INCREMENT,
                                       login_name varchar(25) NOT NULL,
                                       role_id BIGINT NOT NULL,
                                       PRIMARY KEY (id),
                                       foreign key (login_name) references users (login_name),
                                       foreign key (role_id) references roles (id)
);
CREATE TABLE silverads.reports (
                                   id BIGINT NOT NULL AUTO_INCREMENT,
                                   order_id BIGINT NOT NULL,
                                   date_insert TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                   description text,
                                   login_name varchar(25),
                                   PRIMARY KEY (id),
                                   foreign key (order_id) references silverads.orders(id),
                                   foreign key (login_name) references silverads.users(login_name)
) ;
CREATE TABLE silverads.ads_statistics_fb (
                                             id bigint NOT NULL AUTO_INCREMENT,
                                             date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                             ad_name varchar(25),
                                             adset_bid_type varchar(25),
                                             adset_bid_value varchar(25),
                                             age_targeting varchar(25),
                                             attribution_setting varchar(25),
                                             cost_per_inline_link_click varchar(25),
                                             cost_per_inline_post_engagement varchar(25),
                                             cost_per_unique_inline_link_click varchar(25),
                                             cpc varchar(25),
                                             estimated_ad_recall_rate varchar(25),
                                             estimated_ad_recall_rate_upper_bound varchar(25),
                                             impressions varchar(25),
                                             inline_link_click_ctr varchar(25),
                                             labels varchar(25),
                                             quality_score_ecvr varchar(25),
                                             quality_score_organic varchar(25),
                                             ad_bid_type varchar(25),
                                             ad_delivery varchar(25),
                                             adset_end varchar(25),
                                             adset_name varchar(25),
                                             adset_start varchar(25),
                                             auction_bid varchar(25),
                                             auction_competitiveness varchar(25),
                                             auction_max_competitor_bid varchar(25),
                                             buying_type varchar(25),
                                             campaign_name varchar(25),
                                             cost_per_estimated_ad_recallers varchar(25),
                                             created_time varchar(25),
                                             engagement_rate_ranking varchar(25),
                                             estimated_ad_recall_rate_lower_bound varchar(25),
                                             estimated_ad_recallers varchar(25),
                                             estimated_ad_recallers_lower_bound varchar(25),
                                             estimated_ad_recallers_upper_bound varchar(25),
                                             full_view_impressions varchar(25),
                                             inline_link_clicks varchar(25),
                                             inline_post_engagement varchar(25),
                                             instant_experience_clicks_to_open varchar(25),
                                             instant_experience_clicks_to_start varchar(25),
                                             objective varchar(25),
                                             place_page_name varchar(25),
                                             qualifying_question_qualify_answer_rate varchar(25),
                                             quality_ranking varchar(25),
                                             quality_score_ectr varchar(25),
                                             unique_clicks varchar(25),
                                             unique_inline_link_click_ctr varchar(25),
                                             unique_link_clicks_ctr varchar(25),
                                             ad_bid_value varchar(25),
                                             ad_id varchar(25),
                                             adset_delivery varchar(25),
                                             canvas_avg_view_percent varchar(25),
                                             canvas_avg_view_time varchar(25),
                                             clicks varchar(25),
                                             cost_per_dda_countby_convs varchar(25),
                                             cost_per_unique_click varchar(25),
                                             cpp varchar(25),
                                             dda_countby_convs varchar(25),
                                             frequency varchar(25),
                                             full_view_reach varchar(25),
                                             gender_targeting varchar(25),
                                             instant_experience_outbound_clicks varchar(25),
                                             social_spend varchar(25),
                                             spend varchar(25),
                                             unique_ctr varchar(25),
                                             unique_inline_link_clicks varchar(25),
                                             updated_time varchar(25),
                                             wish_bid varchar(25),
                                             adset_budget_value varchar(25),
                                             campaign_id varchar(25),
                                             cpm varchar(25),
                                             ctr varchar(25),
                                             date_stop varchar(25),
                                             location varchar(25),
                                             reach varchar(25),
                                             account_currency varchar(25),
                                             account_id varchar(25),
                                             account_name varchar(255),
                                             adset_budget_type varchar(25),
                                             adset_id varchar(25),
                                             conversion_rate_ranking varchar(25),
                                             date_start varchar(25),
                                             PRIMARY KEY (`id`)
);




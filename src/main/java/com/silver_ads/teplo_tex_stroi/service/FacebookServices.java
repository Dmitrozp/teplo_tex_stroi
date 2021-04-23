package com.silver_ads.teplo_tex_stroi.service;

import com.facebook.ads.sdk.*;
import com.silver_ads.teplo_tex_stroi.entity.fbDto.AdsInsightsDTO;
import com.silver_ads.teplo_tex_stroi.repository.AdsInsightsDTORepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
@PropertySource("classpath:facebook.properties")
public class FacebookServices {

    @Autowired
    private AdsInsightsDTORepository repository;

    @Value("${access_token}")
    private String accessToken;
    @Value("${app_secret}")
    private String appSecret;
    @Value("${app_id}")
    private String appId;
    @Value("${marketing_account_id}")
    private String marketingAccountId;

    public APINodeList<AdsInsights> getStatisticsAdsFromFacebook() throws APIException {

        final int COUNT_OF_RESULTS_NEXT_PAGE = 100000;
        APIContext context = new APIContext(accessToken).enableDebug(true);

        APINodeList<AdsInsights> statistics = new AdAccount(marketingAccountId, context).getInsights()
                .setTimeRange("{\"since\":\"" + LocalDate.now().toString() + "\",\"until\":\"" + LocalDate.now().toString() + "\"}")
                .setFiltering("[]")
                .setLevel(AdsInsights.EnumLevel.VALUE_AD)
                .setBreakdowns(Arrays.asList())
                .requestField("reach")
                .requestField("frequency")
                .requestField("impressions")
                .requestField("spend")
                .requestField("quality_score_organic")
                .requestField("quality_score_ectr")
                .requestField("quality_score_ecvr")
                .requestField("cpp")
                .requestField("cpm")
                .requestField("unique_link_clicks_ctr")
                .requestField("clicks")
                .requestField("unique_clicks")
                .requestField("ctr")
                .requestField("unique_ctr")
                .requestField("cpc")
                .requestField("cost_per_unique_click")
                .requestField("estimated_ad_recallers")
                .requestField("estimated_ad_recall_rate")
                .requestField("cost_per_estimated_ad_recallers")
                .requestField("date_start")
                .requestField("date_stop")
                .requestField("account_id")
                .requestField("account_name")
                .requestField("campaign_name")
                .requestField("campaign_id")
                .requestField("adset_id")
                .requestField("adset_name")
                .requestField("ad_id")
                .requestField("ad_name")

//          .requestField("results")
//          .requestField("result_rate")
//          .requestField("delivery")
//          .requestField("cost_per_result")
//          .requestField("impressions_gross")
//          .requestField("impressions_auto_refresh")
//          .requestField("actions:page_engagement")
//          .requestField("actions:like")
//          .requestField("actions:comment")
//          .requestField("actions:post_engagement")
//          .requestField("actions:post_reaction")
//          .requestField("actions:onsite_conversion.post_save")
//          .requestField("actions:post")
//          .requestField("actions:photo_view")
//          .requestField("actions:rsvp")
//          .requestField("actions:checkin")
//          .requestField("actions:full_view")
//          .requestField("unique_actions:full_view")
//          .requestField("ar_effect_share:ar_effect_share")
//          .requestField("cost_per_action_type:page_engagement")
//          .requestField("cost_per_action_type:like")
//          .requestField("cost_per_action_type:post_engagement")
//          .requestField("cost_per_action_type:rsvp")
//          .requestField("unique_video_continuous_2_sec_watched_actions:video_view")
//          .requestField("video_continuous_2_sec_watched_actions:video_view")
//          .requestField("actions:video_view")
//          .requestField("video_thruplay_watched_actions:video_view")
//          .requestField("video_p25_watched_actions:video_view")
//          .requestField("video_p50_watched_actions:video_view")
//          .requestField("video_p75_watched_actions:video_view")
//          .requestField("video_p95_watched_actions:video_view")
//          .requestField("video_p100_watched_actions:video_view")
//          .requestField("video_avg_time_watched_actions:video_view")
//          .requestField("video_play_actions:video_view")
//          .requestField("canvas_avg_view_time")
//          .requestField("canvas_avg_view_percent")
//          .requestField("cost_per_2_sec_continuous_video_view:video_view")
//          .requestField("cost_per_action_type:video_view")
//          .requestField("cost_per_thruplay:video_view")
//          .requestField("actions:link_click")
//          .requestField("unique_actions:link_click")
//          .requestField("outbound_clicks:outbound_click")
//          .requestField("unique_outbound_clicks:outbound_click")
//          .requestField("website_ctr:link_click")
//          .requestField("outbound_clicks_ctr:outbound_click")
//          .requestField("unique_outbound_clicks_ctr:outbound_click")
//          .requestField("cost_per_action_type:link_click")
//          .requestField("cost_per_unique_action_type:link_click")
//          .requestField("cost_per_outbound_click:outbound_click")
//          .requestField("cost_per_unique_outbound_click:outbound_click")
//          .requestField("campaign_group_name")
//          .requestField("campaign_group_id")
//          .requestField("adgroup_id")
//          .requestField("adgroup_name")
                .execute();

        APINodeList<AdsInsights> statisticsFinalList = statistics;
        statisticsFinalList.addAll(statistics.nextPage(COUNT_OF_RESULTS_NEXT_PAGE));

        return statisticsFinalList;

    }

    public void saveStatisticsFromFB(APINodeList<AdsInsights> adsInsights){
        List<AdsInsightsDTO> adsInsightsDTOList = adsInsights.stream().map(adsInsight ->
                new AdsInsightsDTO().fransformFrom(adsInsight)).collect(Collectors.toList());

        adsInsightsDTOList.forEach(adsInsightDTO -> {
            adsInsightDTO.setDate(LocalDateTime.now());
            repository.save(adsInsightDTO);
        });
    }

}

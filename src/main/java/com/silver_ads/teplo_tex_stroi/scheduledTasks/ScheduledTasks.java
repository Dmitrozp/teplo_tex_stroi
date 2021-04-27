package com.silver_ads.teplo_tex_stroi.scheduledTasks;

import com.facebook.ads.sdk.*;
import com.silver_ads.teplo_tex_stroi.service.FacebookServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class ScheduledTasks {

    @Autowired
    FacebookServices facebookServices;

   @Scheduled(cron = "0 59 * * * *")
   public void getAndSaveFBStatistics() throws APIException {
        List<AdsInsights> adsInsights = facebookServices.getStatisticsAdsFromFacebook();
        facebookServices.saveStatisticsFromFB(adsInsights);
    }
}

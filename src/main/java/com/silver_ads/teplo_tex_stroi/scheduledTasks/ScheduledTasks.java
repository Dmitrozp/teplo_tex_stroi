package com.silver_ads.teplo_tex_stroi.scheduledTasks;

import com.facebook.ads.sdk.*;
import com.silver_ads.teplo_tex_stroi.service.FacebookServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ScheduledTasks {

    @Autowired
    FacebookServices facebookServices;

   @Scheduled(cron = "0 59 * * * *")
   public void getAndSaveFBStatistics() throws APIException {
        APINodeList<AdsInsights> adsInsights = facebookServices.getStatisticsAdsFromFacebook();
        facebookServices.saveStatisticsFromFB(adsInsights);
    }
}

package com.silver_ads.teplo_tex_stroi.util;

import java.time.LocalDateTime;

public class Util {
    public static LocalDateTime createTimeWithNotNullSeconds(LocalDateTime localDateTime){
        if(localDateTime.getSecond() == 00){
            return localDateTime.plusSeconds(1L);
        }
        return localDateTime;
    }
}

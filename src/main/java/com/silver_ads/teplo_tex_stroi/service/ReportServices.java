package com.silver_ads.teplo_tex_stroi.service;

import com.silver_ads.teplo_tex_stroi.entity.Report;

public interface ReportServices {
    public Report saveReport(Report report);

    public Report findReportById(Long id);
}

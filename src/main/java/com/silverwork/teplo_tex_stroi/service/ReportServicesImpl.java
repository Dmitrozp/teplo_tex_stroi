package com.silverwork.teplo_tex_stroi.service;

import com.silverwork.teplo_tex_stroi.entity.Report;
import com.silverwork.teplo_tex_stroi.repository.ReportRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class ReportServicesImpl implements ReportServices{
    @Autowired
    ReportRepository reportRepository;

    @Override
    public Report saveReport(Report report) {
        if (report.getDate() == null) {
            report.setDate(LocalDateTime.now());
        }
        reportRepository.save(report);
        return report;
    }

    @Override
    public Report findReportById(Long id) {
        return reportRepository.findById(id).get();
    }
}

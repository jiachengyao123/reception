package com.buba.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.buba.pojo.SecReportingData;
import com.baomidou.mybatisplus.extension.service.IService;
import com.buba.pojo.SecUser;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author MrJia
 * @since 2019-09-02
 */
public interface SecReportingDataService extends IService<SecReportingData> {

    boolean getAddsecReportingData(MultipartFile[] albumNameFile, SecReportingData secReportingData);


    IPage<SecReportingData> getsecReportingDataTable(SecUser secUser,Integer page, Integer limit);

    List<SecReportingData> getsecReportingDataTableEchartsline(SecUser secUser);
}

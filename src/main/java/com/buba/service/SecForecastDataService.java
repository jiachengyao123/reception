package com.buba.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.buba.pojo.SecForecastData;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author MrJia
 * @since 2019-09-02
 */
public interface SecForecastDataService extends IService<SecForecastData> {

    IPage<SecForecastData> getsecForecastDataTable(SecForecastData secForecastData, Integer page, Integer limit);
}

package com.buba.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.buba.pojo.SecForecastData;
import com.buba.mapper.SecForecastDataMapper;
import com.buba.service.SecForecastDataService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author MrJia
 * @since 2019-09-02
 */
@Service
public class SecForecastDataServiceImpl extends ServiceImpl<SecForecastDataMapper, SecForecastData> implements SecForecastDataService {

    @Resource
    private  SecForecastDataMapper secForecastDataMapper;

    @Override
    public IPage<SecForecastData> getsecForecastDataTable(SecForecastData secForecastData, Integer page, Integer limit) {
        //page参数
        Page<SecForecastData> objectPage = new Page<>(page,limit);
        //new QueryWrapper（） 查询参数对象
        QueryWrapper<SecForecastData> objectQueryWrapper = new QueryWrapper<>();
        // 参数赋值
        objectQueryWrapper.eq("status",secForecastData.getStatus()).eq("userId",secForecastData.getUserId());
        //调用查询分页方法
        IPage<SecForecastData> secForecastDataIPage = secForecastDataMapper.selectPage(objectPage, objectQueryWrapper);
        return secForecastDataIPage;
    }
}

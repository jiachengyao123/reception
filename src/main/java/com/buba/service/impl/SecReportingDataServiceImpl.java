package com.buba.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.buba.mapper.SecForecastDataMapper;
import com.buba.mapper.SecGalleryMapper;
import com.buba.pojo.SecForecastData;
import com.buba.pojo.SecGallery;
import com.buba.pojo.SecReportingData;
import com.buba.mapper.SecReportingDataMapper;
import com.buba.pojo.SecUser;
import com.buba.service.SecReportingDataService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.buba.utils.MultipartFileUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;


import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author MrJia
 * @since 2019-09-02
 */
@Service
public class SecReportingDataServiceImpl extends ServiceImpl<SecReportingDataMapper, SecReportingData> implements SecReportingDataService {

    @Resource
    private  SecReportingDataMapper  secReportingDataMapper;

    @Resource
    private SecForecastDataMapper secForecastDataMapper;
    @Resource
    private SecGalleryMapper secGalleryMapper;

    @Transactional
    @Override
    public boolean getAddsecReportingData(MultipartFile[] albumNameFile, SecReportingData secReportingData) {
        int insert = secReportingDataMapper.insert(secReportingData);
        if(insert>0){
            SecForecastData secForecastData = new SecForecastData();
            secForecastData.setId(secReportingData.getForecastId());
            secForecastData.setStatus(true);
            int i = secForecastDataMapper.updateById(secForecastData);
            if(i>0){
                List<String> imgReception = MultipartFileUtil.getMultipartFileUtil(albumNameFile, "imgReception");
                SecGallery secGallery = new SecGallery();
                secGallery.setAlbumInfo("活动图片");
                secGallery.setAlbumCover("reception");
                secGallery.setCreatetime(new Date());
                secGallery.setActivityId(secForecastData.getId());
                for (String imgName:imgReception) {
                    secGallery.setAlbumSequence(i++);
                    secGallery.setAlbumName(imgName);
                    secGalleryMapper.insert(secGallery);
                }
                return true;
            }
        }
        return false;
    }


    @Override
    public IPage<SecReportingData> getsecReportingDataTable(SecUser secUser,Integer page, Integer limit) {
        //page参数
        Page<SecReportingData> objectPage = new Page<>(page,limit);
       List<SecReportingData> list= secReportingDataMapper.getsecReportingDataTable(secUser);
        Page<SecReportingData> secReportingDataPage = objectPage.setRecords(list);
        return secReportingDataPage;
    }

    @Override
    public List<SecReportingData> getsecReportingDataTableEchartsline(SecUser secUser) {

        return secReportingDataMapper.getsecReportingDataTableEchartsline(secUser);
    }
}

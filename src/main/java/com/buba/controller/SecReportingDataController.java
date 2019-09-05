package com.buba.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.buba.pojo.SecReportingData;
import com.buba.pojo.SecUser;
import com.buba.service.SecReportingDataService;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author MrJia
 * @since 2019-09-02
 */
@Controller
@RequestMapping("/secReportingData")
public class SecReportingDataController {

        @Resource
        private SecReportingDataService secReportingDataService;

        @RequestMapping("getAddsecReportingData")
        @ResponseBody
        public boolean getAddsecReportingData(MultipartFile[] albumNameFile, SecReportingData secReportingData){
            boolean addsecReportingData = secReportingDataService.getAddsecReportingData(albumNameFile, secReportingData);
            return addsecReportingData;
        }


    @RequestMapping("getsecReportingDataTable")
    @ResponseBody
    public Map<String,Object> getsecReportingDataTable(SecUser secUser,Integer page, Integer limit){
        IPage<SecReportingData> page1 = secReportingDataService.getsecReportingDataTable(secUser, page, limit);
        Map<String,Object> map=new HashMap<>();
        map.put("code",0);
        map.put("msg", "成功");
        map.put("count",page1.getTotal());
        map.put("data",page1.getRecords());
        return map;
    }
    @RequestMapping("getsecReportingDataTableEchartsline")
    @ResponseBody
    public List<SecReportingData> getsecReportingDataTableEchartsline(SecUser secUser){

        return  secReportingDataService.getsecReportingDataTableEchartsline(secUser);
    }

}



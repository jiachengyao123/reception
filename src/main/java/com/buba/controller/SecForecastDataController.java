package com.buba.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.buba.pojo.SecForecastData;
import com.buba.pojo.SecUser;
import com.buba.service.SecForecastDataService;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
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
@RequestMapping("/secForecastData")
public class SecForecastDataController {

    @Resource
    private SecForecastDataService secForecastDataService;

    @RequestMapping("getAddsecForecastData")
    @ResponseBody
    public boolean getAddsecForecastData(SecForecastData secForecastData){
        secForecastData.setEntryTime(new Date());
        boolean save = secForecastDataService.save(secForecastData);
        return save;
    }


    @RequestMapping("getsecForecastDataTable")
    @ResponseBody
    public Map<String,Object> getsecForecastDataTable(SecForecastData secForecastData,Integer page,Integer limit){
        Map<String,Object> map=new HashMap<>();
        IPage<SecForecastData> iPage= secForecastDataService.getsecForecastDataTable(secForecastData,page,limit);
        map.put("code",0);
        map.put("msg", "succes" +
                "s");
        map.put("count",iPage.getTotal());
        map.put("data",iPage.getRecords());
        return map;
    }
}


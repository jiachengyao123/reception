package com.buba.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.buba.pojo.SecAddress;
import com.buba.service.SecAddressService;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author MrJia
 * @since 2019-08-28
 */
@Controller
@RequestMapping("/secAddress")
public class SecAddressController {

    @Resource
    private SecAddressService secAddressService;

    @RequestMapping("getsecAddress")
    @ResponseBody
    public List<SecAddress> getsecAddress(){
        List<SecAddress> list = secAddressService.list();
        for (SecAddress s:list) {
            if(s.getPid()==0){
                s.setOpen(true);
            }
        }
        return list;
    }

    @RequestMapping("getAddsecAddress")
    @ResponseBody
    public boolean getAddsecAddress(SecAddress secAddress){
        boolean save = secAddressService.save(secAddress);
        return save;
    }

    @RequestMapping("getDelzTree")
    @ResponseBody
    public boolean getDelzTree(SecAddress secAddress){
        boolean b = secAddressService.removeById(secAddress);
        return b;
    }
    @RequestMapping("getUpdatazTreeName")
    @ResponseBody
    public boolean getUpdatazTreeName(SecAddress secAddress){
        boolean b = secAddressService.saveOrUpdate(secAddress);
        return b;
    }
    @RequestMapping("getSecAddressByid")
    @ResponseBody
    public List<SecAddress> getSecAddressByid(SecAddress secAddress){
        List<SecAddress> list = secAddressService.getSecAddressByid(secAddress);
        return list;
    }
    @RequestMapping("getsecAddressName")
    @ResponseBody
    public SecAddress getsecAddressName(Integer id){
        SecAddress byId = secAddressService.getById(id);
        return byId;
    }

}


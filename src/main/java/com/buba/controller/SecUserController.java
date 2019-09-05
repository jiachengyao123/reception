package com.buba.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.buba.pojo.SecUser;
import com.buba.service.SecUserService;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.sql.Wrapper;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author MrJia
 * @since 2019-08-28
 */
@Controller
@RequestMapping("/secUser")
public class SecUserController {
    
    @Resource
    private SecUserService secUserService;
    
    @RequestMapping("getUser")
    @ResponseBody
    public Map<String,Object> getUser(SecUser secUser, String jpwd, HttpSession session){
            Map<String,Object> map=new HashMap<>();
        QueryWrapper<SecUser> objectQueryWrapper = new QueryWrapper<>();
        objectQueryWrapper.eq("userCode",secUser.getUserCode()).eq("password",secUser.getPassword());
        SecUser one = secUserService.getOne(objectQueryWrapper);
        if(one!=null){
            if(jpwd!=null){
               session.setAttribute("userCode",one.getUserCode());
               session.setAttribute("password",one.getPassword());
            }else {
                session.removeAttribute("userCode");
                session.removeAttribute("password");
            }
            map.put("login",true);
            session.setAttribute("user",one);
        }else {
            map.put("login",false);
            map.put("msg","*账户密码错误");
        }
        return map;
    }

    @RequestMapping("getCancellation")
    @ResponseBody
    public boolean getCancellation(HttpSession session) {
        session.invalidate();//注销 清除session
       try {
           session.getAttribute("user");
       }catch (Exception e){
           return true;
       }
        return false;
    }

    @RequestMapping("getAddsecUser")
    @ResponseBody
    public boolean getAddsecUser(SecUser secUser) {
        boolean save = secUserService.save(secUser);
        return save;
    }

    @RequestMapping("getUserTable")
    @ResponseBody
    public Map<String,Object> getUserTable(SecUser secUser,Integer page,Integer limit) {
       IPage<SecUser> iPage= secUserService.getUserTable(secUser,page,limit);
        Map<String, Object> map = new HashMap<>();
        map.put("code",0);
        map.put("msg","success");
        map.put("count",iPage.getTotal());
        map.put("data",iPage.getRecords());
        return map;
    }

}


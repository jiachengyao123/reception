package com.buba.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.buba.pojo.SecUser;
import com.buba.mapper.SecUserMapper;
import com.buba.service.SecUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author MrJia
 * @since 2019-08-28
 */
@Service
public class SecUserServiceImpl extends ServiceImpl<SecUserMapper, SecUser> implements SecUserService {
    @Resource
    private  SecUserMapper secUserMapper;


    @Override
    public IPage<SecUser> getUserTable(SecUser secUser, Integer page, Integer limit) {
        Page<SecUser> objectPage = new Page<>(page,limit);
        QueryWrapper<SecUser> objectQueryWrapper = new QueryWrapper<>();
        objectQueryWrapper.eq("ressid",secUser.getRessid());
        IPage<SecUser> secUserIPage = secUserMapper.selectPage(objectPage, objectQueryWrapper);
        return secUserIPage;
    }
}

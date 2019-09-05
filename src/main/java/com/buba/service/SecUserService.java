package com.buba.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.buba.pojo.SecUser;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author MrJia
 * @since 2019-08-28
 */
public interface SecUserService extends IService<SecUser> {

    IPage<SecUser> getUserTable(SecUser secUser, Integer page, Integer limit);
}

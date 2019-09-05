package com.buba.service;

import com.buba.pojo.SecAddress;
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
public interface SecAddressService extends IService<SecAddress> {

    List<SecAddress> getSecAddressByid(SecAddress secAddress);
}

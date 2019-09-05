package com.buba.service.impl;

import com.buba.pojo.SecAddress;
import com.buba.mapper.SecAddressMapper;
import com.buba.service.SecAddressService;
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
public class SecAddressServiceImpl extends ServiceImpl<SecAddressMapper, SecAddress> implements SecAddressService {

    @Resource
    private SecAddressMapper secAddressMapper;

    @Override
    public List<SecAddress> getSecAddressByid(SecAddress secAddress) {
        List<SecAddress> secAddressByid = secAddressMapper.getSecAddressByid(secAddress);
        return secAddressByid;
    }
}

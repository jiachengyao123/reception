package com.buba.mapper;

import com.buba.pojo.SecAddress;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author MrJia
 * @since 2019-08-28
 */
@Component
public interface SecAddressMapper extends BaseMapper<SecAddress> {

    List<SecAddress> getSecAddressByid(SecAddress secAddress);
}

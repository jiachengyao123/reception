package com.buba.mapper;

import com.buba.pojo.SecReportingData;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.buba.pojo.SecUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author MrJia
 * @since 2019-09-02
 */
public interface SecReportingDataMapper extends BaseMapper<SecReportingData> {

    List<SecReportingData> getsecReportingDataTable(@Param("user") SecUser secUser);

    List<SecReportingData> getsecReportingDataTableEchartsline(@Param("user") SecUser secUser);
}

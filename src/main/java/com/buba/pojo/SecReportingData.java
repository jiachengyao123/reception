package com.buba.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author MrJia
 * @since 2019-09-02
 */
public class SecReportingData implements Serializable {

private static final long serialVersionUID=1L;

    /**
     * 主键ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 实际上报桌数
     */
    @TableField("actualTableCount")
    private Integer actualTableCount;

    /**
     * 新客户人数
     */
    @TableField("newCustomers")
    private Integer newCustomers;

    /**
     * 老客户人数
     */
    @TableField("oldCustomers")
    private Integer oldCustomers;

    /**
     * 意向客户人数
     */
    @TableField("intentionalCustomers")
    private Integer intentionalCustomers;

    /**
     * 保费
     */
    private Double premium;

    /**
     * 活动时间
     */
    @TableField("activityTime")
    @JsonFormat(pattern="yyyy-MM-dd  HH:mm:ss" ,  timezone="GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date activityTime;

    /**
     * 计划表id
     */
    private Integer forecastId;

    /**
     * planName计划名称
     */
    private String planName;
    /**
     * 计划桌数
     */
    private  Integer planNumberTables;

    /**
     * 所属地区
     * @return
     */
    private String name;

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getPlanNumberTables() {
        return planNumberTables;
    }

    public void setPlanNumberTables(Integer planNumberTables) {
        this.planNumberTables = planNumberTables;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getActualTableCount() {
        return actualTableCount;
    }

    public void setActualTableCount(Integer actualTableCount) {
        this.actualTableCount = actualTableCount;
    }

    public Integer getNewCustomers() {
        return newCustomers;
    }

    public void setNewCustomers(Integer newCustomers) {
        this.newCustomers = newCustomers;
    }

    public Integer getOldCustomers() {
        return oldCustomers;
    }

    public void setOldCustomers(Integer oldCustomers) {
        this.oldCustomers = oldCustomers;
    }

    public Integer getIntentionalCustomers() {
        return intentionalCustomers;
    }

    public void setIntentionalCustomers(Integer intentionalCustomers) {
        this.intentionalCustomers = intentionalCustomers;
    }

    public Double getPremium() {
        return premium;
    }

    public void setPremium(Double premium) {
        this.premium = premium;
    }

    public Date getActivityTime() {
        return activityTime;
    }

    public void setActivityTime(Date activityTime) {
        this.activityTime = activityTime;
    }

    public Integer getForecastId() {
        return forecastId;
    }

    public void setForecastId(Integer forecastId) {
        this.forecastId = forecastId;
    }

    @Override
    public String toString() {
        return "SecReportingData{" +
        "id=" + id +
        ", actualTableCount=" + actualTableCount +
        ", newCustomers=" + newCustomers +
        ", oldCustomers=" + oldCustomers +
        ", intentionalCustomers=" + intentionalCustomers +
        ", premium=" + premium +
        ", activityTime=" + activityTime +
        ", forecastId=" + forecastId +
        "}";
    }
}

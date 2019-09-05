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
public class SecForecastData implements Serializable {

private static final long serialVersionUID=1L;

    /**
     * 主键ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 录入时间
     */
    @TableField("entryTime")
    @JsonFormat(pattern="yyyy-MM-dd  HH:mm:ss" ,  timezone="GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date entryTime;

    /**
     * 计划名称
     */
    @TableField("planName")
    private String planName;

    /**
     * 计划召开桌数
     */
    @TableField("planNumberTables")
    private Integer planNumberTables;

    /**
     * 开始时间
     */
    @TableField("startTime")
    @JsonFormat(pattern="yyyy-MM-dd  HH:mm:ss" ,  timezone="GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startTime;

    /**
     * 结束时间
     */
    @TableField("endTime")
    @JsonFormat(pattern="yyyy-MM-dd  HH:mm:ss" ,  timezone="GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endTime;

    /**
     * 没时间是‘0’，实际上报改为‘1’
     */
    private Boolean status;

    /**
     * 用户表id
     */
    @TableField("userId")
    private Integer userId;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(Date entryTime) {
        this.entryTime = entryTime;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public Integer getPlanNumberTables() {
        return planNumberTables;
    }

    public void setPlanNumberTables(Integer planNumberTables) {
        this.planNumberTables = planNumberTables;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "SecForecastData{" +
        "id=" + id +
        ", entryTime=" + entryTime +
        ", planName=" + planName +
        ", planNumberTables=" + planNumberTables +
        ", startTime=" + startTime +
        ", endTime=" + endTime +
        ", status=" + status +
        ", userId=" + userId +
        "}";
    }
}

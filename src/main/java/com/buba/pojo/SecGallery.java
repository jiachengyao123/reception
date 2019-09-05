package com.buba.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.TableId;
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
public class SecGallery implements Serializable {

private static final long serialVersionUID=1L;

    /**
     * 图片id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 上传时间
     */
    @JsonFormat(pattern="yyyy-MM-dd  HH:mm:ss" ,  timezone="GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createtime;

    /**
     * 图片种类
     */
    private String albumInfo;

    /**
     * 图片name
     */
    private String albumName;

    /**
     * 排序
     */
    private Integer albumSequence;

    /**
     * 图片类型
     */
    private String albumCover;

    /**
     * 活动表id
     */
    private Integer activityId;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getAlbumInfo() {
        return albumInfo;
    }

    public void setAlbumInfo(String albumInfo) {
        this.albumInfo = albumInfo;
    }

    public String getAlbumName() {
        return albumName;
    }

    public void setAlbumName(String albumName) {
        this.albumName = albumName;
    }

    public Integer getAlbumSequence() {
        return albumSequence;
    }

    public void setAlbumSequence(Integer albumSequence) {
        this.albumSequence = albumSequence;
    }

    public String getAlbumCover() {
        return albumCover;
    }

    public void setAlbumCover(String albumCover) {
        this.albumCover = albumCover;
    }

    public Integer getActivityId() {
        return activityId;
    }

    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
    }

    @Override
    public String toString() {
        return "SecGallery{" +
        "id=" + id +
        ", createtime=" + createtime +
        ", albumInfo=" + albumInfo +
        ", albumName=" + albumName +
        ", albumSequence=" + albumSequence +
        ", albumCover=" + albumCover +
        ", activityId=" + activityId +
        "}";
    }
}

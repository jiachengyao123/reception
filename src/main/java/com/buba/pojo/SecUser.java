package com.buba.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author MrJia
 * @since 2019-08-28
 */
public class SecUser implements Serializable {

private static final long serialVersionUID=1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 用户名称
     */
    @TableField("userName")
    private String userName;

    /**
     * 用户描述-账户
     */
    @TableField("userCode")
    private String userCode;

    private String password;
    /**
     * SecAddress
     */
    @TableField("ressid")
    private Integer ressid;

    /**
     * 等级
     */
    @TableField("userLevel")
    private Integer userLevel;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getRessid() {
        return ressid;
    }

    public void setRessid(Integer ressid) {
        this.ressid = ressid;
    }

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getUserLevel() {
        return userLevel;
    }

    public void setUserLevel(Integer userLevel) {
        this.userLevel = userLevel;
    }

    @Override
    public String toString() {
        return "SecUser{" +
                "id=" + id +
                ", userName='" + userName + '\'' +
                ", userCode='" + userCode + '\'' +
                ", password='" + password + '\'' +
                ", ressid=" + ressid +
                ", userLevel=" + userLevel +
                '}';
    }
}

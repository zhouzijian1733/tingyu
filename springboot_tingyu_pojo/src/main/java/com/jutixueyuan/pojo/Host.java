package com.jutixueyuan.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
@TableName("t_host")
public class Host extends Model<Host> {

    private static final long serialVersionUID=1L;

    @TableId(value = "hid", type = IdType.AUTO)
    private Integer hid;

    private String hname;

    private String hpwd;

    private String hphone;

    private LocalDateTime starttime;

    private String status;

    private String strong;

    private Integer ordernumber;

    /**
     *
     *   查询 的 结果 中有 价格 / 打折等字段  这些字段在 hostpower 表中
     *     返回的结果中需要有 hostpower 对象
     *
     *   对象的封装中 添加  hostPower 对象
     *
     *    @TableField(exist = false) hostPower 对象不是 host 表中的字段
     *
     */
    @TableField(exist = false)
    private HostPower hostPower;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public HostPower getHostPower() {
        return hostPower;
    }

    public void setHostPower(HostPower hostPower) {
        this.hostPower = hostPower;
    }

    public Integer getHid() {
        return hid;
    }

    public void setHid(Integer hid) {
        this.hid = hid;
    }

    public String getHname() {
        return hname;
    }

    public void setHname(String hname) {
        this.hname = hname;
    }

    public String getHpwd() {
        return hpwd;
    }

    public void setHpwd(String hpwd) {
        this.hpwd = hpwd;
    }

    public String getHphone() {
        return hphone;
    }

    public void setHphone(String hphone) {
        this.hphone = hphone;
    }

    public LocalDateTime getStarttime() {
        return starttime;
    }

    public void setStarttime(LocalDateTime starttime) {
        this.starttime = starttime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStrong() {
        return strong;
    }

    public void setStrong(String strong) {
        this.strong = strong;
    }

    public Integer getOrdernumber() {
        return ordernumber;
    }

    public void setOrdernumber(Integer ordernumber) {
        this.ordernumber = ordernumber;
    }

    @Override
    protected Serializable pkVal() {
        return this.hid;
    }

    @Override
    public String toString() {
        return "Host{" +
        "hid=" + hid +
        ", hname=" + hname +
        ", hpwd=" + hpwd +
        ", hphone=" + hphone +
        ", starttime=" + starttime +
        ", status=" + status +
        ", strong=" + strong +
        ", ordernumber=" + ordernumber +
        "}";
    }
}

package com.jutixueyuan.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.jutixueyuan.pojo.HostPower;
import com.jutixueyuan.pojo.Result;
import com.jutixueyuan.service.IHostPowerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
@Controller
@RequestMapping("/hostPower")
public class HostPowerController {

    @Autowired
    private IHostPowerService hostPowerService;

    @ResponseBody
    @RequestMapping("update.do")
    public Result update(HostPower hostPower){

        // 处理请求
        // 如果 host没有 hostpower 添加hostpower
        // 如果 host有  hostpower 更新hostpower

        // 如何判断 host 是否有  hostpower  判断 hostpower 中是否存在 字段 hpid

        if (hostPower.getHpid() == null){  // 添加

            boolean insert = hostPower.insert();
            return new Result(insert ? "hostpower添加成功" : "hostpower添加失败", insert);

        }else{  // 更新的操作

            boolean b = hostPower.updateById();
            return new Result(b ? "hostpower更新成功" : "hostpower更新失败", b);
        }

//        // 如果存在 更新 如果不存在 添加
//        boolean b = hostPower.insertOrUpdate();
//        return new Result(b ? "hostpower更新成功" : "hostpower更新失败", b);
    }

    @ResponseBody
    @RequestMapping("batch.do")
    public Result batch(String hids,HostPower hostPower){

        // 处理请求
        // hids        多个主持人 的id
        // hostPower   主持人的权限
        // 多个主持人的 权限是 hostPower

        // 通过 hids 删除 之前的 hostpower

        //添加多个 hostpower ,每一个hid 设置一个单独的hostpower

        // 删除 hids的权限
        String[] hidArr = hids.split(",");

        QueryWrapper<HostPower> qr = new QueryWrapper<>();
        qr.in("hostid",hidArr);
        hostPowerService.remove(qr);
        // 添加多个权限
        boolean flag = false;
        for (int i = 0; i < hidArr.length; i++) {
            hostPower.setHostid(Integer.valueOf(hidArr[i]));
            flag = hostPower.insert();
            if (!flag){
                break;  // 保证每一个添加成功
            }
        }
        return new Result(flag ? "hostpower添加成功" : "hostpower添加失败", flag);
    }

}


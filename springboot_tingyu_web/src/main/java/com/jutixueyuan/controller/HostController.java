package com.jutixueyuan.controller;


import com.jutixueyuan.pojo.Host;
import com.jutixueyuan.pojo.HostCondition;
import com.jutixueyuan.pojo.PageResult;
import com.jutixueyuan.pojo.Result;
import com.jutixueyuan.service.IHostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
@RestController
@RequestMapping("/host")
public class HostController {

    @Autowired
    private IHostService hostService;

    /**
     * @param page
     * @param rows
     * @param hostCondition 条件查询的对象
     * @return
     */
    @RequestMapping("hostInfo.do")
    public PageResult<Host> hostInfo(Integer page, Integer rows, HostCondition hostCondition) {

        // 处理请求
//        PageResult<Host> pageResult = hostService.selectHost(page, rows);

        // 添加一个条件查询的对象
        PageResult<Host> pageResult = hostService.selectHost(page, rows, hostCondition);

        //返回结果
        return pageResult;
    }

    // 修改权重

    /**
     * 页面把 strong / hid 直接参数绑定 到host对象中
     *
     * @param host
     * @return
     */
    @RequestMapping("strongUp.do")
    public Result strongUp(Host host) {

        // 处理请求

        // ar 模式直接调用
        boolean b = host.updateById();

        return new Result(b ? "权重修改成功" : "权重修改失败", b);
    }

    @RequestMapping("addHost.do")
    public Result addHost(Host host) {

        // 处理请求

        // 设置默认值
        // 订单
        host.setOrdernumber(0);
        // 时间日期对象   LocalDateTime  和 java.util.date 一样
        host.setStarttime(LocalDateTime.now());
        // 正常使用
        host.setStatus("1");

        // 设置默认的权重
        host.setStrong("20");

        // ar 添加
        boolean insert = host.insert();
        return new Result(insert ? "host添加成功" : "host添加失败", insert);
    }

    @RequestMapping("hostAccountUp.do")
    public Result hostAccountUp(String hids, String statuss) {

        // 处理请求
        //01  拿到 hids 和 statuss 进行处理
        String[] hidStrs = hids.split(",");
        String[] statusStrs = statuss.split(",");

        //02 更新status 操作

        // 创建一个Host的集合
        List<Host> hosts = new ArrayList<>();

        for (int i = 0; i < hidStrs.length; i++) {
            // 通过 hid 和 status 创建 新的host 添加到 批处理中
            Host h = new Host();
            h.setHid(Integer.parseInt(hidStrs[i]));

            // 要进行 status 更新
            // 设置 status 需要判断
            // 如果你是 1  需要设置 0  更新到数据库中
            // 如果你是 0  需要设置 1  更新到数据库中
            h.setStatus("1".equals(statusStrs[i])?"0":"1");
            hosts.add(h);

            // 单个host 进行 修改
//            h.updateById();

        }
        // 批处理 比循环修改 效果 高一点
        // 批量更新 updateBatchById  更新需要集合
        boolean b = hostService.updateBatchById(hosts);
        return new Result(b ? "host修改成功" : "host修改失败", b);
    }
}


package com.jutixueyuan.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jutixueyuan.mapper.HostMapper;
import com.jutixueyuan.pojo.Host;
import com.jutixueyuan.pojo.HostCondition;
import com.jutixueyuan.pojo.PageResult;
import com.jutixueyuan.service.IHostService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
@Service
public class HostServiceImpl extends ServiceImpl<HostMapper, Host> implements IHostService {

    @Resource
    private HostMapper hostMapper;

    /**
     *
     *  01 添加分页的插件
     *
     *  02 分页的数据
     *     01  分页的模型
     *     02 调用方法
     *
     * @param page
     * @param rows
     * @param hostCondition
     * @return
     */
    @Override
    public PageResult<Host> selectHost(Integer page, Integer rows, HostCondition hostCondition) {

        Page<Host> p = new Page<>(page,rows);

        // mp 只能进行单表查询
        // 需要多表查询 自己手动写
        //调用分页的方法
//        Page<Host> hostPage = hostMapper.selectPage(p, null);
        Page<Host> hostPage = hostMapper.selectHost(p,hostCondition);
        // 组装  pageResult
        PageResult<Host> pageResult = new PageResult<>();

        // 总数
        pageResult.setTotal(hostPage.getTotal());
        // 分页展示的数据
        pageResult.setRows(hostPage.getRecords());

        return pageResult;
    }
}

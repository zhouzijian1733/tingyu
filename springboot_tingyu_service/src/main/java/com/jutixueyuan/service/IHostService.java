package com.jutixueyuan.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jutixueyuan.pojo.Host;
import com.jutixueyuan.pojo.HostCondition;
import com.jutixueyuan.pojo.PageResult;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
public interface IHostService extends IService<Host> {

    // 查询host
    PageResult<Host> selectHost(Integer page, Integer rows, HostCondition hostCondition);


}

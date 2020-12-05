package com.jutixueyuan.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jutixueyuan.pojo.Host;
import com.jutixueyuan.pojo.HostCondition;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
public interface HostMapper extends BaseMapper<Host> {

    /**
     * 查询 host 字节手动写
     * @param p
     * @return
     */
    Page<Host> selectHost(Page<Host> p, @Param("hostCondition") HostCondition hostCondition);
}

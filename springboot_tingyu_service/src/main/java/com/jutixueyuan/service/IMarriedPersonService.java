package com.jutixueyuan.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jutixueyuan.pojo.MarriedPerson;
import com.jutixueyuan.pojo.PageResult;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
public interface IMarriedPersonService extends IService<MarriedPerson> {

    // 分页查询marriedPerson
    PageResult<MarriedPerson> selectPageMarried(Integer page, Integer rows, String pname, String phone);
}

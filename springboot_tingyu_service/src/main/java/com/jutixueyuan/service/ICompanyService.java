package com.jutixueyuan.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jutixueyuan.pojo.Company;
import com.jutixueyuan.pojo.PageResult;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
public interface ICompanyService extends IService<Company> {

    PageResult<Company> companyInfo(Integer page, Integer rows, String cname, String status, String ordernumber);
}

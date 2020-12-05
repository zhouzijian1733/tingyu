package com.jutixueyuan.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jutixueyuan.mapper.CompanyMapper;
import com.jutixueyuan.pojo.Company;
import com.jutixueyuan.pojo.PageResult;
import com.jutixueyuan.service.ICompanyService;
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
public class CompanyServiceImpl extends ServiceImpl<CompanyMapper, Company> implements ICompanyService {

    @Resource
    private CompanyMapper companyMapper;

    @Override
    public PageResult<Company> companyInfo(Integer page, Integer rows, String cname, String status, String ordernumber) {

        // 01 分页查询
        //   01 分页插件
        //   02 封装 分页的基本模型
        Page<Company> p = new Page<>(page, rows);

        // 条件查询 queryWrapper 实现

        QueryWrapper<Company> qr = new QueryWrapper<>();

        // cname        条件
        if (!"".equals(cname) && cname != null){
            // 条件 模糊查询
            qr.like("cname",cname);
        }
        // status       条件
        if (!"".equals(status) && status != null){
            // 条件 模糊查询
            qr.eq("status",status);
        }
        // ordernumber 条件
        if (!"".equals(ordernumber) && ordernumber != null){

            if (ordernumber.equals("asc")){ // 升序
                qr.orderByAsc("ordernumber");
            }
            if (ordernumber.equals("desc")){ // 降序
                qr.orderByDesc("ordernumber");
            }
        }

        // 调用分页方法
        Page<Company> companyPage = companyMapper.selectPage(p, qr);
        // 02 组装返回结果  PageResult
        PageResult<Company> pageResult = new PageResult<>();




        pageResult.setRows(companyPage.getRecords());
        pageResult.setTotal(companyPage.getTotal());
        return pageResult;
    }
}

package com.jutixueyuan.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jutixueyuan.mapper.MarriedPersonMapper;
import com.jutixueyuan.pojo.MarriedPerson;
import com.jutixueyuan.pojo.PageResult;
import com.jutixueyuan.service.IMarriedPersonService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
@Service
public class MarriedPersonServiceImpl extends ServiceImpl<MarriedPersonMapper, MarriedPerson> implements IMarriedPersonService {

    @Resource
    private MarriedPersonMapper marriedPersonMapper;

    // 分页查询
    @Override
    public PageResult<MarriedPerson> selectPageMarried(Integer page, Integer rows, String pname, String phone) {

        // 01 创建 page 模型对象

        Page<MarriedPerson> p = new Page<>(page, rows);

        // 分页 条件查询
        QueryWrapper<MarriedPerson> qr = new QueryWrapper<>();
        // 模糊查询
        if (pname != null && !"".equals(pname)) {
            qr.like("pname", pname);
        }
        //手机号
        if (phone != null && !"".equals(phone)) {
            qr.eq("phone", phone);
        }

        // 02 调用方法
        Page<MarriedPerson> marriedPersonPage = marriedPersonMapper.selectPage(p, qr);
        // 03 组装pageResult

        PageResult<MarriedPerson> marriedPersonPageResult = new PageResult<>();
        marriedPersonPageResult.setTotal(marriedPersonPage.getTotal());
        marriedPersonPageResult.setRows(marriedPersonPage.getRecords());

        return marriedPersonPageResult;
    }
}

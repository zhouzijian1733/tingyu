package com.jutixueyuan.controller;


import com.jutixueyuan.pojo.Company;
import com.jutixueyuan.pojo.PageResult;
import com.jutixueyuan.pojo.Result;
import com.jutixueyuan.service.ICompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
@RestController
@RequestMapping("/company")
public class CompanyController {

    @Autowired
    private ICompanyService companyService;

    // 分页查询
    @RequestMapping("companyInfo.do")
    public PageResult<Company> companyInfo(Integer page,Integer rows,String cname,String status,String ordernumber){

        //处理请求
        PageResult<Company>  companyPageResult = companyService.companyInfo(page,rows,cname,status,ordernumber);

        return companyPageResult;
    }

    // 添加公司
    @RequestMapping("addCompany.do")
    public Result addCompany(Company company){

        // 处理请求

        // 给没有字段设置默认值
        // 状态
        company.setStatus("1");
        // 订单
        company.setOrdernumber(0);
        // 时间
        company.setStarttime(LocalDateTime.now());

        // ar 模式添加
        boolean insert = company.insert();
        return  new Result(insert ? "company添加成功" : "company添加失败", insert);
    }

    // 编辑公司的处理
    @RequestMapping("companyUp.do")
    public Result companyUp(Company company){

        // 处理请求

            // 方法的处理 ar 模式
        boolean b = company.updateById();
        return new Result(b ? "company修改成功" : "company修改失败", b);
    }

    // 公司的账号状态
    @RequestMapping("companyStatusUp.do")
    public Result companyStatusUp(String cids,String statuss){

        //处理请求

        //   01  把 cids 和 statuss 切割
        String[] cidArr = cids.split(",");
        String[] statusArr = statuss.split(",");

        //   02 批处理更新
        List<Company> list = new ArrayList<>();

        for (int i = 0; i < cidArr.length; i++) {

            Company company = new Company();
            company.setCid(Integer.valueOf(cidArr[i]));
            // 如果你是 1 修改为  0
            // 如果你是 0 修改为  1  状态的修改
            company.setStatus(statusArr[i].equals("1") ? "0" : "1");
            list.add(company);
        }

        // 批量更新的处理
        boolean b = companyService.updateBatchById(list);
//        companyService.saveOrUpdateBatch()

        return  new Result(b ? "company状态成功" : "company状态失败", b);
    }

}


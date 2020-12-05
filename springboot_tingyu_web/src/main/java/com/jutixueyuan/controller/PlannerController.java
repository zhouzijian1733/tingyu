package com.jutixueyuan.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jutixueyuan.pojo.PageResult;
import com.jutixueyuan.pojo.Planner;
import com.jutixueyuan.service.IPlannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
@RestController
@RequestMapping("/planner")
public class PlannerController {

    @Autowired
    private IPlannerService plannerService;

    // 查询策划师

    @RequestMapping("plannerInfo.do")
    public PageResult<Planner> plannerInfo(Integer page,Integer rows,Integer cid){

        // 01 查询

        Page<Planner> p = new Page<>(page,rows);

        // 条件查询
        QueryWrapper<Planner> qr = new QueryWrapper<>();
        qr.eq("cid",cid);

        Page<Planner> pagePlanner = plannerService.page(p, qr);
        //  把 page组装厂 pageResult
        PageResult<Planner> pageResult =  new PageResult<Planner>();
        pageResult.setTotal(pagePlanner.getTotal());
        pageResult.setRows(pagePlanner.getRecords());

        return pageResult;
    }

}


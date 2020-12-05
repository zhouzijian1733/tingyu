package com.jutixueyuan.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.jutixueyuan.pojo.Admin;
import com.jutixueyuan.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private IAdminService adminService;


    @RequestMapping("login.do")
    public String login(String aname, String apwd, HttpSession session){

        // 处理请求

        // 调用service
        QueryWrapper<Admin> qr = new QueryWrapper<>();

        // 条件构造 判断用户 和密码
        qr.eq("aname",aname).eq("apwd",apwd);
        // 查询
        Admin admin = (Admin) adminService.getOne(qr);

        // 判断是否登陆
        if (admin != null){
            //登陆
            // 保存 admin  页面跳转
            session.setAttribute("admin",admin);
            return "redirect:/main.jsp";
        }else {
            session.setAttribute("msg","error");
            return "redirect:/login.jsp";
        }
    }
}


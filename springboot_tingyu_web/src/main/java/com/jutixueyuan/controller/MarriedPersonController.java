package com.jutixueyuan.controller;


import com.jutixueyuan.pojo.MarriedPerson;
import com.jutixueyuan.pojo.PageResult;
import com.jutixueyuan.pojo.Result;
import com.jutixueyuan.service.IMarriedPersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
@RestController
@RequestMapping("/marriedPerson")
public class MarriedPersonController {
    private Integer code;

    @Autowired
    private IMarriedPersonService marriedPersonService;

    @RequestMapping("marriedPersonInfo.do")
    public PageResult<MarriedPerson> marriedPersonInfo(Integer page,Integer rows,String pname,String phone){
        // 处理请求
        // 调用服务
       PageResult<MarriedPerson> marriedPersonPageResult =  marriedPersonService.selectPageMarried(page,rows,pname,phone);

       return marriedPersonPageResult;
    }
    //注册
    @RequestMapping("reg.do")
    public Result addPerson(MarriedPerson marriedPerson){

        if (marriedPerson.getNewCode().equals(code)){
            marriedPerson.setMarrydate(LocalDate.of(2020,11,11));
            marriedPerson.setRegdate(LocalDateTime.now());
            marriedPerson.setStatus("1");
            boolean insert = marriedPerson.insert();
            return new Result(insert?"注册成功":"注册失败",insert);
        }else {
            return new Result("注册失败,验证码不正确",false);
        }
    }

}


package com.jutixueyuan.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 黄药师
 * @date 2020-11-20 14:25
 * @desc 百战程序员 http://www.jutixueyuan.com
 *
 *  返回的结果对象
 *
 */
@AllArgsConstructor   // 有参 所有参数的构造器
@NoArgsConstructor   // 无参构造器
@Data
public class Result {

    private String msg;

    private boolean success;

}

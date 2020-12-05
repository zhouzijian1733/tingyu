package com.jutixueyuan.pojo;

import lombok.Data;

import java.util.List;

/**
 * @author 黄药师
 * @date 2020-11-20 10:24
 * @desc 百战程序员 http://www.jutixueyuan.com
 *
 *    dataGrid 需要的返回值
 *
 *   {"total":4,"rows":[
 *     {"name":"Name","value":"Bill Smith","group":"ID Settings","editor":"text"},
 *     {"name":"Address","value":"","group":"ID Settings","editor":"text"},
 *     {"name":"SSN","value":"123-456-7890","group":"ID Settings","editor":"text"}
 * ]}
 *
 *   上面的数据格式是 dataGrid 必须要的数据格式
 *     total  总数
 *     rows   展示的数据集合
 *         {"name":"Name","value":"Bill Smith","group":"ID Settings","editor":"text"}  一行的展示数据
 *
 *   把上面的数据封装成一个对象 给 datagrid 返回
 *
 */
@Data
public class PageResult<T>{

    private Long total;

    private List<T> rows;

}

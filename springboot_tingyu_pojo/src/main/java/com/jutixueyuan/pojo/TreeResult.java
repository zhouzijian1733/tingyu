package com.jutixueyuan.pojo;

import lombok.Data;

import java.util.Map;

/**
 * @author 黄药师
 * @date 2020-11-18 15:24
 * @desc 百战程序员 http://www.jutixueyuan.com
 *
 *    异步树 服务器 返回的菜单数据
 */
@Data  // 有set/get方法
public class TreeResult {

//       "id": 1,    "text": "Node 1",    "state": "closed",
    // 节点的 id，它对于加载远程数据很重要。
    private Integer id;

    // 要显示的节点文本。
    private String text;

    // state：节点状态，'open' 或 'closed'，默认是 'open'。当设置为 'closed' 时，该节点有子节点，并且将从远程站点加载它们。
    private String state;

    // 可以给tree 节点添加自定义属性
    private Map<String,Object> attributes;

}


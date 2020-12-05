package com.jutixueyuan.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jutixueyuan.pojo.Menu;
import com.jutixueyuan.pojo.Result;
import com.jutixueyuan.pojo.TreeResult;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
public interface IMenuService extends IService<Menu> {

    // 同过角色查询菜单 查询 菜单
    List<TreeResult> selectMenuInfo(Integer aid, Integer id);

    // 查询所有的菜单
    List<TreeResult> selectMenuAllInfo(Integer id);

    // 添加 menu 的业务实现
    Result addMuen(Menu menu);

    // 删除菜单
    Result delMenu(Menu m);

}

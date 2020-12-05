package com.jutixueyuan.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jutixueyuan.mapper.AdminRoleMapper;
import com.jutixueyuan.mapper.MenuMapper;
import com.jutixueyuan.mapper.RoleMenuMapper;
import com.jutixueyuan.pojo.Menu;
import com.jutixueyuan.pojo.Result;
import com.jutixueyuan.pojo.TreeResult;
import com.jutixueyuan.service.IMenuService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements IMenuService {


    @Resource
    private AdminRoleMapper adminRoleMapper;

    // 查询 菜单权限
    @Resource
    private RoleMenuMapper roleMenuMapper;

    // 查询菜单
    @Resource
    private MenuMapper menuMapper;

    @Override
    public List<TreeResult> selectMenuInfo(Integer aid, Integer pid) {

//        // 业务流程
//        // 01  通过 aid 查找 t_admin_role 的 rid
//        //条件构造器
//        // select rid from t_admin_role where aid =1
//        QueryWrapper<AdminRole> qr1 = new QueryWrapper<>();
//        qr1.eq("aid",aid);
//        // select("column") 查询指定的字段
//        qr1.select("rid");
//        // selectObjs 返回 结果的第一个字段
//        List<Object> rids = adminRoleMapper.selectObjs(qr1);
//
//        // 02  通过 rid 查找 t_menu_role 的  mid
//        //select mid from t_role_menu where rid = 1;
//        QueryWrapper<RoleMenu> qr2 = new QueryWrapper<>();
////        qr2.eq("rid",1);
//        qr2.in("rid",rids);
//        // 只查询 mid 字段
//        qr2.select("mid");
//        List<Object> mids = roleMenuMapper.selectObjs(qr2);
//
//        // 03  通过 mid 查找 t_menu 的 menu信息
//        /**
//         * select * from t_menu where mid in (
//         * 	  mids
//         * ) and pid = 1;
//         */
//        QueryWrapper<Menu> qr3 = new QueryWrapper<>();
//        qr3.eq("pid",pid);
//        qr3.in("mid",mids);
//        List<Menu> menus = menuMapper.selectList(qr3);
//        System.out.println("menus = " + menus);

        // 使用xml 实现菜单查询
        List<Menu> menus = menuMapper.showMenuInfo(aid, pid);

        // 04  menu信息 转成 TreeResult 信息
        List<TreeResult> treeResults = new ArrayList<>();
        for (Menu menu : menus) {

            TreeResult tr = new TreeResult();
            // id 菜单的id
            tr.setId(menu.getMid());
            tr.setText(menu.getMname());
            //  'open' 或 'closed'，默认是 'open'。当设置为 'closed' 时，该节点有子节点，并且将从远程站点加载它们。
            //  menu 要判断是否为 父菜单
            tr.setState("1".equals(menu.getIsparent()) ? "closed":"open");

            // 添加自定义 属性
            Map<String,Object> map = new HashMap<>();

            // 添加自定义属性 isparent
            map.put("isparent",menu.getIsparent());

            // 添加自定义属性 url
            map.put("url",menu.getUrl());
            tr.setAttributes(map);
            //添加到集合中
            treeResults.add(tr);
        }
        return treeResults;
    }

    /**
     * 查询所有的菜单
     * @param pid
     * @return
     */
    @Override
    public List<TreeResult> selectMenuAllInfo(Integer pid) {

        // 01  通过pid 条件查询

        QueryWrapper<Menu> qr = new QueryWrapper<>();
        qr.eq("pid",pid);
        List<Menu> menus = menuMapper.selectList(qr);

        // 02 组装 List<TreeResult> 返回结果

        List<TreeResult> treeResultList = new ArrayList<>();

        // 循环操作 把 Menu 转成 TreeResult

        for (Menu menu : menus) {

            TreeResult treeResult = new TreeResult();
            // tree 的基本数据
            // id      菜单的mid
            treeResult.setId(menu.getMid());
            // text    菜单的mname
            treeResult.setText(menu.getMname());
            // statu    节点状态，'open' 或 'closed'，默认是 'open'。当设置为 'closed' 时，该节点有子节点，并且将从远程站点加载它们。
            // 父节点 给 closed 可以打开 远程加载子节点
            treeResult.setState(menu.getIsparent().equals("1") ? "closed":"open");

            // menu 对象还有 其他的属性
            // tree 节点可以通过 attribute 把自定属性回写给浏览器
            Map<String,Object> map = new HashMap<>();

            map.put("isparent",menu.getIsparent());
            map.put("pid",menu.getPid());
            map.put("url",menu.getUrl());
            map.put("mdesc",menu.getMdesc());

            treeResult.setAttributes(map);
            //添加到集合中
            treeResultList.add(treeResult);

        }

        return treeResultList;
    }

    /**
     *  添加菜单
     * @param menu
     * @return
     */
    @Override
    public Result addMuen(Menu menu) {

        // 01 判断 是否存在pid  如果不存在 pid 为0
        Integer pid = menu.getPid();
        // 02 如果  pid 存在 需要更新 父级菜单的isparent 为 1
        if (pid == null){
            menu.setPid(0);
        }else{

            // 更新父级isparent = 1
            Menu mParent = new Menu();
            mParent.setMid(pid);  // 父级菜单的mid 等于 当前的此地的pid
            mParent.setIsparent("1");

            // 更新父级菜单
            mParent.updateById();
        }

        // 03  menu 有一些默认值 需要设置 status / isparent
        menu.setStatus("0");
        menu.setIsparent("0");
        // 04 添加 menu
        boolean insert = menu.insert();
        return new Result(insert ? "menu添加成功" : "menu添加失败", insert);
    }

    /**
     * 删除 菜单
     * @param m
     * @return
     */
    @Override
    public Result delMenu(Menu m) {

        // 01  如果 父级菜单 只有 一个子菜单 需要修改 父级菜单的状态 isparent
//        -- 通过 pid 查询 这个父菜单 有多个个子菜单
//        select count(*) from t_menu where pid = 1;

        QueryWrapper<Menu> qr = new QueryWrapper<>();
        qr.eq("pid",m.getPid());
        Integer count = menuMapper.selectCount(qr);

        if (count == 1){  // 父级菜单 需要 修改 isparent = 0

            Menu mParent = new Menu();

            // 父菜单的 mid 是 当前的菜单的pid
            mParent.setMid(m.getPid());
            mParent.setIsparent("0");
            mParent.updateById();
        }
        // 02 删除菜单
//        boolean b = m.deleteById();

        // 如果菜单是父级菜单 需要递归删除
        // 前端 ajax 删除的是 只有一个pid 和mid 判断用isparent 没有这个参数 
//        m = m.selectById();
//        if (m.getIsparent().equals("1")){
//            // 递归删除
//            delMenuChildRen(m);
//        }else{  // 如果不是父级菜单 正常删除
//
//        }

        m.deleteById();
        return  new Result(true ? "menu删除成功" : "menu删除失败", true);
    }

    /**
     *  递归删除 父级菜单下面的所有的子菜单
     * @param m
     */
    private void delMenuChildRen(Menu m) {

        // 删除 子菜单
        Integer mid = m.getMid();
        //        -- 通过 pid 查询 这个父菜单 有多个个子菜单
//        select * from t_menu where pid = 1;
        QueryWrapper<Menu> qr = new QueryWrapper<>();
        qr.eq("pid",mid);
        List<Menu> menus = menuMapper.selectList(qr);

        for (Menu menu : menus) {
            if (menu.getIsparent().equals("1")){
                delMenuChildRen(menu);
            }
            // 删除子菜单
            menu.deleteById();
        }
        // 删除父菜单
        m.deleteById();
    }

}

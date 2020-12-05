package com.jutixueyuan.controller;


import com.jutixueyuan.pojo.Admin;
import com.jutixueyuan.pojo.Menu;
import com.jutixueyuan.pojo.Result;
import com.jutixueyuan.pojo.TreeResult;
import com.jutixueyuan.service.IMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
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
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private IMenuService menuService;

    /**
     *   session 注入session 拿到 admin
     *   pid (当前的菜单 父菜单的id是谁) 通过pid 查询 子菜单
     *       一级菜单的pid = 0
     *            浏览器页面没有传递参数   设置默认值  @RequestParam(defaultValue = "0")
     *       二级菜单的pid 是一级菜单的 mid
     *            通过一级菜单的mid 把数据发送过来
     * @param id
     * @param session
     * @return
     */
    @RequestMapping("menuInfo.do")
    public List<TreeResult> menuInfos(@RequestParam(defaultValue = "0") Integer id, HttpSession session){

        // 01 拿到用户角色
        Admin admin = (Admin) session.getAttribute("admin");
        //用户角色
        Integer aid = admin.getAid();
        // 02 调用service
        // 查询菜单
        List<TreeResult> treeResults = menuService.selectMenuInfo(aid,id);
        System.out.println("=================");
        System.out.println(treeResults);
        return treeResults;
    }

    /**
     *
     *  menuInfos  这个方法查询菜单 是  brac  通过不同的用户角色查询 不同的菜单
     *
     *  menuAllInfo  直接查询 所有的 菜单信息
     *
     *  异步树:
     *     展开一个关闭的节点时，如果该节点没有子节点加载，它将通过上面定义的 URL
     *     向服务器发送节点的 id 值作为名为 'id' 的 http 请求参数，以便检索子节点。
     *
     *      如果是第一次查询: 查询顶层 菜单
     *         defaultValue = "0"  查询一级菜单
     *      如果 查询下一级菜单, 通过顶级菜单的id 查询他的子菜单
     *        Integer id 通过一级菜单的id查询 子菜单
     *
     * @param id
     * @return
     */
    @RequestMapping("menuAllInfo.do")
    public List<TreeResult> menuAllInfo(@RequestParam(defaultValue = "0") Integer id){

        List<TreeResult> treeResultList = menuService.selectMenuAllInfo(id);
        return treeResultList;
    }

    // 添加菜单
    @RequestMapping("addMenu.do")
    public Result addMenu(Menu menu){

        Result rs = menuService.addMuen(menu);

        return rs;
    }

    // 菜单的修改
    @RequestMapping("menuUp.do")
    public Result menuUp(Menu m){

        boolean b = m.updateById();
        return new Result(b ? "menu修改成功" : "menu修改失败", b);
    }

    // 菜单删除修改
    @RequestMapping("menuDel.do")
    public Result menuDel(Menu m){
        Result rs = menuService.delMenu(m);
        return rs;
    }

}


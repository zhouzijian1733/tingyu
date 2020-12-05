package com.jutixueyuan.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jutixueyuan.pojo.Menu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since 2020-11-18
 */
public interface MenuMapper extends BaseMapper<Menu> {

    List<Menu> showMenuInfo(@Param("aid") Integer aid, @Param("pid") Integer pid);

}

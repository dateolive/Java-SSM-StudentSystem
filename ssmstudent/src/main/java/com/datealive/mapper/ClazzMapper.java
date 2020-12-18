package com.datealive.mapper;

import com.datealive.entity.Clazz;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;


@Mapper
public interface ClazzMapper {

    //查询班级列表
    List<Clazz> getClazzList(@Param("clazz1") Clazz clazz, @Param("page") int page,@Param("limit") int limit);

    //查询班级总数
    int getClazzListTotal(Clazz clazz);

    //修改班级
    int editClazz(Clazz clazz);

    //插入班级
    int addClazz(Clazz clazz);

    //批量删除班级
    int deleteClazzAll(@Param("ids") List<Integer> ids);

    //删除单个班级
    int deleteClazz(int id);
}

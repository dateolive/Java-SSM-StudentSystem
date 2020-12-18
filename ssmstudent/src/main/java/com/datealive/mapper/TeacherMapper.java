package com.datealive.mapper;

import com.datealive.entity.Teacher;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TeacherMapper {

    Teacher queryTeacher(@Param(value = "name") String name, @Param(value = "password") String password);

    //获取老师列表
    List<Teacher> getTeacherList(@Param("teacher") Teacher teacher,@Param("page") int page,@Param("limit") int limit);

    //获取老师总数
    int getTeacherListTotal(Teacher teacher);

    //增加老师
    int addTeacher(Teacher teacher);

    //编辑老师
    int editTeacher(Teacher teacher);

    //删除老师
    int deleteTeacher(@Param("ids") List<Integer> ids);

    //修改老师密码
    int editPassword(@Param("teacher") Teacher teacher,@Param("newPwd") String newPwd);

}

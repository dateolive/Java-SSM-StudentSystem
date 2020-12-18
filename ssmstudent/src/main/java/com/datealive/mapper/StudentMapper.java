package com.datealive.mapper;

import com.datealive.entity.Student;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;


@Mapper
public interface StudentMapper {

    //根据姓名密码查询学生
    Student queryStudent(@Param(value = "name") String name, @Param(value = "password") String password);

    //获取学生列表
    List<Student> getStudentList(@Param("student") Student student,@Param(value = "page") int page,@Param(value = "limit") int limit);

    //获取学生总数
    int getStudentListTotal(Student student);

    //插入学生
    int addStudent(Student student);

    //编辑学生
    int editStudent(Student student);

    //删除学生
    int deleteStudent(@Param("ids") List<Integer> ids);

    //修改该学生的密码
    int editPassword(@Param("student") Student student,@Param("newPwd") String newPwd);
}

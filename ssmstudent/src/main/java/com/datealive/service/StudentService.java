package com.datealive.service;

import com.datealive.entity.Student;

import java.util.List;

public interface StudentService {

    Student queryStudent(String name, String password);

    //获取学生列表
    List<Student> getStudentList(Student student,int page,  int limit);

    //获取学生总数
    int getStudentListTotal(Student student);

    //插入学生
    int addStudent(Student student);

    //编辑学生
    int editStudent(Student student);

    //删除学生
    int deleteStudent(List<Integer> ids);

    //修改该学生的密码
    void editPassword(Student student,String newPwd);
}

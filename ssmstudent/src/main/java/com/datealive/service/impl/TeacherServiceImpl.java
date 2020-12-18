package com.datealive.service.impl;

import com.datealive.entity.Teacher;
import com.datealive.mapper.TeacherMapper;
import com.datealive.service.TeacherService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
@Slf4j
public class TeacherServiceImpl implements TeacherService {

    @Autowired(required = false)
    TeacherMapper teacherMapper;
    @Override
    public Teacher queryTeacher(String name, String password) {
        return teacherMapper.queryTeacher(name,password);
    }

    @Override
    public List<Teacher> getTeacherList(Teacher teacher, int page, int limit) {
        return teacherMapper.getTeacherList(teacher,page,limit);
    }

    @Override
    public int getTeacherListTotal(Teacher teacher) {
        return teacherMapper.getTeacherListTotal(teacher);
    }

    @Override
    public void addTeacher(Teacher teacher) {
        teacherMapper.addTeacher(teacher);
    }

    @Override
    public void editTeacher(Teacher teacher) {
        teacherMapper.editTeacher(teacher);
    }

    @Override
    public void deleteTeacher(List<Integer> ids) {
        teacherMapper.deleteTeacher(ids);
    }

    @Override
    public void editPassword(Teacher teacher, String newPwd) {
        teacherMapper.editPassword(teacher,newPwd);
    }
}

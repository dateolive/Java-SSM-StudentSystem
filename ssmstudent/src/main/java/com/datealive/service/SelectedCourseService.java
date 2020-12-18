package com.datealive.service;

import com.datealive.entity.SelectedCourse;

import java.util.List;


public interface SelectedCourseService {

    List<SelectedCourse> getSelectedCourseList(SelectedCourse selectedCourse, int page, int limit);

    //获取课表总数
    int getSelectedCourseListTotal(SelectedCourse selectedCourse);


    SelectedCourse getSelectedCourseById( int id);

    //判断是否已选
    boolean isSelected(int student_id, int course_id);

    //增加选课信息
    void addSelectedCourse(SelectedCourse selectedCourse);

    //批量删除选课信息
    void deleteSelectedCourse(List<Integer> ids);

    //批量删除选课信息
    void deleteSelectedCourseById(int id);

    //修改选课成绩
    void editSelectedCourse(SelectedCourse selectedCourse);
}

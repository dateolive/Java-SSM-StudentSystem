package com.datealive.mapper;

import com.datealive.entity.SelectedCourse;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SelectedCourseMapper {

    //获取选课列表
    List<SelectedCourse> getSelectedCourseList(@Param("selectedCourse") SelectedCourse selectedCourse, @Param(value = "page") int page, @Param(value = "limit") int limit);

    SelectedCourse getSelectedCourseById(@Param("id") int id);

    //获取课表总数
    int getSelectedCourseListTotal(SelectedCourse selectedCourse);

    //判断是否已选
    int isSelected(@Param("student_id") int student_id,@Param("course_id") int course_id);

    //增加选课信息
    void addSelectedCourse(SelectedCourse selectedCourse);

    //批量删除选课信息
    int deleteSelectedCourse(@Param("ids") List<Integer> ids);

    //删除选课信息
    int deleteSelectedCourseById(@Param("id")int id);

    //修改选课成绩
    int editSelectedCourse(SelectedCourse selectedCourse);
}

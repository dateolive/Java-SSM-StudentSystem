package com.datealive.mapper;

import com.datealive.entity.Course;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CourseMapper {

    //获得课程列表
    List<Course> getCourseList(@Param("course") Course course,@Param("page") int page,@Param("limit") int limit);

    //获得课程总数
    int getCourseListTotal(Course course);

    //增加课程
    int addCourse(Course course);

    //编辑课程
    int editCourse(Course course);

    //删除课程
    int deleteCourse(@Param("ids") List<Integer> ids);

    //判断课程是否已满
    int isFull(@Param("course_id") int course_id);

    //更新该课程的可选数量加
    int updateCourseSelectedNum(@Param("course_id") int course_id );

    //更新该课程的可选数量减
    int updateCourseSelectedNumDe(@Param("course_id") int course_id );
}

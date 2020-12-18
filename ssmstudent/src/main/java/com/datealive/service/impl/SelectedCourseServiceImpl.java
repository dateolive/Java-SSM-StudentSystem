package com.datealive.service.impl;

import com.datealive.entity.SelectedCourse;
import com.datealive.mapper.SelectedCourseMapper;
import com.datealive.service.SelectedCourseService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class SelectedCourseServiceImpl implements SelectedCourseService {

    @Autowired(required = false)
    SelectedCourseMapper selectedCourseMapper;

    @Override
    public List<SelectedCourse> getSelectedCourseList(SelectedCourse selectedCourse, int page, int limit) {
        return selectedCourseMapper.getSelectedCourseList(selectedCourse,page,limit);
    }

    @Override
    public int getSelectedCourseListTotal(SelectedCourse selectedCourse) {
        return selectedCourseMapper.getSelectedCourseListTotal(selectedCourse);
    }

    @Override
    public SelectedCourse getSelectedCourseById(int id) {
        return selectedCourseMapper.getSelectedCourseById(id);
    }

    @Override
    public boolean isSelected(int student_id, int course_id) {
        return selectedCourseMapper.isSelected(student_id,course_id) == 0?false:true;
    }

    @Override
    public void addSelectedCourse(SelectedCourse selectedCourse) {
        selectedCourseMapper.addSelectedCourse(selectedCourse);
    }

    @Override
    public void deleteSelectedCourse(List<Integer> ids) {
        selectedCourseMapper.deleteSelectedCourse(ids);
    }

    @Override
    public void deleteSelectedCourseById(int id) {

            selectedCourseMapper.deleteSelectedCourseById(id);


    }

    @Override
    public void editSelectedCourse(SelectedCourse selectedCourse) {
        selectedCourseMapper.editSelectedCourse(selectedCourse);
    }
}

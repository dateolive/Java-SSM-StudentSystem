package com.datealive.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class SelectedCourse {

    private int id;
    private int student_id;
    private int teacher_id;
    private int course_id;
    private int score_id;
}

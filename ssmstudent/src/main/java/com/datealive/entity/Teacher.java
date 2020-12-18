package com.datealive.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class Teacher {

    private int id;
    private String sn;
    private String name;
    private String password;
    private int clazz_id;
    private String sex;
    private String tposition;
    private String salary;
}

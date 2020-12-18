package com.datealive.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@AllArgsConstructor
@NoArgsConstructor
@Data
public class Student {
    private  int id;
    private String sn;
    private String name;
    private String password;
    private int clazz_id;
    private String sex;
    private String mobile;
    private Integer age;
    private Integer totalgrade;
}

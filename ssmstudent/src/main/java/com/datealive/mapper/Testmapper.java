package com.datealive.mapper;

import com.datealive.entity.Test;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


@Mapper
public interface Testmapper {
    Test queryStudentTest(@Param(value = "name") String name, @Param(value = "password") String password);

}

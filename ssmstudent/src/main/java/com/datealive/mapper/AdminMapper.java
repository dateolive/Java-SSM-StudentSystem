package com.datealive.mapper;

import com.datealive.entity.Admin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


@Mapper
public interface AdminMapper {

    Admin queryAdmin(@Param(value = "name") String name,@Param(value ="password" ) String password);

    int deleteUser(int id);

    int editPassword(@Param("admin") Admin admin,@Param("newPwd") String newPwd);
}

package com.datealive.service.impl;

import com.datealive.entity.Admin;
import com.datealive.mapper.AdminMapper;
import com.datealive.service.AdminService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
@Slf4j
public class AdminServiceImpl implements AdminService {

    @Autowired(required = false)
    AdminMapper adminMapper;

    @Override
    public Admin queryAdmin(String name, String password) { return adminMapper.queryAdmin(name,password); }

    @Override
    public void editPassword(Admin admin, String newPwd) {
        adminMapper.editPassword(admin,newPwd);
    }
}

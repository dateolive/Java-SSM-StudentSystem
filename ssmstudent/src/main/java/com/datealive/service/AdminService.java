package com.datealive.service;

import com.datealive.entity.Admin;



public interface AdminService {

    Admin queryAdmin(String name, String password);

    void editPassword(Admin admin,String newPwd);

}

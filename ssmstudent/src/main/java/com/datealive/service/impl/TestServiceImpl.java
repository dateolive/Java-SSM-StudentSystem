package com.datealive.service.impl;

import com.datealive.entity.Test;
import com.datealive.mapper.Testmapper;
import com.datealive.service.TestService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
@Slf4j
public class TestServiceImpl implements TestService {

    @Autowired(required = false)
    Testmapper testmapper;

    @Override
    public Test queryStudentTest(String name, String password) {
        return testmapper.queryStudentTest(name,password);
    }
}

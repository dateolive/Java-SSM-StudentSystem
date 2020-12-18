package com.datealive.service.impl;

import com.datealive.entity.Clazz;
import com.datealive.mapper.ClazzMapper;
import com.datealive.service.ClazzService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
@Slf4j
public class ClazzServiceImpl implements ClazzService {

    @Autowired(required = false)
    ClazzMapper clazzMapper;
    @Override
    public List<Clazz> getClazzList(Clazz clazz, int page, int limit) {
        return clazzMapper.getClazzList(clazz,page,limit);

    }

    @Override
    public int getClazzListTotal(Clazz clazz) {
        return clazzMapper.getClazzListTotal(clazz);
    }

    @Override
    public void editClazz(Clazz clazz) {
        try {
            clazzMapper.editClazz(clazz);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("更新班级失败, clazz:{}, cause:{}", clazz, e);
        }
    }

    @Override
    public void addClazz(Clazz clazz) {
        clazzMapper.addClazz(clazz);
    }

    @Override
    public void deleteClazzAll(List<Integer> ids) {
        clazzMapper.deleteClazzAll(ids);
    }

    @Override
    public void deleteClazz(int id) {
        clazzMapper.deleteClazz(id);
    }
}

package com.cdgi.daoimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.cdgi.dao.ResultDao;
import com.cdgi.pojo.Result;
import com.cdgi.repository.ResultRepository;

@Repository
public class ResultDaoImpl implements ResultDao{

    @Autowired
    private ResultRepository resultRepository;

    @Override
    @Transactional
    public boolean saveResult(Result r) {

        try {
            resultRepository.save(r);
            return true;
        } 
        catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Result> getResultByUser(String email) {

        try {
            List<Result> list = resultRepository.findByEmail(email);
            return list;
        } 
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
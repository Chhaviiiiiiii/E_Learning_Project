package com.cdgi.dao;

import java.util.List;
import com.cdgi.pojo.Result;

public interface ResultDao {

    boolean saveResult(Result r);

    List<Result> getResultByUser(String email);

}
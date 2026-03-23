package com.cdgi.repository;

import java.util.List;
import org.springframework.data.repository.CrudRepository;
import com.cdgi.pojo.Result;

public interface ResultRepository extends CrudRepository<Result, Integer>{

    List<Result> findByEmail(String email);

}
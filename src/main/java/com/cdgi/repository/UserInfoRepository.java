package com.cdgi.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.cdgi.pojo.UserInfo;

public interface UserInfoRepository extends CrudRepository<UserInfo,String>{

	List<UserInfo> findByRole(String role); 
	
	    Optional<UserInfo> findByUsername(String username); 
	

}

package com.cdgi.dao;

import java.util.List;

import com.cdgi.pojo.UserInfo;

public interface UserInfoDao {

    boolean addNewUser(UserInfo u);

    UserInfo checkUserCredential(UserInfo u);

	List<UserInfo> getAllUsers();

	UserInfo getUserByUsername(String username);
	
}
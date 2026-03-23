package com.cdgi.daoimpl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

import com.cdgi.dao.UserInfoDao;
import com.cdgi.pojo.UserInfo;
import com.cdgi.repository.UserInfoRepository;

@Repository
@Transactional
public class UserInfoDaoImpl implements UserInfoDao {

    @Autowired
	private UserInfoRepository userInfoRepository;
	
     
	@Override
	public UserInfo checkUserCredential(UserInfo u) {
		
		try {
			Optional<UserInfo>op = userInfoRepository.findById(u.getEmail());
			if(op.isPresent())
			{
				if(op.get().getPassword().equals(u.getPassword()))
					return op.get();
				else
					return null;
			}
			else
				return null;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return null;
		}
		
	}

	@Override
	@Transactional
	public boolean addNewUser(UserInfo u) {
		try {
			Optional<UserInfo>op = userInfoRepository.findById(u.getUsername());
			if(op.isPresent())
			{
				return false;
			}
			else
			{
			userInfoRepository.save(u);
			return true;
			}
			
			
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public List<UserInfo> getAllUsers() {
		 try {
			 return (List<UserInfo>) userInfoRepository.findByRole("user");
		 } 
		 catch (Exception e) 
		 {
			 e.printStackTrace();
			 return null;
		 }
		
	}
	
	@Override
	public UserInfo getUserByUsername(String username) {
	    try {
	        Optional<UserInfo> op = userInfoRepository.findByUsername(username);
	        if(op.isPresent()) return op.get();
	        else return null;
	    } catch(Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}
	

}
package com.lhy.service.impl;

import com.lhy.dao.UserMapper;
import com.lhy.model.User;
import com.lhy.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 登录功能
     * @param username 用户名
     * @param password 密码
     * @return true:登录成功 false:登录失败
     */
    @Override
    public boolean login(String username, String password) {
        User user = userMapper.selectUserByUsername(username);
        if(user != null && user.getPassword().equals(password)){
            return true;
        } else {
            return false;
        }
    }

    @Override
    public int insertUser(String username, String password) {
        return userMapper.insertUser(username,password);
    }

    @Override
    public String selectUserImage(String username) {
        return userMapper.selectUserImage(username);
    }

    @Override
    public User selectUserMessage(String username) {
        return userMapper.selectUserByUsername(username);
    }

    @Override
    public int updateUserImage(String username, String image) {
        return userMapper.updateUserImage(username,image);
    }
}

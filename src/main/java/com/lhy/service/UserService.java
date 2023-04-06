package com.lhy.service;

import com.lhy.model.User;

public interface UserService {
    // 登录功能
    public boolean login(String username,String password);
    // 注册功能
    public int insertUser(String username,String password);
    //查询用户的图片
    public String selectUserImage(String username);
    //查询用户的信息
    public User selectUserMessage(String username);

    public int updateUserImage(String username,String image);
}

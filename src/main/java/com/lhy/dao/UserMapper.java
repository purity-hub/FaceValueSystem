package com.lhy.dao;

import com.lhy.model.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    //通过用户名查询用户
    public User selectUserByUsername(@Param("username") String username);
    //插入用户
    public int insertUser(@Param("username") String username, @Param("password") String password);
    //查询用户的图片
    public String selectUserImage(@Param("username") String username);

    public int updateUserImage(@Param("username") String username, @Param("image") String image);
}

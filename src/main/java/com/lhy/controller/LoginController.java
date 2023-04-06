package com.lhy.controller;

import com.lhy.service.UserService;
import com.lhy.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    //登录
    @RequestMapping("/login")
    @ResponseBody
    public String login(@RequestParam("username") String username, @RequestParam("password") String password, HttpSession session){
        if(userService.login(username,password)){
            session.setAttribute("username",username);
            return "success";
        } else {
            return "false";
        }
    }
    @RequestMapping("/register")
    @ResponseBody
    public String register(@RequestParam("username") String username,@RequestParam("password") String password,HttpSession session){
        int i = userService.insertUser(username, password);
        if(i>0){
            session.setAttribute("username",username);
            return "success";
        }else{
            return "false";
        }
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.removeAttribute("username");
        return "redirect:/loginview";
    }


}

package com.lhy.controller;

import com.lhy.model.User;
import com.lhy.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class ViewController {
    @Autowired
    private UserService userService;

    @RequestMapping("/loginview")
    public String loginview(){
        return "login";
    }

    @RequestMapping("/index")
    public String Index(){
        return "index";
    }

    @RequestMapping("/uploadFace")
    public String uploadFace(){
        return "pages/uploadFace";
    }

    @RequestMapping("/teamFace")
    public String teamFace(){
        return "pages/team";
    }
    @RequestMapping("/mymessage")
    public String mymessage(HttpSession session, Model model){
        String username = (String) session.getAttribute("username");
        if(username == null){
            return "redirect:/loginview";
        }
        User user = userService.selectUserMessage(username);
        model.addAttribute("user",user);
        return "pages/usermessage";
    }

    @RequestMapping("/facelist")
    public String facelist(){
        return "pages/facelist";
    }
    @RequestMapping("/pageindex")
    public String pageindex(){
        return "pages/index";
    }
    @RequestMapping("/onlinepk")
    public String onlinepk(){
        return "pages/websocket";
    }
}

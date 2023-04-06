package com.lhy.controller;

import com.lhy.model.TeamPeople;
import com.lhy.service.TeamPeopleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class TeamPeopleController {

    @Autowired
    private TeamPeopleService teamPeopleService;

    @RequestMapping("/teamPeople")
    @ResponseBody
    public Map<String,Object> TeamPeople(int teamId){
        List<TeamPeople> teamPeople = teamPeopleService.selectTeamPeople(teamId);
        Map<String,Object> map = new HashMap<>();
        map.put("teamPeople",teamPeople);
        //返回对象至ajax数据至前端
        return map;
    }
}

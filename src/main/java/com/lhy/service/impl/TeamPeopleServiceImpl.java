package com.lhy.service.impl;

import com.lhy.dao.TeamPeopleMapper;
import com.lhy.model.TeamPeople;
import com.lhy.service.TeamPeopleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeamPeopleServiceImpl implements TeamPeopleService {
    @Autowired
    private TeamPeopleMapper teamPeopleMapper;

    @Override
    public int insertTeamPeople(TeamPeople teamPeople) {
        return teamPeopleMapper.insertTeamPeople(teamPeople);
    }

    @Override
    public List<TeamPeople> selectTeamPeople(int teamId) {
        return teamPeopleMapper.selectTeamPeople(teamId);
    }
}

package com.lhy.service.impl;

import com.lhy.dao.TeamMapper;
import com.lhy.model.Team;
import com.lhy.service.TeamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeamServiceImpl implements TeamService {

    @Autowired
    private TeamMapper teamMapper;

    @Override
    public int insertTeam(Team team) {
        return teamMapper.insertTeam(team);
    }

    @Override
    public List<Team> selectTeamAll() {
        return teamMapper.selectTeamAll();
    }

    @Override
    public int updateTeamScore(Double score, int id) {
        return teamMapper.updateTeamScore(score,id);
    }

    @Override
    public int selectMaxId() {
        return teamMapper.selectMaxId();
    }
}

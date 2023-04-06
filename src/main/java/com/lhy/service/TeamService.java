package com.lhy.service;

import com.lhy.model.Team;

import java.util.List;

public interface TeamService {
    public int insertTeam(Team team);

    public List<Team> selectTeamAll();

    public int updateTeamScore(Double score,int id);

    public int selectMaxId();
}

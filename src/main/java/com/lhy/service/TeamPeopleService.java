package com.lhy.service;

import com.lhy.model.TeamPeople;

import java.util.List;

public interface TeamPeopleService {
    public int insertTeamPeople(TeamPeople teamPeople);

    List<TeamPeople> selectTeamPeople(int teamId);
}

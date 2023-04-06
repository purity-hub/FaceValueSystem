package com.lhy.dao;

import com.lhy.model.TeamPeople;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TeamPeopleMapper {
    public int insertTeamPeople(TeamPeople teamPeople);

    public List<TeamPeople> selectTeamPeople(@Param("teamId") int teamId);
}

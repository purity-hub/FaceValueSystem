package com.lhy.dao;

import com.lhy.model.Team;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TeamMapper {
    public int insertTeam(Team team);

    public List<Team> selectTeamAll();

    public int updateTeamScore(@Param("score")Double score, @Param("id") int id);

    public int selectMaxId();
}

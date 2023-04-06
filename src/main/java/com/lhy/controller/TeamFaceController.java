package com.lhy.controller;

import com.alibaba.fastjson.JSON;
import com.lhy.model.FaceV3DetectBean;
import com.lhy.model.Team;
import com.lhy.model.TeamPeople;
import com.lhy.service.TeamPeopleService;
import com.lhy.service.TeamService;
import com.lhy.utils.FaceSpot;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class TeamFaceController {

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    private TeamService teamService;

    @Autowired
    private TeamPeopleService teamPeopleService;

    @RequestMapping(value = "/queryTeam")
    public String teamFace(Model model) {
        //排行榜
        List<Team> teams = teamService.selectTeamAll();
        model.addAttribute("teams", teams);
        return "pages/facelist";
    }

    @RequestMapping("/teamFacelist")
    public String teamFace(@RequestParam(value = "file1") MultipartFile[] files1,
                           @RequestParam(value = "file2") MultipartFile[] files2,
                           @RequestParam(value = "name1") String name1,
                           @RequestParam(value = "name2") String name2,HttpSession session) {
        //files1数组不为空
        if (files1[0].getSize()!=0 && files2[0].getSize()!=0) {
            double score1 = 0;//团队1-分数
            double score2 = 0;//团队2-分数
            //team1
            Team team1 = new Team();
            team1.setName(name1);
            team1.setName(name1);
            team1.setScore(score1);
            teamService.insertTeam(team1);
            int teamid1 = teamService.selectMaxId();
            //team2
            Team team2 = new Team();
            team2.setName(name2);
            team2.setScore(score2);
            teamService.insertTeam(team2);
            int teamid2 = teamService.selectMaxId();
            for(MultipartFile file:files1) {
                String fileName = FaceSpot.saveFile(file, uploadPath+"\\team");
                byte[] byface = FaceSpot.FileToByte(file);
                String str = FaceSpot.detectFace(byface, "1");
                JSON json = JSON.parseObject(str);
                FaceV3DetectBean bean = JSON.toJavaObject(json, FaceV3DetectBean.class);
                double beautyOne = 0;
                TeamPeople teamPeople = new TeamPeople();
                for (int i = 0; i < bean.getResult().getFace_list().size(); i++) {
                    // 获取美丑打分
                    beautyOne = (Double) bean.getResult().getFace_list().get(i).getBeauty();
                    int ageOne = bean.getResult().getFace_list().get(i).getAge();
                    String gender = bean.getResult().getFace_list().get(i).getGender().getType();
                    String glasses = bean.getResult().getFace_list().get(i).getGlasses().getType();
                    String expression = bean.getResult().getFace_list().get(i).getExpression().getType();
                    teamPeople.setTeamId(teamid1);
                    teamPeople.setAge(ageOne);
                    teamPeople.setBeauty(beautyOne);
                    teamPeople.setGender(gender);
                    teamPeople.setGlasses(glasses);
                    teamPeople.setExpression(expression);
                    teamPeople.setImgPath("http://localhost:8080/FaceValueSystem_war_exploded/upload/team/"+fileName);
                }
                teamPeopleService.insertTeamPeople(teamPeople);
                score1 += beautyOne;
            }
            score1 = score1/files1.length;
            teamService.updateTeamScore(score1,teamid1);
            for(MultipartFile file:files2) {
                String fileName = FaceSpot.saveFile(file, uploadPath);
                byte[] byface = FaceSpot.FileToByte(file);
                String str = FaceSpot.detectFace(byface, "1");
                JSON json = JSON.parseObject(str);
                FaceV3DetectBean bean = JSON.toJavaObject(json, FaceV3DetectBean.class);
                double beautyOne = 0;
                TeamPeople teamPeople = new TeamPeople();
                for (int i = 0; i < bean.getResult().getFace_list().size(); i++) {
                    // 获取美丑打分
                    beautyOne = (Double) bean.getResult().getFace_list().get(i).getBeauty();
                    int ageOne = bean.getResult().getFace_list().get(i).getAge();
                    String gender = bean.getResult().getFace_list().get(i).getGender().getType();
                    String glasses = bean.getResult().getFace_list().get(i).getGlasses().getType();
                    String expression = bean.getResult().getFace_list().get(i).getExpression().getType();
                    teamPeople.setTeamId(teamid2);
                    teamPeople.setAge(ageOne);
                    teamPeople.setBeauty(beautyOne);
                    teamPeople.setGender(gender);
                    teamPeople.setGlasses(glasses);
                    teamPeople.setExpression(expression);
                    teamPeople.setImgPath("http://localhost:8080/FaceValueSystem_war_exploded/upload/"+fileName);
                }
                teamPeopleService.insertTeamPeople(teamPeople);
                score2 += beautyOne;
            }
            score2 = score2/files2.length;
            teamService.updateTeamScore(score2,teamid2);
            session.setAttribute("tname1",name1);
            session.setAttribute("tname2",name2);
            session.setAttribute("score1",score1);
            session.setAttribute("score2",score2);
        }
        return "redirect:/queryTeam";
    }
}

package com.lhy.model;

public class TeamPeople {
    private Integer id;
    private Integer teamId;
    private Integer age;
    private Double beauty;
    private String expression;
    private String gender;
    private String glasses;
    private String imgPath;

    public TeamPeople() {
    }

    public TeamPeople(Integer id, Integer teamId, Integer age, Double beauty, String expression, String gender, String glasses, String imgPath) {
        this.id = id;
        this.teamId = teamId;
        this.age = age;
        this.beauty = beauty;
        this.expression = expression;
        this.gender = gender;
        this.glasses = glasses;
        this.imgPath = imgPath;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getTeamId() {
        return teamId;
    }

    public void setTeamId(Integer teamId) {
        this.teamId = teamId;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Double getBeauty() {
        return beauty;
    }

    public void setBeauty(Double beauty) {
        this.beauty = beauty;
    }

    public String getExpression() {
        return expression;
    }

    public void setExpression(String expression) {
        this.expression = expression;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getGlasses() {
        return glasses;
    }

    public void setGlasses(String glasses) {
        this.glasses = glasses;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }
}

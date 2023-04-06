package com.lhy.service;

import com.lhy.model.Face;

import java.util.List;

/**
 * <p>Title: FaceService.java</p>
 * @author smallFish
 * @version 1.0
 * <p>功能描述: </p>
 */
public interface FaceService {
	public int insertFact(Face face);
	public int deleteFact(Face face);
	public int updateFact(Face face);
	public int selectFactID(Face face);
	public List<Face> selectFactAll( );
}


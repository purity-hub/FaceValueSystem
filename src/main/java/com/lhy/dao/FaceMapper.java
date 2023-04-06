package com.lhy.dao;

import com.lhy.model.Face;

import java.util.List;

/**
 * <p>Title: FaceMapper.java</p>
 * @author smallFish
 * @version 1.0
 * <p>功能描述: </p>
 */
public interface FaceMapper {
	public int insertFace(Face face );
	public List<Face> selectFaceAll();
}


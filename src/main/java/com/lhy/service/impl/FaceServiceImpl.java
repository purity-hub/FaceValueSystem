package com.lhy.service.impl;

import com.lhy.dao.FaceMapper;
import com.lhy.model.Face;
import com.lhy.service.FaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>Title: FaceServiceImpl.java</p>
 * @author smallFish
 * @version 1.0
 * <p>功能描述: </p>
 */
@Service
public class FaceServiceImpl implements FaceService{

	@Autowired
	private FaceMapper faceMapper;

	@Override
	public int insertFact(Face face) {
		// TODO Auto-generated method stub
		return faceMapper.insertFace(face);
	}

	@Override
	public int deleteFact(Face face) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateFact(Face face) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int selectFactID(Face face) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Face> selectFactAll() {
		// TODO Auto-generated method stub
		return faceMapper.selectFaceAll();
	}

}


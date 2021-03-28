package com.cofac.treat.ora.biz.non;

import java.util.HashMap;
import java.util.List;

import startkr.basic.common.BasicBiz;
import startkr.util.CrytoUtils;

public class FloorBiz extends BasicBiz {
	/* 기본기능 : 시작 */
	// 목록 조회
	public HashMap selectFloorPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("floor.selectFloorCount", paramMap);
			List list = sqlMap.queryForList("floor.selectFloorList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectFloorList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("floor.selectFloorList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 내용 조회
	public HashMap selectFloor(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("floor.selectFloor", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	// 추가
	public Boolean insertFloor( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "floor.insertFloor", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updateFloor( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "floor.updateFloor", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteFloor( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "floor.deleteFloor", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	/* 기본기능 : 끝 */
}

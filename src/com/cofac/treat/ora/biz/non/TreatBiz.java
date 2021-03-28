package com.cofac.treat.ora.biz.non;

import java.util.HashMap;
import java.util.List;

import com.cofac.treat.ora.common.MysqlBiz;
import startkr.util.CrytoUtils;

public class TreatBiz extends MysqlBiz {

	/* 기본기능 : 시작 */
	// 목록 조회
	public HashMap selectTreatPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("treat.selectTreatCount", paramMap);
			List list = sqlMap.queryForList("treat.selectTreatList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectTreatList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("treat.selectTreatList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List selectTreatSingleList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("treat.selectTreatSingleList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List selectTreatMultiList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("treat.selectTreatMultiList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 내용 조회
	public HashMap selectTreat(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("treat.selectTreat", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}
	
	public HashMap selectTreatDupl(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("treat.selectTreatDupl", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	// 추가
	public Boolean insertTreat( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "treat.insertTreat", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updateTreat( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "treat.updateTreat", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteTreat( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "treat.deleteTreat", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public List selectRankingList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("treat.selectRankingList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public HashMap selectRank(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("treat.selectRank", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	public Integer selectEMRTreatByEMRKey(HashMap paramMap) {
		Integer treatmentCount = 0;
		try {
			treatmentCount = (Integer) sqlMap.queryForObject("treat.selectEMRTreatByEMRKey", paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return treatmentCount;
	}

	public Integer selectEMRTreatByPatientId(HashMap paramMap) {
		Integer treatmentCount = 0;
		try {
			treatmentCount = (Integer) sqlMap.queryForObject("treat.selectEMRTreatByPatientId", paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return treatmentCount;
	}
}

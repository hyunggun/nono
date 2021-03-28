package com.cofac.treat.ora.biz.interlinked;

import java.util.HashMap;
import java.util.List;

import com.cofac.treat.ora.common.OracleBiz;

public class TreatBiz extends OracleBiz {

	/* Treat 기본기능 : 시작 */
	// 목록 페이징 조회
	public HashMap selectTreatPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("oratreat.selectTreatCount", paramMap);
			List list = sqlMap.queryForList("oratreat.selectTreatList", paramMap );

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
			list = sqlMap.queryForList("oratreat.selectTreatList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	// 단건 조회
	public HashMap selectTreat(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("oratreat.selectTreat", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	/* Treat 기본기능 : 종료 */
	
	public HashMap selectEmrCountPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer acceptCount = (Integer) sqlMap.queryForObject("oratreat.selectTreatCount", paramMap);
//			Integer inpatientCount = (Integer) sqlMap.queryForObject("inpatient.selectInpatientCount", paramMap);

			resultMap.put("treatCount", acceptCount);
//			resultMap.put("inpatientCount", inpatientCount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	
//수술실뷰
 public List selectTreatOperation(HashMap paramMap) {
   List list = null;
   try {
     list = sqlMap.queryForList("oratreat.selectOperationList", paramMap );
   } catch (Exception e) {
     e.printStackTrace();
   }
   return list;
 }
 
 // 섬머리뷰 조회
 public List selectWaitingList(HashMap paramMap) {
   List list = null;
   try {
     list = sqlMap.queryForList("oratreat.selectWaitingList", paramMap );
   } catch (Exception e) {
     e.printStackTrace();
   }
   return list;
 }
}

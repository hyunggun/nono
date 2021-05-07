package com.cofac.treat.ora.biz.interlinked;

import java.util.HashMap;
import java.util.List;

//연결할 DB종류에 맞춰서 상속받아 사용
import com.cofac.treat.ora.common.OracleBiz;
import com.cofac.treat.ora.common.MssqlBiz;
import com.cofac.treat.ora.common.MysqlBiz;

public class TreatBiz extends OracleBiz {

	/* Treat 기본기능 : 시작 */
	// 목록 페이징 조회
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


	// 단건 조회
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

	/* Treat 기본기능 : 종료 */
	
	public HashMap selectEmrCountPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer acceptCount = (Integer) sqlMap.queryForObject("treat.selectTreatCount", paramMap);
//			Integer inpatientCount = (Integer) sqlMap.queryForObject("inpatient.selectInpatientCount", paramMap);

			resultMap.put("treatCount", acceptCount);
//			resultMap.put("inpatientCount", inpatientCount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	public HashMap selectTreatCheckPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("treat.selectTreatCheckCount", paramMap);
			List list = sqlMap.queryForList("treat.selectTreatCheckList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	public List selectTreatCheckList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("treat.selectTreatCheckList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
//수술실뷰
 public List selectTreatOperation(HashMap paramMap) {
   List list = null;
   try {
     list = sqlMap.queryForList("treat.selectOperationList", paramMap );
   } catch (Exception e) {
     e.printStackTrace();
   }
   return list;
 }
 
 // 섬머리뷰 조회
 public List selectWaitingList(HashMap paramMap) {
   List list = null;
   try {
     list = sqlMap.queryForList("treat.selectWaitingList", paramMap );
   } catch (Exception e) {
     e.printStackTrace();
   }
   return list;
 }
 
 // 수정
 public Boolean updateTreatFlag( HashMap paramMap ) {
   Boolean isSuccess = false;
   try {
     sqlMap.update( "treat.updateTreatFlag", paramMap );
     isSuccess = true;
   } catch (Exception e) {
     // TODO: handle exception
     e.printStackTrace();
   }
   return isSuccess;
 }
}

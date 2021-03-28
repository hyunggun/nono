package com.cofac.treat.ora.biz.non;

import java.util.HashMap;
import java.util.List;

import com.cofac.treat.ora.common.MysqlBiz;;

public class TestemrBiz extends MysqlBiz {

	/* Treat 기본기능 : 시작 */
	// 목록 페이징 조회
	public HashMap selectTreatPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
		  System.out.println(1);
			Integer count = (Integer) sqlMap.queryForObject("testemr.selectTreatCount", paramMap);
			List list = sqlMap.queryForList("testemr.selectTreatList", paramMap );

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
			list = sqlMap.queryForList("testemr.selectTreatList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	// 단건 조회
	public HashMap selectTreat(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("testemr.selectTreat", paramMap);
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
		  System.out.println(2);
			Integer acceptCount = (Integer) sqlMap.queryForObject("testemr.selectTreatCount", paramMap);
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
			Integer count = (Integer) sqlMap.queryForObject("testemr.selectTreatCheckCount", paramMap);
			List list = sqlMap.queryForList("testemr.selectTreatCheckList", paramMap );

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
			list = sqlMap.queryForList("testemr.selectTreatCheckList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
//수술실뷰
 public List selectTreatOperation(HashMap paramMap) {
   List list = null;
   try {
     list = sqlMap.queryForList("testemr.selectOperationList", paramMap );
   } catch (Exception e) {
     e.printStackTrace();
   }
   return list;
 }
 
 // 섬머리뷰 조회
 public List selectWaitingList(HashMap paramMap) {
   List list = null;
   try {
     list = sqlMap.queryForList("testemr.selectWaitingList", paramMap );
   } catch (Exception e) {
     e.printStackTrace();
   }
   return list;
 }
 // 수정
 public Boolean updateTreatFlag( HashMap paramMap ) {
   Boolean isSuccess = false;
   try {
     sqlMap.update( "testemr.updateTreatFlag", paramMap );
     isSuccess = true;
   } catch (Exception e) {
     // TODO: handle exception
     e.printStackTrace();
   }
   return isSuccess;
 }
 
}

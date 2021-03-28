package com.cofac.treat.ora.biz.interlinked;

import java.util.HashMap;
import java.util.List;

import com.cofac.treat.ora.common.OracleBiz;

public class InpatientBiz extends OracleBiz {
	
	/* Inpatient 기본기능 : 시작 */
	// 목록 페이징 조회
	public HashMap selectInpatientPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("inpatient.selectInpatientCount", paramMap);
			List list = sqlMap.queryForList("inpatient.selectInpatientList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectInpatientList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("inpatient.selectInpatientList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 단건 조회
	public HashMap selectInpatient(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("inpatient.selectInpatient", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}
	/* Inpatient 기본기능 : 종료 */
	
	public HashMap selectInpatientCountForADST(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			
			paramMap.put("ADST", "A");
			Integer count = (Integer) sqlMap.queryForObject("inpatient.selectInpatientCountForADST", paramMap);
			resultMap.put("allCount", count); //재원
			
			paramMap.put("ADDT","Y");
			count = (Integer) sqlMap.queryForObject("inpatient.selectInpatientCountForADST", paramMap);
			resultMap.put("inCount", count); //금일 입원
			
			paramMap.put("ADST", "D");
			paramMap.put("DSDT","Y");
			paramMap.put("ADDT", "");
			count = (Integer) sqlMap.queryForObject("inpatient.selectInpatientCountForADST", paramMap);
			resultMap.put("outCount", count); //금일 퇴원
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	// 침대 순번 조회
	public HashMap selectBedpos(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("inpatient.selectBedpos", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}
	// 수정
	public Boolean upsertBedpos( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "inpatient.upsertBedpos", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
}

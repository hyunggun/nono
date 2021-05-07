package com.cofac.treat.ora.biz.interlinked;

import java.util.HashMap;
import java.util.List;

//연결할 DB종류에 맞춰서 상속받아 사용
import com.cofac.treat.ora.common.MssqlBiz;
import com.cofac.treat.ora.common.MysqlBiz;
import com.cofac.treat.ora.common.OracleBiz;

public class PatientBiz extends OracleBiz {
	

	/* Patient 기본기능 : 시작 */
	// 목록 페이징 조회
	public HashMap selectPatientPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("patient.selectPatientCount", paramMap);
			List list = sqlMap.queryForList("patient.selectPatientList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectPatientList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("patient.selectPatientList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 단건 조회
	public HashMap selectPatient(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("patient.selectPatient", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}
	/* Patient 기본기능 : 종료 */
	
	public HashMap selectPatientCountForADST(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			
			paramMap.put("ADST", "A");
			Integer count = (Integer) sqlMap.queryForObject("patient.selectPatientCountForADST", paramMap);
			resultMap.put("allCount", count); //�옱�썝
			
			paramMap.put("ADDT","Y");
			count = (Integer) sqlMap.queryForObject("patient.selectPatientCountForADST", paramMap);
			resultMap.put("inCount", count); //湲덉씪 �엯�썝
			
			paramMap.put("ADST", "D");
			paramMap.put("DSDT","Y");
			paramMap.put("ADDT", "");
			count = (Integer) sqlMap.queryForObject("patient.selectPatientCountForADST", paramMap);
			resultMap.put("outCount", count); //湲덉씪 �눜�썝
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	// 移⑤� �닚踰� 議고쉶
	public HashMap selectBedpos(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("patient.selectBedpos", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}
	// �닔�젙
	public Boolean upsertBedpos( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "patient.upsertBedpos", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
}

package com.cofac.treat.ora.biz.non;

import java.util.HashMap;
import java.util.List;

import com.cofac.treat.ora.common.MssqlBiz;
import com.cofac.treat.ora.common.MysqlBiz;

public class PatientBiz extends MysqlBiz {

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
	
	public HashMap selectPatientCountPage(HashMap paramMap) {
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
	
	public Boolean insertPatient( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "patient.insertPatient", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updatePatient( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "patient.updatePatient", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deletePatient( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "patient.deletePatient", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	/* Patient 기본기능 : 종료 */
	
	public int selectPatientIdByCode(HashMap paramMap) {
		int patient_id = 0;
		try {
			patient_id = (int) sqlMap.queryForObject("patient.selectPatientIdByCode", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return patient_id;
	}
}

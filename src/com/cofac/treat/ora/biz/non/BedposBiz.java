package com.cofac.treat.ora.biz.non;

import java.util.HashMap;
import com.cofac.treat.ora.common.MysqlBiz;

public class BedposBiz extends MysqlBiz {
	/**
	 * bedpos
	 * @param paramMap room_no(3WD 301) , patient_no (0072636)
	 * @return int bedpos
	 */
	// select
	public HashMap selectBedpos(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("bedpos.selectBedpos", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}
	// update
	public Boolean upsertBedpos( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "bedpos.upsertBedpos", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	// maxCnt
	public HashMap selectMaxCnt(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("bedpos.selectMaxCnt", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}
}

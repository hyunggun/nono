package com.cofac.treat.ora.biz.non;

import java.util.HashMap;
import java.util.List;

import com.cofac.treat.ora.common.MssqlBiz;
import com.cofac.treat.ora.common.MysqlBiz;

public class OperationBiz extends MysqlBiz {

	/* Operation 기본기능 : 시작 */
	// 목록 페이징 조회
	public HashMap selectOperationPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("operation.selectOperationCount", paramMap);
			List list = sqlMap.queryForList("operation.selectOperationList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	public HashMap selectOperationCountPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("operation.selectOperationCount", paramMap);

			resultMap.put("count", count);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectOperationList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("operation.selectOperationList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 단건 조회
	public HashMap selectOperation(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("operation.selectOperation", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}
	
	public Boolean insertOperation( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "operation.insertOperation", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updateOperation( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "operation.updateOperation", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteOperation( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "operation.deleteOperation", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	/* Operation 기본기능 : 종료 */
	
	public int selectOperationIdByCode(HashMap paramMap) {
		int operation_id = 0;
		try {
			operation_id = (int) sqlMap.queryForObject("operation.selectOperationIdByCode", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return operation_id;
	}
}

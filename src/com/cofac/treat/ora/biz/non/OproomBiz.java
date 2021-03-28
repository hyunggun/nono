package com.cofac.treat.ora.biz.non;

import java.util.HashMap;
import java.util.List;

import com.cofac.treat.ora.common.MysqlBiz;
import startkr.util.CrytoUtils;

public class OproomBiz extends MysqlBiz {

	/* 기본기능 : 시작 */
	// 목록 조회
	public HashMap selectOproomPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("oproom.selectOproomCount", paramMap);
			List list = sqlMap.queryForList("oproom.selectOproomList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectOproomOperation(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("oproom.selectOproomList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 내용 조회
	public HashMap selectOproom(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("oproom.selectOproom", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	// 추가
	public Boolean insertOproom( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "oproom.insertOproom", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updateOproom( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "oproom.updateOproom", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteOproom( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "oproom.deleteOproom", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	/* 기본기능 : 끝 */
	
  //추가기능
  public HashMap selectOproomByCode(HashMap paramMap) {
    HashMap resultMap = new HashMap();
    try {
      resultMap = (HashMap) sqlMap.queryForObject("oproom.selectOproomByCode", paramMap);
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return resultMap;
  }
  
  public HashMap selectOproomDoctorPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("oproom.selectOproomDoctorCount", paramMap);
			List list = sqlMap.queryForList("oproom.selectOproomDoctorList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectOproomDoctorList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("oproom.selectOproomDoctorList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List selectOproomDoctorMultiList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("oproom.selectOproomDoctorMultiList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 내용 조회
	public HashMap selectOproomDoctor(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("oproom.selectOproomDoctor", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}
	
	public HashMap selectOproomDoctorDupl(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("oproom.selectOproomDoctorDupl", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	// 추가
	public Boolean insertOproomDoctor( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "oproom.insertOproomDoctor", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteOproomDoctor( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "oproom.deleteOproomDoctor", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public Boolean deleteOproomDoctorByOproomId( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "oproom.deleteOproomDoctorByOproomId", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public Boolean deleteOproomMachine( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "oproom.deleteOproomMachine", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
}

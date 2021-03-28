package com.cofac.treat.ora.biz.non;

import java.util.HashMap;
import java.util.List;

import com.cofac.treat.ora.common.MysqlBiz;
import startkr.util.CrytoUtils;

public class RoomBiz extends MysqlBiz {

	/* 기본기능 : 시작 */
	// 목록 조회
	public HashMap selectRoomPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("room.selectRoomCount", paramMap);
			List list = sqlMap.queryForList("room.selectRoomList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectRoomList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("room.selectRoomList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 내용 조회
	public HashMap selectRoom(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("room.selectRoom", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	// 추가
	public Boolean insertRoom( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "room.insertRoom", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updateRoom( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "room.updateRoom", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteRoom( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "room.deleteRoom", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	/* 기본기능 : 끝 */
	
  //추가기능
  public HashMap selectRoomByCode(HashMap paramMap) {
    HashMap resultMap = new HashMap();
    try {
      resultMap = (HashMap) sqlMap.queryForObject("room.selectRoomByCode", paramMap);
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return resultMap;
  }
  
  public HashMap selectRoomDoctorPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("room.selectRoomDoctorCount", paramMap);
			List list = sqlMap.queryForList("room.selectRoomDoctorList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectRoomDoctorList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("room.selectRoomDoctorList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List selectRoomDoctorMultiList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("room.selectRoomDoctorMultiList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List selectRoomDoctorForSum(HashMap paramMap) {
	  List list = null;
	  try {
	    list = sqlMap.queryForList("room.selectRoomDoctorForSum", paramMap );
	  } catch (Exception e) {
	    e.printStackTrace();
	  }
	  return list;
	}

	// 내용 조회
	public HashMap selectRoomDoctor(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("room.selectRoomDoctor", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}
	
	public HashMap selectRoomDoctorDupl(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("room.selectRoomDoctorDupl", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	// 추가
	public Boolean insertRoomDoctor( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "room.insertRoomDoctor", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteRoomDoctor( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "room.deleteRoomDoctor", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public Boolean deleteRoomDoctorByRoomId( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "room.deleteRoomDoctorByRoomId", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public Boolean deleteRoomMachine( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "room.deleteRoomMachine", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public List selectRoomStatus(HashMap paramMap) {
    List list = null;
    try {
      list = sqlMap.queryForList("room.selectRoomStatus", paramMap );
    } catch (Exception e) {
      e.printStackTrace();
    }
    return list;
  }
}

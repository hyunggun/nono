package com.cofac.treat.ora.biz.non;

import java.util.HashMap;
import java.util.List;

import startkr.util.CrytoUtils;
import com.cofac.treat.ora.common.MysqlBiz;

public class UserBiz extends MysqlBiz {
	private static final String CRYPTO_KEY = "cf-user";

	/* user 기본기능 : 시작 */
	// 목록 페이징 조회
	public HashMap selectUserPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("user.selectUserCount", paramMap);
			List list = sqlMap.queryForList("user.selectUserList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectUserList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("user.selectUserList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 단건 조회
	public HashMap selectUser(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("user.selectUser", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	// 추가
	public Boolean insertUser( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			String sign_id = (String) paramMap.get("sign_id");
			String role = (String) paramMap.get("role");

			CrytoUtils bcrypt = new CrytoUtils();
			String fstpassword = bcrypt.getBCrypt(sign_id);
			paramMap.put("password", fstpassword);
			
			sqlMap.insert( "user.insertUser", paramMap );
			
			Integer new_user_id = (Integer) sqlMap.queryForObject("user.selectMaxUserId");
			if(new_user_id > 0 && role != null ) {
				if(role.equals("D")) {
					paramMap.put("doctor_id", new_user_id);
					sqlMap.insert( "user.insertDoctor", paramMap );
				} else if(role.equals("N")) {
					paramMap.put("nurse_id", new_user_id);
					sqlMap.insert( "user.insertNurse", paramMap );
				}
				isSuccess = true;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
    
	// 수정
	public Boolean updateUser( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "user.updateUser", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteUser( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "user.deleteUser", paramMap );
			
			String  user_id = (String) paramMap.get(" user_id");
			String role = (String) paramMap.get("role");
			if(role != null ) {
				if(role.equals("D")) {
					paramMap.put("doctor_id", user_id);
					sqlMap.delete( "user.deleteDoctor", paramMap );
				} else if(role.equals("N")) {
					paramMap.put("nurse_id",  user_id);
					sqlMap.delete( "user.deleteNurse", paramMap );
				}
			}
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	/* user 기본 기능 : 종료 */
	
	/* user 추가 기능 : 시작 */
	// 로그인 체크, 회원가입 중복 체크
	public HashMap checkUser(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		int result = 0; // 에러
		try {
			resultMap = (HashMap) sqlMap.queryForObject("user.selectUser", paramMap);
			if( resultMap != null ) {
				String dbUseFlag = (String) resultMap.get("use_fg");
				if( dbUseFlag == null  || dbUseFlag.equals("N")) {
					resultMap.put("checkUser", "Closed");
					result = 4; // 해당 아이디 사용자 휴면
				} else {
					resultMap.put("checkUser", "Valid");
					String dbPasswd = (String) resultMap.get("password");
					if( dbPasswd != null && !dbPasswd.isEmpty() ) {
						String reqPasswd = (String) paramMap.get("password");
						CrytoUtils bcrypt = new CrytoUtils();
						boolean istrue = bcrypt.compareBCrypt(reqPasswd, dbPasswd);
						if( istrue ) {
							resultMap.put("checkPasswd", "Right");
							result = 1; // 아이디, 암호 일치
						} else {
							resultMap.put("checkPasswd", "Wrong");
							result = 2; // 아이디 일치, 암호 불일치
						}
					} else {
						resultMap.put("checkPasswd", "None");
						result = 5; // 아이디 일치, 암호 없음 / 에러 상황
					}
				}
			} else {
				resultMap = new HashMap();
				resultMap.put("checkUser", "None");
				result = 3; // 해당 아이디 사용자 없음
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		resultMap.put("result", result);

		return resultMap;
	}
	// 사용자 휴먼 처리
	public Boolean dormancyUser( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "user.dormancyUser", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	// 사용자 암호 초기화
	public Boolean resetPassword( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			String sign_id = (String) paramMap.get("sign_id");
			CrytoUtils bcrypt = new CrytoUtils();
			String tmppassword = bcrypt.getBCrypt(sign_id);
			paramMap.put("password", tmppassword);
			
			sqlMap.update( "user.resetPassword", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	/* user 추가 기능 : 종료 */
	
	/* doctor 기본 기능 : 시작 */
	// 목록 페이징 조회
	public HashMap selectDoctorPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("user.selectDoctorCount", paramMap);
			List list = sqlMap.queryForList("user.selectDoctorList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	// 목록 조회
	public List selectDoctorList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("user.selectDoctorList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 단건 조회
	public HashMap selectDoctor(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("user.selectDoctor", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	// 추가
	public Boolean insertDoctor( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
//			String  user_id = (String) paramMap.get(" user_id");
//			paramMap.put("doctor_id", user_id);
			sqlMap.insert( "user.insertDoctor", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
    
	// 수정
	public Boolean updateDoctor( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "user.updateDoctor", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteDoctor( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "user.deleteDoctor", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	/* doctor 기본 기능 : 종료 */
	
	/* nurse 기본 기능 : 시작 */
	// 목록 페이징 조회
	public HashMap selectNursePage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("user.selectNurseCount", paramMap);
			List list = sqlMap.queryForList("user.selectNurseList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	
	// 목록 조회
	public List selectNurseList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("user.selectNurseList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 단건 조회
	public HashMap selectNurse(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("user.selectNurse", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	// 추가
	public Boolean insertNurse( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
//			String  user_id = (String) paramMap.get(" user_id");
//			paramMap.put("nurse_id", user_id);
			sqlMap.insert( "user.insertNurse", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
    
	// 수정
	public Boolean updateNurse( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "user.updateNurse", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteNurse( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "user.deleteNurse", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	/* nurse 기본 기능 : 종료 */


/* ~~~~보류~~~~ */
	
	public Boolean updatePassword( HashMap paramMap ) {
		Boolean isSuccess = false;
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("user.selectUser", paramMap);
			String dbPasswd = (String) resultMap.get("password");
			String my_password = String.valueOf(paramMap.get("passwd_myself"));

			CrytoUtils bcrypt = new CrytoUtils();
			boolean istrue = bcrypt.compareBCrypt(my_password, dbPasswd);
			
			if(istrue) {
				String new_password = (String) paramMap.get("passwd_new");
				if(new_password != null && !new_password.isEmpty()) {
					new_password = bcrypt.getBCrypt(new_password);
					paramMap.put("password", new_password);
					
					sqlMap.update( "user.updateUser", paramMap );
					isSuccess = true;
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public HashMap selectUserCount(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("user.selectUserCount", paramMap);

			resultMap.put("count", count);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

}

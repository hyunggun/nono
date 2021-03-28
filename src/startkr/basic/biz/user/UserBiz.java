package startkr.basic.biz.user;

import java.util.HashMap;
import java.util.List;

import startkr.basic.common.BasicBiz;
import startkr.util.CrytoUtils;

public class UserBiz extends BasicBiz {
	private static final String CRYPTO_KEY = "cf-user";

	/* 기본기능 : 시작 */
	// 목록 조회
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

	// 내용 조회
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
			sqlMap.insert( "user.insertUser", paramMap );
			isSuccess = true;
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

	// 플래그 삭제
	public Boolean deleteUserFlag( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "user.deleteUserFlag", paramMap );
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
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	/* 기본기능 : 끝 */

	/* 추가기능 */

	// 로그인 체크, 회원가입 중복 체크
	public HashMap checkUser(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		int result = 0; // 에러
		try {
			resultMap = (HashMap) sqlMap.queryForObject("user.selectUser", paramMap);
			if( resultMap != null ) {
				String dbUseFlag = (String) resultMap.get("use_fg");
				if( dbUseFlag == null || !dbUseFlag.equals("Y") ) {
					resultMap.put("checkUser", "Closed");
					result = 4; // 해당 아이디 사용자 휴면
				} else {
					resultMap.put("checkUser", "Valid");

					String dbPasswd = (String) resultMap.get("passwd");
					if( dbPasswd != null && !dbPasswd.isEmpty() ) {
						dbPasswd = CrytoUtils.decrypt(dbPasswd, CRYPTO_KEY);
						String reqPasswd = (String) paramMap.get("passwd");
						if( dbPasswd.equals(reqPasswd) ) {
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

	// 사용자 정보 초기화
	public Boolean resetUser( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "user.resetUser", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}


}

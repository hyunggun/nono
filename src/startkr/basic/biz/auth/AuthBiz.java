package startkr.basic.biz.auth;

import java.util.HashMap;
import java.util.List;

import startkr.basic.common.BasicBiz;


public class AuthBiz extends BasicBiz {

	/* 기본기능 : 시작 */
	// 목록 조회
	public HashMap selectAuthPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("auth.selectAuthCount", paramMap);
			List list = sqlMap.queryForList("auth.selectAuthList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectAuthList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("auth.selectAuthList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 내용 조회
	public HashMap selectAuth(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("auth.selectAuth", paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	// 추가
	public Boolean insertAuth( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "auth.insertAuth", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updateAuth( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "auth.updateAuth", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 플래그 삭제
	public Boolean deleteAuthFlag( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "auth.deleteAuthFlag", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteAuth( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "auth.deleteAuth", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	/* 기본기능 : 끝 */

}

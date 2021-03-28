package startkr.basic.biz.code;

import java.util.HashMap;
import java.util.List;

import startkr.basic.common.BasicBiz;


public class CodeBiz extends BasicBiz {

	/* 기본기능 : 시작 */
	// 목록 조회
	public HashMap selectCodePage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("code.selectCodeCount", paramMap);
			List list = sqlMap.queryForList("code.selectCodeList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectCodeList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("code.selectCodeList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 내용 조회
	public HashMap selectCode(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("code.selectCode", paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	// 추가
	public Boolean insertCode( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "code.insertCode", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updateCode( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "code.updateCode", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 플래그 삭제
	public Boolean deleteCodeFlag( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "code.deleteCodeFlag", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteCode( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "code.deleteCode", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	/* 기본기능 : 끝 */

}

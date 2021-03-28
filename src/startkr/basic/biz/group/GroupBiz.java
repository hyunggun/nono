package startkr.basic.biz.group;

import java.util.HashMap;
import java.util.List;

import startkr.basic.common.BasicBiz;


public class GroupBiz extends BasicBiz {

	/* 기본기능 : 시작 */
	// 목록 조회
	public HashMap selectGroupPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("group.selectGroupCount", paramMap);
			List list = sqlMap.queryForList("group.selectGroupList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectGroupList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("group.selectGroupList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 내용 조회
	public HashMap selectGroup(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("group.selectGroup", paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	// 추가
	public Boolean insertGroup( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "group.insertGroup", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updateGroup( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "group.updateGroup", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 플래그 삭제
	public Boolean deleteGroupFlag( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "group.deleteGroupFlag", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteGroup( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "group.deleteGroup", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	/* 기본기능 : 끝 */

}

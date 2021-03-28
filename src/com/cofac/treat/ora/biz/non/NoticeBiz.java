package com.cofac.treat.ora.biz.non;

import java.util.HashMap;
import java.util.List;

import com.cofac.treat.ora.common.MysqlBiz;

public class NoticeBiz extends MysqlBiz {

	/* Notice 기본기능 : 시작 */

	// 목록 페이징 조회
	public HashMap selectNoticePage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("notice.selectNoticeCount", paramMap);
			List list = sqlMap.queryForList("notice.selectNoticeList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectNoticeList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("notice.selectNoticeList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 단건 조회
	public HashMap selectNotice(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("notice.selectNotice", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	// 추가
	public Boolean insertNotice( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "notice.insertNotice", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updateNotice( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "notice.updateNotice", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteNotice( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "notice.deleteNotice", paramMap );
			sqlMap.delete( "notice.deleteNoticeTarget", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	/* Notice 기본기능 : 시작 */


	/* NoticeTarget 기본기능 : 종료 */
	
	// 목록 페이징 조회
	public HashMap selectNoticeTargetPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("notice.selectNoticeTargetCount", paramMap);
			List list = sqlMap.queryForList("notice.selectNoticeTargetList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectNoticeTargetList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("notice.selectNoticeTargetList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public HashMap selectNoticeBedviewTargetPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("notice.selectNoticeBedviewTargetCount", paramMap);
			List list = sqlMap.queryForList("notice.selectNoticeBedviewTargetList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectNoticeBedviewTargetList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("notice.selectNoticeBedviewTargetList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 추가
	public Boolean insertNoticeTarget( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "notice.insertNoticeTarget", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteNoticeTarget( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "notice.deleteNoticeTarget", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	/* NoticeTarget 기본기능 : 종료 */

}

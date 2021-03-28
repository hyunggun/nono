package startkr.basic.biz.board;

import java.util.HashMap;
import java.util.List;

import startkr.basic.common.BasicBiz;


public class BoardBiz extends BasicBiz {

	/* 기본기능 : 시작 */
	// 목록 조회
	public HashMap selectBoardPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("board.selectBoardCount", paramMap);
			List list = sqlMap.queryForList("board.selectBoardList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectBoardList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("board.selectBoardList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 내용 조회
	public HashMap selectBoard(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("board.selectBoard", paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	// 추가
	public Boolean insertBoard( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "board.insertBoard", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updateBoard( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "board.updateBoard", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 플래그 삭제
	public Boolean deleteBoardFlag( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "board.deleteBoardFlag", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteBoard( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "board.deleteBoard", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	/* 기본기능 : 끝 */

}

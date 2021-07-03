package com.cofac.treat.ora.biz.non;

import java.io.File;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.fileupload.FileItem;

import com.cofac.treat.ora.common.Constants;
import com.cofac.treat.ora.common.MysqlBiz;

import startkr.util.RequestUtils;
import startkr.util.StringUtils;
import startkr.util.YRequest;

public class InpatientBiz extends MysqlBiz {

	/* InpatientRoom 기본기능 : 시작 */

	// 목록 페이징 조회
	public HashMap selectInpatientRoomPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("inpatient.selectInpatientRoomCount", paramMap);
			List list = sqlMap.queryForList("inpatient.selectInpatientRoomList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectInpatientRoomList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("inpatient.selectInpatientRoomList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 단건 조회
	public HashMap selectInpatientRoom(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("inpatient.selectInpatientRoom", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	// 추가
	public Boolean insertInpatientRoom( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "inpatient.insertInpatientRoom", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updateInpatientRoom( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "inpatient.updateInpatientRoom", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteInpatientRoom( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "inpatient.deleteInpatientRoom", paramMap );
			sqlMap.delete( "inpatient.deleteInpatientFile", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	/* InpatientRoom 기본기능 : 시작 */

	
	/* InpatientFile 기본기능 : 종료 */
	
	// 목록 페이징 조회
	public HashMap selectInpatientFilePage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("inpatient.selectInpatientFileCount", paramMap);
			List list = sqlMap.queryForList("inpatient.selectInpatientFileList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectInpatientFileList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("inpatient.selectInpatientFileList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 추가
	public Integer uploadFile(YRequest request, String fileTag) {
		if( fileTag == null || fileTag.length() < 1 ) {
			return -1;
		}
		RequestUtils util = new RequestUtils();
		HashMap paramMap = util.makeParamMap(request);
		
		Integer file_id = 0;
		
		try {
			String file_nm = "";
			String file_path = "";
			String file_url = "";
			Long file_size = 0L;
			String file_type = "";

			String savedName = "";

			FileItem fileItem = request.getFileItem( fileTag );
			if( fileItem == null ) return -1;

			file_size = fileItem.getSize();
			if( file_size == 0 ) return -2;

			file_nm = fileItem.getName();

			if( file_nm.indexOf("/") > 0 ) {
			file_nm = file_nm.substring( file_nm.lastIndexOf("/") + 1 );
			}
			if( file_nm.indexOf("\\") > 0 ) {
			file_nm = file_nm.substring( file_nm.lastIndexOf("\\") + 1 );
			}
			if( file_nm.indexOf(".") > 0 ) {
			file_type = file_nm.substring( file_nm.lastIndexOf(".") + 1 );
			} else {
				file_type = "";
			}

			savedName = Long.toString( System.currentTimeMillis() ) + "0" + ( file_type.length() > 0 ? ("."+file_type) : "" );
			File savedFile = new File( Constants.FILE_BASIS_PATH, savedName );
			fileItem.write( savedFile );
			
			file_path = Constants.FILE_BASIS_PATH + savedName;
			file_url = Constants.FILE_BASIS_URL + savedName;
			
			paramMap.put("file_nm", file_nm);
			paramMap.put("file_path", file_path);
			paramMap.put("file_url", file_url);
			paramMap.put("file_size", file_size);
			paramMap.put("file_type", file_type);
			paramMap.put("file_position", "R");

			String fileId = request.getParameter("file_id");

			if( StringUtils.isNotEmpty(fileId) && !fileId.equals("0") ) {
				file_id = Integer.valueOf(fileId);
			}
			
			sqlMap.startTransaction();
			
			Integer file_grp = (Integer) sqlMap.queryForObject("file.selectNextFileGrp");
			paramMap.put("file_grp", file_grp);
			
			sqlMap.insert( "file.insertFile", paramMap );
			
			file_id = (Integer) sqlMap.queryForObject("file.selectMaxFileId");
			
			paramMap.put("file_id", file_id);
			sqlMap.insert( "inpatient.insertInpatientFile", paramMap );
			
			sqlMap.commitTransaction();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				sqlMap.endTransaction();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return file_id;
	}

	// 추가
	public Boolean insertInpatientFile( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "inpatient.insertInpatientFile", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteInpatientFile( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "inpatient.deleteInpatientFile", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	/* InpatientFile 기본기능 : 종료 */


	/**
	 * bedpos
	 * @param paramMap room_no(3WD 301) , patient_no (0072636)
	 * @return int bedpos
	 */
	// select
	public HashMap selectBedpos(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("inpatient.selectBedpos", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}
	// update
	public Boolean upsertBedpos( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "inpatient.upsertBedpos", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
}

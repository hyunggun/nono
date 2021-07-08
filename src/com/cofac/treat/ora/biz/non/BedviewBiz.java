package com.cofac.treat.ora.biz.non;

import java.io.File;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.fileupload.FileItem;

import com.cofac.treat.ora.common.Constants;
import com.cofac.treat.ora.common.MysqlBiz;

import startkr.util.CrytoUtils;
import startkr.util.RequestUtils;
import startkr.util.StringUtils;
import startkr.util.YRequest;

public class BedviewBiz extends MysqlBiz {

	/* Bedview 기본기능 : 시작 */

	// 목록 페이징 조회
	public HashMap selectBedviewPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("bedview.selectBedviewCount", paramMap);
			List list = sqlMap.queryForList("bedview.selectBedviewList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectBedviewList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("bedview.selectBedviewList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 단건 조회
	public HashMap selectBedview(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("bedview.selectBedview", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	// 추가
	public Boolean insertBedview( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "bedview.insertBedview", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updateBedview( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "bedview.updateBedview", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteBedview( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "bedview.deleteBedview", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	/* Bedview 기본기능 : 시작 */
	
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
			paramMap.put("file_position", "B");

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
			sqlMap.insert( "bedview.insertBedviewFile", paramMap );
			
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
	
	/* BedviewFile 기본기능 : 시작 */
	
	// 목록 페이징 조회
	public HashMap selectBedviewFilePage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("bedview.selectBedviewFileCount", paramMap);
			List list = sqlMap.queryForList("bedview.selectBedviewFileList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectBedviewFileList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("bedview.selectBedviewFileList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 추가
	public Boolean insertBedviewFile( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "bedview.insertBedviewFile", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	// 삭제
	public Boolean deleteBedviewFile( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			
			HashMap fileInfo = (HashMap) sqlMap.queryForObject("file.selectFile", paramMap);
			if( fileInfo != null ) {
				File oldFile = new File((String) fileInfo.get("file_path"));
				if( oldFile != null ) {
					oldFile.delete();
				}
			}
			
			sqlMap.delete( "bedview.deleteBedviewFile", paramMap );
			sqlMap.delete( "file.deleteFile", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	/* BedviewFile 기본기능 : 종료 */
	
	public HashMap checkBedView(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		int result = 0; // 에러
		try {
			resultMap = (HashMap) sqlMap.queryForObject("bedview.selectBedview", paramMap);
			if( resultMap != null ) {
				resultMap.put("checkCode", "Right");
				result = 1; // 아이디, 암호 일치
					
			} else {
				resultMap = new HashMap();
				resultMap.put("checkBedView", "None");
				result = 3; // 해당 아이디 사용자 없음
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		resultMap.put("result", result);

		return resultMap;
	}
}

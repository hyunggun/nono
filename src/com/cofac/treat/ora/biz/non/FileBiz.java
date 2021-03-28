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

public class FileBiz extends MysqlBiz {

	/* File 기본기능 : 시작 */

	// 목록 페이징 조회
	public HashMap selectFilePage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("file.selectFileCount", paramMap);
			List list = sqlMap.queryForList("file.selectFileList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectFileList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("file.selectFileList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 단건 조회
	public HashMap selectFile(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("file.selectFile", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	// 추가
	public Boolean insertFile( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "file.insertFile", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updateFile( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "file.updateFile", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteFile( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			
			HashMap fileInfo = (HashMap) sqlMap.queryForObject("file.selectFile", paramMap);
			if( fileInfo != null ) {
				File oldFile = new File((String) fileInfo.get("file_path"));
				if( oldFile != null ) {
					oldFile.delete();
				}
			}
			sqlMap.delete( "machine.deleteMachineFile", paramMap );
			sqlMap.delete( "inpatient.deleteInpatientFile", paramMap );
			sqlMap.delete( "file.deleteFile", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public Integer uploadFile(YRequest request, String fileTag, String position) {
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
			paramMap.put("file_position", position);
			
			sqlMap.startTransaction();
			
			sqlMap.insert( "file.insertFile", paramMap );
			
			file_id = 1;
			
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
	/* File 기본기능 : 종료 */
}

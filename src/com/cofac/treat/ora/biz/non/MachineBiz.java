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

public class MachineBiz extends MysqlBiz {

	/* Machine 기본기능 : 시작 */

	// 목록 페이징 조회
	public HashMap selectMachinePage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("machine.selectMachineCount", paramMap);
			List list = sqlMap.queryForList("machine.selectMachineList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectMachineList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("machine.selectMachineList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 단건 조회
	public HashMap selectMachine(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("machine.selectMachine", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}

	// 추가
	public Boolean insertMachine( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "machine.insertMachine", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 수정
	public Boolean updateMachine( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.update( "machine.updateMachine", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteMachine( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "machine.deleteMachine", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	/* Machine 기본기능 : 시작 */
	
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
			paramMap.put("file_position", "T");

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
			sqlMap.insert( "machine.insertMachineFile", paramMap );
			
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
	
	public Boolean insertMachineAlert( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "machine.insertMachineAlert", paramMap );
			isSuccess = true;
	
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public Boolean insertMachineAlertMulti( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "machine.insertMachineAlertMulti", paramMap );
			isSuccess = true;
	
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public Boolean deleteMachineAlert( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "machine.deleteMachineAlert", paramMap );
			
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	/* MachineFile 기본기능 : 시작 */
	
	// 목록 페이징 조회
	public HashMap selectMachineFilePage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("machine.selectMachineFileCount", paramMap);
			List list = sqlMap.queryForList("machine.selectMachineFileList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectMachineFileList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("machine.selectMachineFileList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 추가
	public Boolean insertMachineFile( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "machine.insertMachineFile", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	// 삭제
	public Boolean deleteMachineFile( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "machine.deleteMachineFile", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	/* MachineFile 기본기능 : 종료 */
	
	
/* MachineFile 기본기능 : 시작 */
	
	// 목록 페이징 조회
	public HashMap selectMachineRoomPage(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			Integer count = (Integer) sqlMap.queryForObject("machine.selectMachineRoomCount", paramMap);
			List list = sqlMap.queryForList("machine.selectMachineRoomList", paramMap );

			resultMap.put("count", count);
			resultMap.put("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	// 목록 조회
	public List selectMachineRoomList(HashMap paramMap) {
		List list = null;
		try {
			list = sqlMap.queryForList("machine.selectMachineRoomList", paramMap );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public HashMap selectMachineRoom(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("machine.selectMachineRoom", paramMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}
	
	// 추가
	public Boolean insertMachineRoom( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.insert( "machine.insertMachineRoom", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	// 삭제
	public Boolean deleteMachineRoom( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "machine.deleteMachineRoom", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isSuccess;
	}

	/* MachineFile 기본기능 : 종료 */

}

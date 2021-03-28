package startkr.basic.biz.file;

import java.io.File;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.fileupload.FileItem;

import startkr.basic.common.BasicBiz;
import startkr.util.RequestUtils;
import startkr.util.StringUtils;
import startkr.util.YRequest;


public class FileBiz extends BasicBiz {

	/* 기본기능 : 시작 */
	// 목록 조회
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
	
	// 내용 조회
	public HashMap selectFile(HashMap paramMap) {
		HashMap resultMap = new HashMap();
		try {
			resultMap = (HashMap) sqlMap.queryForObject("file.selectFile", paramMap);
		} catch (Exception e) {
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
			e.printStackTrace();
		}
		return isSuccess;
	}

	// 삭제
	public Boolean deleteFile( HashMap paramMap ) {
		Boolean isSuccess = false;
		try {
			sqlMap.delete( "file.deleteFile", paramMap );
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	/* 기본기능 : 끝 */
	
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
			
			String filePath = "\\temp\\"; // Constants.FILE_BASIS_PATH

			savedName = Long.toString( System.currentTimeMillis() ) + "0" + ( file_type.length() > 0 ? ("."+file_type) : "" );
			File savedFile = new File(filePath , savedName );
			fileItem.write( savedFile );

			file_path = filePath + savedName;
			file_url = filePath + savedName; ///
			
			paramMap.put("file_nm", file_nm);
			paramMap.put("file_path", file_path);
			paramMap.put("file_url", file_url);
			paramMap.put("file_size", file_size);
			paramMap.put("file_type", file_type);

			String fileId = request.getParameter("file_id");

			if( StringUtils.isNotEmpty(fileId) && !fileId.equals("0") ) {
				file_id = Integer.valueOf(fileId);
			}

			sqlMap.startTransaction();

			if( file_id > 0 ) {
				// 기존 파일 삭제
				HashMap fileInfo = (HashMap) sqlMap.queryForObject("file.selectFile", paramMap);
				if( fileInfo != null ) {
					File oldFile = new File((String) fileInfo.get("file_path"));
					if( oldFile != null ) {
						oldFile.delete();
					}
				}

				// 수정
				paramMap.put("file_id", fileId);
				sqlMap.update( "file.updateFile", paramMap );

			} else {
				// 추가
				Integer file_grp = (Integer) sqlMap.queryForObject("file.selectNextFileGrp");
				paramMap.put("file_grp", file_grp);
				sqlMap.insert( "file.insertFile", paramMap );
				
				file_id = (Integer) sqlMap.queryForObject("file.selectMaxFileId");
			}

			sqlMap.commitTransaction();
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				sqlMap.endTransaction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return file_id;
	}

}

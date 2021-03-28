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

public class MenuBiz extends MysqlBiz {

	/* BedviewMenu 기본기능 : 시작 */
	// 목록 조회
	  public HashMap selectMenuPage(HashMap paramMap) {
	    HashMap resultMap = new HashMap();
	    try {
	      Integer count = (Integer) sqlMap.queryForObject("menu.selectMenuCount", paramMap);
	      List list = sqlMap.queryForList("menu.selectMenuList", paramMap );
	      
	      resultMap.put("count", count);
	      resultMap.put("list", list);
	      
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    return resultMap;
	  }
	  // 목록 조회
	  public List selectMenuList(HashMap paramMap) {
	    List list = null;
	    try {
	      list = sqlMap.queryForList("menu.selectMenuList", paramMap );
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    return list;
	  }
	  
	  // 내용 조회
	  public HashMap selectMenu(HashMap paramMap) {
	    HashMap resultMap = new HashMap();
	    try {
	      resultMap = (HashMap) sqlMap.queryForObject("menu.selectMenu", paramMap);
	    } catch (Exception e) {
	      // TODO: handle exception
	      e.printStackTrace();
	    }
	    return resultMap;
	  }
	  
	  // 추가
	  public Boolean insertMenu( HashMap paramMap ) {
	    Boolean isSuccess = false;
	    try {
	      sqlMap.insert( "menu.insertMenu", paramMap );
	      isSuccess = true;
	    } catch (Exception e) {
	      // TODO: handle exception
	      e.printStackTrace();
	    }
	    return isSuccess;
	  }
	  
	  // 수정
	  public Boolean updateMenu( HashMap paramMap ) {
	    Boolean isSuccess = false;
	    try {
	      sqlMap.update( "menu.updateMenu", paramMap );
	      isSuccess = true;
	    } catch (Exception e) {
	      // TODO: handle exception
	      e.printStackTrace();
	    }
	    return isSuccess;
	  }
	  
	  public Boolean updateMenuChildUseFg( HashMap paramMap ) {
		    Boolean isSuccess = false;
		    try {
		      sqlMap.update( "menu.updateMenuChildUseFg", paramMap );
		      isSuccess = true;
		    } catch (Exception e) {
		      // TODO: handle exception
		      e.printStackTrace();
		    }
		    return isSuccess;
		  }
	  
	  // 삭제
	  public Boolean deleteMenu( HashMap paramMap ) {
	    Boolean isSuccess = false;
	    
	    try {
	      Integer count = (Integer) sqlMap.queryForObject("menu.selectMenuFileListCount", paramMap);
			if( count > 0 ) {
			  List fileList = sqlMap.queryForList("menu.selectMenuFileList", paramMap);
				for(int lp0=0; lp0<fileList.size(); lp0++) {
					HashMap fileInfo = (HashMap) fileList.get(lp0);
					File oldFile = new File((String) fileInfo.get("file_path"));
					if( oldFile != null ) {
						oldFile.delete();
					}
				}
			}
	    	
	      sqlMap.delete( "menu.deleteChildMenuContent", paramMap );
	      sqlMap.delete( "menu.deleteMenuContentWithMenuId", paramMap );
	      sqlMap.delete( "menu.deleteChildMenu", paramMap );
	      sqlMap.delete( "menu.deleteMenu", paramMap );
	      isSuccess = true;
	    } catch (Exception e) {
	      // TODO: handle exception
	      e.printStackTrace();
	    }
	    return isSuccess;
	  }
	  
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
				paramMap.put("file_position", "I");

				String fileId = request.getParameter("file_id");

				if( StringUtils.isNotEmpty(fileId) && !fileId.equals("0") ) {
					file_id = Integer.valueOf(fileId);
				}
				
				sqlMap.startTransaction();
				
//				Integer file_grp = (Integer) sqlMap.queryForObject("file.selectNextFileGrp");
//				paramMap.put("file_grp", file_grp);
				
				if(file_id > 0) {
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
					sqlMap.insert( "file.insertFile", paramMap );
					
					file_id = (Integer) sqlMap.queryForObject("file.selectMaxFileId");
				}
				
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
	  
	  /* 기본기능 : 끝 */
	  public HashMap selectPageMenu(HashMap paramMap) {
	    HashMap resultMap = new HashMap();
	    try {
	      Integer count = (Integer) sqlMap.queryForObject("menu.selectMenuCount", paramMap);
	      List list= sqlMap.queryForList("menu.selectMenuList", paramMap );
	      
	      resultMap.put("count", count);
	      resultMap.put("list", list);
	      
	      
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    return resultMap;
	  }
	/* BedviewMenu 기본기능 : 종료 */
	  
	/* BedviewMenuContent 기본기능 : 시작 */
	  // 목록 조회
	  public HashMap selectMenuContentPage(HashMap paramMap) {
	    HashMap resultMap = new HashMap();
	    try {
	      Integer count = (Integer) sqlMap.queryForObject("menu.selectMenuContentCount", paramMap);
	      List list = sqlMap.queryForList("menu.selectMenuContentList", paramMap );
	      List imgList = sqlMap.queryForList("file.selectFileList", paramMap );
	      
	      resultMap.put("count", count);
	      resultMap.put("list", list);
	      resultMap.put("imgList", imgList);
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    return resultMap;
	  }
	  
	  // 목록 조회
	  public List selectMenuContentList(HashMap paramMap) {
	    List list = null;
	    try {
	      list = sqlMap.queryForList("menu.selectMenuContentList", paramMap );
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    return list;
	  }
	  
	  // 내용 조회
	  public HashMap selectMenuContent(HashMap paramMap) {
	    HashMap resultMap = new HashMap();
	    try {
	      resultMap = (HashMap) sqlMap.queryForObject("menu.selectMenuContent", paramMap);
	    } catch (Exception e) {
	      // TODO: handle exception
	      e.printStackTrace();
	    }
	    return resultMap;
	  }
	  
	  // 추가
	  public Boolean insertMenuContent( HashMap paramMap ) {
	    Boolean isSuccess = false;
	    try {
	      sqlMap.insert( "menu.insertMenuContent", paramMap );
	      isSuccess = true;
	    } catch (Exception e) {
	      // TODO: handle exception
	      e.printStackTrace();
	    }
	    return isSuccess;
	  }
	  
	  // 수정
	  public Boolean updateMenuContent( HashMap paramMap ) {
	    Boolean isSuccess = false;
	    try {
	      sqlMap.update( "menu.updateMenuContent", paramMap );
	      isSuccess = true;
	    } catch (Exception e) {
	      // TODO: handle exception
	      e.printStackTrace();
	    }
	    return isSuccess;
	  }
	  
	  // 삭제
	  public Boolean deleteMenuContent( HashMap paramMap ) {
	    Boolean isSuccess = false;
	    try {
	      sqlMap.delete( "menu.deleteMenuContent", paramMap );
	      isSuccess = true;
	    } catch (Exception e) {
	      // TODO: handle exception
	      e.printStackTrace();
	    }
	    return isSuccess;
	  }
	  
	  public Boolean deleteMenuContentWithMenuId( HashMap paramMap ) {
		    Boolean isSuccess = false;
		    try {
		      sqlMap.delete( "menu.deleteMenuContentWithMenuId", paramMap );
		      isSuccess = true;
		    } catch (Exception e) {
		      // TODO: handle exception
		      e.printStackTrace();
		    }
		    return isSuccess;
		  }
	  
	  /* BedviewMenuContent 기본기능 : 끝 */
	  public HashMap selectPageMenuContent(HashMap paramMap) {
	    HashMap resultMap = new HashMap();
	    try {
	      Integer count = (Integer) sqlMap.queryForObject("menu.selectMenuContentCount", paramMap);
	      List list= sqlMap.queryForList("menu.selectMenuContentList", paramMap );
	      
	      resultMap.put("count", count);
	      resultMap.put("list", list);
	      
	      
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    return resultMap;
	  }


}

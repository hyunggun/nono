package com.cofac.treat.ora.biz.non;

import java.util.HashMap;
import java.util.List;

import com.cofac.treat.ora.common.MysqlBiz;

import startkr.util.CrytoUtils;

public class DocBiz extends MysqlBiz {

  /* 기본기능 : 시작 */
  // 목록 조회
  public HashMap selectDocPage(HashMap paramMap) {
    HashMap resultMap = new HashMap();
    try {
      Integer count = (Integer) sqlMap.queryForObject("doc.selectDocCount", paramMap);
      List list = sqlMap.queryForList("doc.selectDocList", paramMap );
      
      resultMap.put("count", count);
      resultMap.put("list", list);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return resultMap;
  }
  
  // 목록 조회
  public List selectDocList(HashMap paramMap) {
    List list = null;
    try {
      list = sqlMap.queryForList("doc.selectDocList", paramMap );
    } catch (Exception e) {
      e.printStackTrace();
    }
    return list;
  }
  
  // 내용 조회
  public HashMap selectDoc(HashMap paramMap) {
    HashMap resultMap = new HashMap();
    try {
      resultMap = (HashMap) sqlMap.queryForObject("doc.selectDoc", paramMap);
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return resultMap;
  }
  
  // 추가
  public Boolean insertDoc( HashMap paramMap ) {
    Boolean isSuccess = false;
    try {
      sqlMap.insert( "doc.insertDoc", paramMap );
      isSuccess = true;
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return isSuccess;
  }
  
  // 수정
  public Boolean updateDoc( HashMap paramMap ) {
    Boolean isSuccess = false;
    try {
      sqlMap.update( "doc.updateDoc", paramMap );
      isSuccess = true;
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return isSuccess;
  }
  
  // 삭제
  public Boolean deleteDoc( HashMap paramMap ) {
    Boolean isSuccess = false;
    try {
      sqlMap.delete( "doc.deleteDoc", paramMap );
      isSuccess = true;
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return isSuccess;
  }
  /* 기본기능 : 끝 */
  
  //추가기능 의사 직책, 컬러 가져오기
  public HashMap selectDocColor(HashMap paramMap) {
	    HashMap resultMap = new HashMap();
	    try {
	      resultMap = (HashMap) sqlMap.queryForObject("doc.selectDocColor", paramMap);
	    } catch (Exception e) {
	      // TODO: handle exception
	      e.printStackTrace();
	    }
	    return resultMap;
	  }
}

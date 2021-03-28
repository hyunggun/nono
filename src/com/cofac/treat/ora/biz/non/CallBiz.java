package com.cofac.treat.ora.biz.non;

import java.util.HashMap;
import java.util.List;

import com.cofac.treat.ora.common.MysqlBiz;

import startkr.util.CrytoUtils;

public class CallBiz extends MysqlBiz {

  /* 기본기능 : 시작 */
  // 목록 조회
  public HashMap selectCallPage(HashMap paramMap) {
    HashMap resultMap = new HashMap();
    try {
      Integer count = (Integer) sqlMap.queryForObject("call.selectCallCount", paramMap);
      List list = sqlMap.queryForList("call.selectCallList", paramMap );
      
      resultMap.put("count", count);
      resultMap.put("list", list);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return resultMap;
  }
  
  // 목록 조회
  public List selectCallList(HashMap paramMap) {
    List list = null;
    try {
      list = sqlMap.queryForList("call.selectCallList", paramMap );
    } catch (Exception e) {
      e.printStackTrace();
    }
    return list;
  }
  
  // 내용 조회
  public HashMap selectCall(HashMap paramMap) {
    HashMap resultMap = new HashMap();
    try {
      resultMap = (HashMap) sqlMap.queryForObject("call.selectCall", paramMap);
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return resultMap;
  }
  
  // 추가
  public Boolean insertCall( HashMap paramMap ) {
    Boolean isSuccess = false;
    try {
      sqlMap.insert( "call.insertCall", paramMap );
      isSuccess = true;
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return isSuccess;
  }
  
  // 수정
  public Boolean updateCall( HashMap paramMap ) {
    Boolean isSuccess = false;
    try {
      sqlMap.update( "call.updateCall", paramMap );
      isSuccess = true;
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return isSuccess;
  }
  
  // 삭제
  public Boolean deleteCall( HashMap paramMap ) {
    Boolean isSuccess = false;
    try {
      sqlMap.delete( "call.deleteCall", paramMap );
      isSuccess = true;
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return isSuccess;
  }
  /* 기본기능 : 끝 */

}

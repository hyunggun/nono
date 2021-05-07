package com.cofac.treat.ora.biz.interlinked;

import java.util.HashMap;
import java.util.List;

//연결할 DB종류에 맞춰서 상속받아 사용
import com.cofac.treat.ora.common.MssqlBiz;
import com.cofac.treat.ora.common.MysqlBiz;
import com.cofac.treat.ora.common.OracleBiz;

public class OperationBiz extends OracleBiz {

  // 수술실뷰
  public HashMap selectOperationMap(HashMap paramMap) {
    HashMap resultMap = new HashMap();
    try {
      List list = sqlMap.queryForList("operation.selectOperationList", paramMap);
      resultMap.put("list", list);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return resultMap;
  }

  public List selectOperationList(HashMap paramMap) {
    List list = null;
    try {
      list = sqlMap.queryForList("operation.selectOperationList", paramMap);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return list;
  }

  public List selectWaitingList(HashMap paramMap) {
    List list = null;
    try {
      list = sqlMap.queryForList("operation.selectWaitingList", paramMap);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return list;
  }
}

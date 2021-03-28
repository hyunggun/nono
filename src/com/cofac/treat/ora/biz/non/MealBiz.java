package com.cofac.treat.ora.biz.non;

import java.util.HashMap;
import java.util.List;

import com.cofac.treat.ora.common.MysqlBiz;

import startkr.util.CrytoUtils;

public class MealBiz extends MysqlBiz {

  /* 湲곕낯湲곕뒫 : �떆�옉 */
  // 紐⑸줉 議고쉶
  public HashMap selectMealPage(HashMap paramMap) {
    HashMap resultMap = new HashMap();
    try {
      Integer count = (Integer) sqlMap.queryForObject("meal.selectMealCount", paramMap);
      List list = sqlMap.queryForList("meal.selectAfterMealList", paramMap );
      
      resultMap.put("count", count);
      resultMap.put("list", list);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return resultMap;
  }
  
  // 紐⑸줉 議고쉶
  public List selectMealList(HashMap paramMap) {
    List list = null;
    try {
      list = sqlMap.queryForList("meal.selectMealList", paramMap );
    } catch (Exception e) {
      e.printStackTrace();
    }
    return list;
  }
  
  // �궡�슜 議고쉶
  public HashMap selectMeal(HashMap paramMap) {
    HashMap resultMap = new HashMap();
    try {
      resultMap = (HashMap) sqlMap.queryForObject("meal.selectMeal", paramMap);
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return resultMap;
  }
  
  // 異붽�
  public Boolean insertMeal( HashMap paramMap ) {
    Boolean isSuccess = false;
    try {
      sqlMap.insert( "meal.insertMeal", paramMap );
      isSuccess = true;
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return isSuccess;
  }
  
  // �닔�젙
  public Boolean updateMeal( HashMap paramMap ) {
    Boolean isSuccess = false;
    try {
      sqlMap.update( "meal.updateMeal", paramMap );
      isSuccess = true;
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return isSuccess;
  }
  
  // �뵆�옒洹� �궘�젣
  public Boolean deleteMealFlag( HashMap paramMap ) {
    Boolean isSuccess = false;
    try {
      sqlMap.update( "meal.deleteMealFlag", paramMap );
      isSuccess = true;
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return isSuccess;
  }
  
  // �궘�젣
  public Boolean deleteMeal( HashMap paramMap ) {
    Boolean isSuccess = false;
    try {
      sqlMap.delete( "meal.deleteMeal", paramMap );
      isSuccess = true;
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return isSuccess;
  }
  /* 湲곕낯湲곕뒫 : �걹 */
  /* 湲곕낯湲곕뒫 : �떆�옉 */
  // 紐⑸줉 議고쉶
  public HashMap selectMealInfoPage(HashMap paramMap) {
    HashMap resultMap = new HashMap();
    try {
      Integer count = (Integer) sqlMap.queryForObject("meal.selectMealInfoCount", paramMap);
      List list = sqlMap.queryForList("meal.selectMealInfoList", paramMap );
      
      resultMap.put("count", count);
      resultMap.put("list", list);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return resultMap;
  }
  
  // 紐⑸줉 議고쉶
  public List selectMealInfoList(HashMap paramMap) {
    List list = null;
    try {
      list = sqlMap.queryForList("meal.selectMealInfoList", paramMap );
    } catch (Exception e) {
      e.printStackTrace();
    }
    return list;
  }
  
  // �궡�슜 議고쉶
  public HashMap selectMealInfo(HashMap paramMap) {
    HashMap resultMap = new HashMap();
    try {
      resultMap = (HashMap) sqlMap.queryForObject("meal.selectMealInfo", paramMap);
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return resultMap;
  }
  
  // 異붽�
  public Boolean insertMealInfo( HashMap paramMap ) {
    Boolean isSuccess = false;
    try {
      sqlMap.insert( "meal.insertMealInfo", paramMap );
      isSuccess = true;
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return isSuccess;
  }
  
  // �닔�젙
  public Boolean updateMealInfo( HashMap paramMap ) {
    Boolean isSuccess = false;
    try {
      sqlMap.update( "meal.updateMealInfo", paramMap );
      isSuccess = true;
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return isSuccess;
  }
  
  // �뵆�옒洹� �궘�젣
  public Boolean deleteMealInfoFlag( HashMap paramMap ) {
    Boolean isSuccess = false;
    try {
      sqlMap.update( "meal.deleteMealInfoFlag", paramMap );
      isSuccess = true;
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return isSuccess;
  }
  
  // �궘�젣
  public Boolean deleteMealInfo( HashMap paramMap ) {
    Boolean isSuccess = false;
    try {
      sqlMap.delete( "meal.deleteMealInfo", paramMap );
      isSuccess = true;
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return isSuccess;
  }
  /* 湲곕낯湲곕뒫 : �걹 */
  public Integer checkIsBeeing (HashMap paramMap) {
    HashMap resultMap = new HashMap();
    Integer mealId = 0;
    try {
      resultMap = (HashMap) sqlMap.queryForObject("meal.checkIsBeeing", paramMap);
      System.out.println("resultmap "+resultMap);
      if(resultMap != null) {
        mealId = (Integer)resultMap.get("meal_id");
        System.out.println(mealId);
      }
    } catch (Exception e) {
      // TODO: handle exception
      e.printStackTrace();
    }
    return mealId;
  }
  
  public List selectWeekMealList(HashMap paramMap) {
    List list = null;
    try {
      list = sqlMap.queryForList("meal.selectWeekMealList", paramMap );
    } catch (Exception e) {
      e.printStackTrace();
    }
    return list;
  }
}

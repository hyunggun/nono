package com.cofac.treat.ora.common;

import com.ibatis.sqlmap.client.SqlMapClient;

import org.apache.log4j.Logger;

public class OracleBiz {
	protected static SqlMapClient sqlMap = IBatisOracleConfig.getSqlMapInstatnce();
	protected Logger logger = Logger.getLogger(this.getClass());
	
}

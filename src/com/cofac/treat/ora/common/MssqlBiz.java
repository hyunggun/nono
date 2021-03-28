package com.cofac.treat.ora.common;

import com.ibatis.sqlmap.client.SqlMapClient;

import org.apache.log4j.Logger;

public class MssqlBiz {
	protected static SqlMapClient sqlMap = IBatisMssqlConfig.getSqlMapInstatnce();
	protected Logger logger = Logger.getLogger(this.getClass());
	
}

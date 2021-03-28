package startkr.basic.common;

import com.ibatis.sqlmap.client.SqlMapClient;

import org.apache.log4j.Logger;

public class BasicBiz {
	protected static SqlMapClient sqlMap = IBatisConfig.getSqlMapInstatnce();
	protected Logger logger = Logger.getLogger(this.getClass());
	
}

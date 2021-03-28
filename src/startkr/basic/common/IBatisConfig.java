package startkr.basic.common;

import java.io.Reader;
import java.nio.charset.Charset;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class IBatisConfig {
	private static SqlMapClient sqlMap = null;
	static {
		try {
			Charset charset = Charset.forName("UTF-8");
			Resources.setCharset(charset); 
			String resource = "SQLMapMysqlConfig.xml";
			Reader reader = Resources.getResourceAsReader(resource);

			if( reader != null ) {
				sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public static SqlMapClient getSqlMapInstatnce() {
		return sqlMap;
	}
}

package startkr.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonUtils {
	
	private static Logger logger = Logger.getLogger(JsonUtils.class);
	
	public static <K, V> JSONObject getJsonObjectFromMap( HashMap<K, V> map ) {

		JSONObject json = new JSONObject();
		if(map != null) {
			for( Map.Entry<K, V> entry : map.entrySet() ) {
				String key = (String) entry.getKey();
				Object value = entry.getValue();
				if(value == null) {
					json.put(key, "");
				} else {
					if(key.equals("createdAt") || key.equals("updatedAt")) {
					  String date = value.toString();
					  date = date.replaceAll(" ", "T");
					  json.put(key, date);
					} else {
					  if(!key.equals("view_nm") && !key.equals("hospital_nm")) {
						  json.put(key, value);
					  }
					}
				}
			}
		}

		return json;
	}
	
	public static <K, V> JSONArray getJsonArrayFromList( List<HashMap<K, V>> list ) {

		JSONArray jsonArray = new JSONArray();
		if(list != null) {
			for( HashMap<K, V> map : list ) {
				jsonArray.add( getJsonObjectFromMap( map ) );
			}
		}
		
		return jsonArray;
	}
	
	public static <K, V> String getJsonStringFromList( List<HashMap<K, V>> list ) {

		JSONArray jsonArray = new JSONArray();
		if(list != null) {
			for( HashMap<K, V> map : list ) {
				jsonArray.add( getJsonObjectFromMap( map ) );
			}
		}
		
		return jsonArray.toJSONString();
	}
	
	public static <K, V> HashMap<K, V> getMapFromJsonObject( JSONObject jsonObj ) {

		HashMap<K, V> map = null;
		if(jsonObj != null) {
			try {
				map = new ObjectMapper().readValue(jsonObj.toJSONString(), HashMap.class);
			} catch (Exception e) {
	            e.printStackTrace();
	        }
		}

        return map;
	}
	
	public static <K, V> List<HashMap<K, V>> getListMapFromJsonArray( JSONArray jsonArray ) {

		List<HashMap<K, V>> list = new ArrayList<HashMap<K, V>>();
		
		if( jsonArray != null )
		{
			int jsonSize = jsonArray.size();
			for( int i = 0; i < jsonSize; i++ )
			{
				HashMap<K, V> map = JsonUtils.getMapFromJsonObject( ( JSONObject ) jsonArray.get(i) );
				list.add( map );
			}
		}
		
		return list;
	}
}

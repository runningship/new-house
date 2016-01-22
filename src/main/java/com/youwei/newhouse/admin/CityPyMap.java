package com.youwei.newhouse.admin;

import java.util.HashMap;
import java.util.Map;

public class CityPyMap {

	private static Map<String , String> map = new HashMap<String, String>();
	
	static{
		map.put("hefei", "合肥");
		map.put("wuhu", "芜湖");
		map.put("bengbu", "蚌埠");
	}
	
	public static String getCity(String cityPy){
		return map.get(cityPy);
	}
}

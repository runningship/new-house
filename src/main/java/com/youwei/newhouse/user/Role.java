package com.youwei.newhouse.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public enum Role {
	市场专员("sczy"),
	销售主管("xszg"),
	销售经理("xsjl"),
	销售总监("xszj");
	private String pinyin;
	
	private Role( String code){
		this.pinyin = code;
	}

	public String getCode() {
		return pinyin;
	}
	
	public static JSONArray toJsonArray(){
		JSONArray arr = new JSONArray();
		for(Role state : Role.values()){
			JSONObject jobj = new JSONObject();
			jobj.put("value", state.name());
			jobj.put("name", state.name());
			jobj.put("pinyin", state.pinyin);
			arr.add(jobj);
		}
		return arr;
	}
	
	public static Role parse(String codec){
		for(Role zx : Role.values()){
			if(zx.pinyin.equals(codec)){
				return zx;
			}
		}
		return null;
	}
	
	public static List<Map<String,Object>> toList(){
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		for(Role state : Role.values()){
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("name", state.name());
			map.put("pinyin", state.pinyin);
			list.add(map);
		}
		return list;
	}
}

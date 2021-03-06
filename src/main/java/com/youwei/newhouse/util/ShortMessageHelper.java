package com.youwei.newhouse.util;

import java.util.HashMap;
import java.util.Set;

import org.bc.sdak.utils.LogUtil;

import com.cloopen.rest.sdk.CCPRestSDK;


public class ShortMessageHelper {

	private static final String RongLianTempId = "27067";
	private static final String RongLianAccount = "8a48b5514d0427c1014d0429646a0002";
	private static final String RongLianToken = "78a9ff1208304b949309f117a63f1d9b";
	private static final String RongLianAppId = "aaf98f894d328b13014d65d868e1242a";
	public static boolean sendRongLianMsg(String tel , String code){
		CCPRestSDK restAPI = getClient();
		HashMap<String, Object> result = restAPI.sendTemplateSMS(tel,RongLianTempId ,new String[]{code,"5"});

		if("000000".equals(result.get("statusCode"))){
			//正常返回输出data包体信息（map）
			HashMap<String,Object> data = (HashMap<String, Object>) result.get("data");
			Set<String> keySet = data.keySet();
			for(String key:keySet){
				Object object = data.get(key);
				System.out.println(key +" = "+object);
			}
			return true;
		}else{
			//异常返回输出错误码和错误信息
			LogUtil.info("发送验证码失败,tel = "+tel+",错误码=" + result.get("statusCode") +" 错误信息= "+result.get("statusMsg"));
			return false;
		}
	}
	
	public static boolean sendNewOrderMsg(String tel){
		CCPRestSDK restAPI = getClient();
		HashMap<String, Object> result = restAPI.sendTemplateSMS(tel,"65740" ,new String[]{""});
		if("000000".equals(result.get("statusCode"))){
			return true;
		}else{
			//异常返回输出错误码和错误信息
			LogUtil.info("发送验证码失败,tel = "+tel+",错误码=" + result.get("statusCode") +" 错误信息= "+result.get("statusMsg"));
			return false;
		}
	}
	
	public static boolean sendNewBankOrderMsg(String tel){
		CCPRestSDK restAPI = getClient();
		HashMap<String, Object> result = restAPI.sendTemplateSMS(tel,"75635" ,new String[]{""});
		if("000000".equals(result.get("statusCode"))){
			return true;
		}else{
			//异常返回输出错误码和错误信息
			LogUtil.info("发送验证码失败,tel = "+tel+",错误码=" + result.get("statusCode") +" 错误信息= "+result.get("statusMsg"));
			return false;
		}
	}
	
	private static  CCPRestSDK getClient(){
		CCPRestSDK restAPI = new CCPRestSDK();
		restAPI.init("sandboxapp.cloopen.com", "8883");// 初始化服务器地址和端口，格式如下，服务器地址不需要写https://
		restAPI.setAccount(RongLianAccount, RongLianToken);// 初始化主帐号名称和主帐号令牌
		restAPI.setAppId(RongLianAppId);// 初始化应用ID
		return restAPI;
	}
}

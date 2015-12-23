package com.youwei.newhouse.util;

import org.bc.sdak.GException;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;

import com.youwei.newhouse.FjbConstant;

public class VerifyCodeHelper {

	public static void verify(String yzm){
		if(yzm==null){
			yzm="";
		}
		String session_yzm = (String)ThreadSession.getHttpSession().getAttribute(FjbConstant.Session_Attr_YZM);
		if(session_yzm==null){
			return;
		}
		if(!yzm.toUpperCase().equals(session_yzm)){
			throw new GException(PlatformExceptionType.BusinessException,"验证码不正确。");
		}
		ThreadSession.getHttpSession().removeAttribute(FjbConstant.Session_Attr_YZM);
	}
}

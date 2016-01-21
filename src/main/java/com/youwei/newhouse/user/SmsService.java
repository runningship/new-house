package com.youwei.newhouse.user;

import java.util.Date;
import java.util.Random;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;

import com.youwei.newhouse.entity.TelVerifyCode;
import com.youwei.newhouse.util.ShortMessageHelper;

@Module(name="/admin/sms/")
public class SmsService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView sendVerifyCode(String tel){
		ModelAndView mv = new ModelAndView();
		TelVerifyCode tvc = new TelVerifyCode();
		if(StringUtils.isEmpty(tel)){
			throw new GException(PlatformExceptionType.BusinessException,"电话号码不能为空");
		}
		tvc.tel = tel;
        int max=9999;
        int min=1000;
        Random random = new Random();
        int s = random.nextInt(max)%(max-min+1) + min;
        String code = String.valueOf(s);
        tvc.code = code ;
      //send code to tel
        boolean result = ShortMessageHelper.sendRongLianMsg(tel, tvc.code);
        if(!result){
        	throw new GException(PlatformExceptionType.BusinessException,"发送短信失败，请稍后重试");
        }
        tvc.sendtime =  new Date();
		dao.saveOrUpdate(tvc);
		mv.data.put("result", 0);
		return mv;
	}
}
